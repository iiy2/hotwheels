import 'dart:io';
import 'dart:typed_data';
import 'package:flutter/foundation.dart' show kIsWeb;
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:image_picker/image_picker.dart';
import '../../core/utils/image_utils.dart';
import '../../core/utils/validators.dart';
import '../../models/car_model.dart';
import '../../providers/auth_provider.dart';
import '../../providers/car_providers.dart';

class _PendingImage {
  _PendingImage(this.xfile, this.bytes);
  final XFile xfile;
  final Uint8List bytes;
}

class AddEditCarScreen extends ConsumerStatefulWidget {
  const AddEditCarScreen({super.key, this.carId});

  final String? carId;

  bool get isEditing => carId != null;

  @override
  ConsumerState<AddEditCarScreen> createState() => _AddEditCarScreenState();
}

class _AddEditCarScreenState extends ConsumerState<AddEditCarScreen> {
  final _formKey = GlobalKey<FormState>();
  final _nameController = TextEditingController();
  final _seriesController = TextEditingController();
  final _yearController = TextEditingController();
  final _notesController = TextEditingController();
  final _picker = ImagePicker();

  final List<_PendingImage> _pendingImages = [];
  bool _initialized = false;

  @override
  void dispose() {
    _nameController.dispose();
    _seriesController.dispose();
    _yearController.dispose();
    _notesController.dispose();
    super.dispose();
  }

  void _initFromCar(HotWheelsCar car) {
    if (_initialized) return;
    _initialized = true;
    _nameController.text = car.name;
    _seriesController.text = car.series;
    _yearController.text = car.year?.toString() ?? '';
    _notesController.text = car.notes;
  }

  Future<void> _pickImage() async {
    final picked = await _picker.pickImage(
      source: ImageSource.gallery,
      maxWidth: 1920,
      maxHeight: 1920,
      imageQuality: 85,
    );
    if (picked != null) {
      if (!kIsWeb) {
        final file = File(picked.path);
        if (!ImageUtils.isValidImageSize(file)) {
          if (mounted) {
            ScaffoldMessenger.of(context).showSnackBar(
              const SnackBar(content: Text('Image must be under 10 MB')),
            );
          }
          return;
        }
      }
      final bytes = await picked.readAsBytes();
      setState(() => _pendingImages.add(_PendingImage(picked, bytes)));
    }
  }

  Future<void> _takePhoto() async {
    final picked = await _picker.pickImage(
      source: ImageSource.camera,
      maxWidth: 1920,
      maxHeight: 1920,
      imageQuality: 85,
    );
    if (picked != null) {
      final bytes = await picked.readAsBytes();
      setState(() => _pendingImages.add(_PendingImage(picked, bytes)));
    }
  }

  Future<CarImage> _uploadImage({
    required String userId,
    required String carId,
    required _PendingImage pending,
    bool isPrimary = false,
  }) async {
    final imageId = ImageUtils.generateImageId();
    final contentType =
        pending.xfile.mimeType ?? ImageUtils.mimeTypeFromExtension(pending.xfile.name);

    debugPrint('[UPLOAD] userId=$userId carId=$carId imageId=$imageId');
    debugPrint('[UPLOAD] bytes=${pending.bytes.length} contentType=$contentType');

    final url = await ref.read(storageServiceProvider).uploadCarImage(
          userId: userId,
          carId: carId,
          imageId: imageId,
          bytes: pending.bytes,
          contentType: contentType,
        );

    debugPrint('[UPLOAD] SUCCESS url=$url');

    return CarImage(
      id: imageId,
      url: url,
      storagePath: 'users/$userId/cars/$carId/$imageId.jpg',
      isPrimary: isPrimary,
      createdAt: DateTime.now(),
    );
  }

  Future<void> _save() async {
    if (!_formKey.currentState!.validate()) return;

    final user = ref.read(authStateProvider).valueOrNull;
    if (user == null) return;
    final userId = user.uid;
    final firestoreService = ref.read(firestoreServiceProvider);

    final name = _nameController.text.trim();
    final series = _seriesController.text.trim();
    final yearText = _yearController.text.trim();
    final notes = _notesController.text.trim();
    final year = yearText.isEmpty ? null : int.tryParse(yearText);

    debugPrint('[SAVE] pendingImages=${_pendingImages.length} isEditing=${widget.isEditing}');

    try {
      if (widget.isEditing) {
        await firestoreService.updateCar(userId, widget.carId!, {
          'name': name,
          'series': series,
          'year': year,
          'notes': notes,
        });
        // Upload any new images
        if (_pendingImages.isNotEmpty) {
          final carData = await ref.read(carStreamProvider(widget.carId!).future);
          final existingImages = carData?.images ?? [];
          final newImages = <CarImage>[];
          for (final pending in _pendingImages) {
            newImages.add(await _uploadImage(
              userId: userId,
              carId: widget.carId!,
              pending: pending,
            ));
          }
          await firestoreService.updateCar(userId, widget.carId!, {
            'images': [...existingImages, ...newImages]
                .map((i) => i.toJson())
                .toList(),
          });
        }
      } else {
        final car = HotWheelsCar(
            name: name, series: series, year: year, notes: notes);
        final carId = await firestoreService.addCar(userId, car);
        // Upload images for the new car
        if (_pendingImages.isNotEmpty) {
          final images = <CarImage>[];
          for (var i = 0; i < _pendingImages.length; i++) {
            images.add(await _uploadImage(
              userId: userId,
              carId: carId,
              pending: _pendingImages[i],
              isPrimary: i == 0,
            ));
          }
          await firestoreService.updateCar(userId, carId, {
            'images': images.map((i) => i.toJson()).toList(),
          });
        }
      }

      if (mounted) context.pop();
    } catch (e, st) {
      debugPrint('Save error: $e\n$st');
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text('Error: $e'),
            duration: const Duration(seconds: 10),
          ),
        );
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    // If editing, load the car data
    if (widget.isEditing) {
      final carAsync = ref.watch(carStreamProvider(widget.carId!));
      carAsync.whenData((car) {
        if (car != null) _initFromCar(car);
      });
    }

