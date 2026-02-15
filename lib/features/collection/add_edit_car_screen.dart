import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:image_picker/image_picker.dart';
import '../../core/errors/error_handler.dart';
import '../../core/utils/image_utils.dart';
import '../../core/utils/validators.dart';
import '../../models/car_model.dart';
import '../../providers/car_providers.dart';
import '../../providers/image_providers.dart';

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

  final List<File> _pendingImages = [];
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
      final file = File(picked.path);
      if (!ImageUtils.isValidImageSize(file)) {
        if (mounted) {
          ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(content: Text('Image must be under 10 MB')),
          );
        }
        return;
      }
      setState(() => _pendingImages.add(file));
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
      setState(() => _pendingImages.add(File(picked.path)));
    }
  }

  Future<void> _save() async {
    if (!_formKey.currentState!.validate()) return;

    final name = _nameController.text.trim();
    final series = _seriesController.text.trim();
    final yearText = _yearController.text.trim();
    final notes = _notesController.text.trim();
    final year = yearText.isEmpty ? null : int.tryParse(yearText);

    try {
      if (widget.isEditing) {
        await ref.read(updateCarProvider.notifier).call(
              widget.carId!,
              {
                'name': name,
                'series': series,
                'year': year,
                'notes': notes,
              },
            );
        // Upload any new images
        for (final file in _pendingImages) {
          await ref.read(uploadCarImageProvider.notifier).call(
                carId: widget.carId!,
                file: file,
              );
        }
      } else {
        final car = HotWheelsCar(name: name, series: series, year: year, notes: notes);
        final carId = await ref.read(addCarProvider.notifier).call(car);
        if (carId != null) {
          // Upload images for the new car
          for (var i = 0; i < _pendingImages.length; i++) {
            await ref.read(uploadCarImageProvider.notifier).call(
                  carId: carId,
                  file: _pendingImages[i],
                  isPrimary: i == 0,
                );
          }
        }
      }

      if (mounted) context.pop();
    } catch (e) {
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text(ErrorHandler.userMessage(e))),
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
                onDeleteExisting: (image) {
                  ref.read(deleteCarImageProvider.notifier).call(
                        carId: widget.carId!,
                        image: image,
                      );
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

  final List<File> pendingImages;
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
              child: Image.file(entry.value, fit: BoxFit.cover),
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