    return Scaffold(
      appBar: AppBar(
        title: Text(widget.isEditing ? 'Edit Car' : 'Add Car'),
        actions: [
          TextButton(
            onPressed: _save,
            child: Text(
              'Save',
              style: TextStyle(color: Theme.of(context).colorScheme.onPrimary),
            ),
          ),
        ],
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Form(
          key: _formKey,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              TextFormField(
                controller: _nameController,
                decoration: const InputDecoration(labelText: 'Name *'),
                validator: Validators.carName,
                textCapitalization: TextCapitalization.words,
              ),
              const SizedBox(height: 16),
              TextFormField(
                controller: _seriesController,
                decoration: const InputDecoration(labelText: 'Series'),
                validator: Validators.carSeries,
                textCapitalization: TextCapitalization.words,
              ),
              const SizedBox(height: 16),
              TextFormField(
                controller: _yearController,
                decoration: const InputDecoration(labelText: 'Year'),
                validator: Validators.carYear,
                keyboardType: TextInputType.number,
              ),
              const SizedBox(height: 16),
              TextFormField(
                controller: _notesController,
                decoration: const InputDecoration(labelText: 'Notes'),
                maxLines: 3,
                textCapitalization: TextCapitalization.sentences,
              ),
              const SizedBox(height: 24),
              Text('Photos',
                  style: Theme.of(context).textTheme.titleMedium),
              const SizedBox(height: 8),
              _ImageGrid(
                pendingImages: _pendingImages,
                existingImages: widget.isEditing
                    ? ref
                            .watch(carStreamProvider(widget.carId!))
                            .valueOrNull
                            ?.images ??
                        []
                    : [],
                onRemovePending: (index) {
                  setState(() => _pendingImages.removeAt(index));
                },
                onDeleteExisting: (image) async {
                  final user = ref.read(authStateProvider).valueOrNull;
                  if (user == null) return;
                  final userId = user.uid;
                  try {
                    await ref.read(storageServiceProvider).deleteCarImage(
                          userId: userId,
                          carId: widget.carId!,
                          imageId: image.id,
                        );
                    final carData = await ref
                        .read(carStreamProvider(widget.carId!).future);
                    if (carData != null) {
                      final updated = carData.images
                          .where((i) => i.id != image.id)
                          .toList();
                      await ref
                          .read(firestoreServiceProvider)
                          .updateCar(userId, widget.carId!, {
                        'images':
                            updated.map((i) => i.toJson()).toList(),
                      });
                    }
                  } catch (e) {
                    if (mounted) {
                      ScaffoldMessenger.of(context).showSnackBar(
                        SnackBar(content: Text('Error: $e')),
                      );
                    }
                  }
                },
              ),
              const SizedBox(height: 8),
              Row(
                children: [
                  Expanded(
                    child: OutlinedButton.icon(
                      onPressed: _pickImage,
                      icon: const Icon(Icons.photo_library),
                      label: const Text('Gallery'),
                    ),
                  ),
                  const SizedBox(width: 8),
                  Expanded(
                    child: OutlinedButton.icon(
                      onPressed: _takePhoto,
                      icon: const Icon(Icons.camera_alt),
                      label: const Text('Camera'),
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class _ImageGrid extends StatelessWidget {
  const _ImageGrid({
    required this.pendingImages,
    required this.existingImages,
    required this.onRemovePending,
    required this.onDeleteExisting,
  });

  final List<_PendingImage> pendingImages;
  final List<CarImage> existingImages;
  final void Function(int index) onRemovePending;
  final void Function(CarImage image) onDeleteExisting;

  @override
  Widget build(BuildContext context) {
    if (existingImages.isEmpty && pendingImages.isEmpty) {
      return Container(
        height: 120,
        decoration: BoxDecoration(
          border: Border.all(color: Colors.grey.shade300),
          borderRadius: BorderRadius.circular(8),
        ),
        child: const Center(
          child: Text('No photos added', style: TextStyle(color: Colors.grey)),
        ),
      );
    }

    return SizedBox(
      height: 120,
      child: ListView(
        scrollDirection: Axis.horizontal,
        children: [
          ...existingImages.asMap().entries.map((entry) {
            final image = entry.value;
            return _ImageTile(
              child: Image.network(image.url, fit: BoxFit.cover),
              onRemove: () => onDeleteExisting(image),
            );
          }),
          ...pendingImages.asMap().entries.map((entry) {
            return _ImageTile(
              child: Image.memory(entry.value.bytes, fit: BoxFit.cover),
              onRemove: () => onRemovePending(entry.key),
            );
          }),
        ],
      ),
    );
  }
}

class _ImageTile extends StatelessWidget {
  const _ImageTile({required this.child, required this.onRemove});

  final Widget child;
  final VoidCallback onRemove;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(right: 8),
      child: Stack(
        children: [
          ClipRRect(
            borderRadius: BorderRadius.circular(8),
            child: SizedBox(width: 120, height: 120, child: child),
          ),
          Positioned(
            top: 4,
            right: 4,
            child: GestureDetector(
              onTap: onRemove,
              child: Container(
                decoration: const BoxDecoration(
                  color: Colors.black54,
                  shape: BoxShape.circle,
                ),
                padding: const EdgeInsets.all(4),
                child: const Icon(Icons.close, size: 16, color: Colors.white),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
