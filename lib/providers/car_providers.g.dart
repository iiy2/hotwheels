// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'car_providers.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

String _$firestoreServiceHash() => r'ff1c1da852a69caf594a40f0fa0fd140c10fd82e';

/// See also [firestoreService].
@ProviderFor(firestoreService)
final firestoreServiceProvider = Provider<FirestoreService>.internal(
  firestoreService,
  name: r'firestoreServiceProvider',
  debugGetCreateSourceHash: const bool.fromEnvironment('dart.vm.product')
      ? null
      : _$firestoreServiceHash,
  dependencies: null,
  allTransitiveDependencies: null,
);

@Deprecated('Will be removed in 3.0. Use Ref instead')
// ignore: unused_element
typedef FirestoreServiceRef = ProviderRef<FirestoreService>;
String _$storageServiceHash() => r'62cbe9319bc400f2f78b16bce45d667585b592a2';

/// See also [storageService].
@ProviderFor(storageService)
final storageServiceProvider = Provider<StorageService>.internal(
  storageService,
  name: r'storageServiceProvider',
  debugGetCreateSourceHash: const bool.fromEnvironment('dart.vm.product')
      ? null
      : _$storageServiceHash,
  dependencies: null,
  allTransitiveDependencies: null,
);

@Deprecated('Will be removed in 3.0. Use Ref instead')
// ignore: unused_element
typedef StorageServiceRef = ProviderRef<StorageService>;
String _$carsStreamHash() => r'19b7b1f2a207a174b7763c0cb8b8c522e9163fbf';

/// See also [carsStream].
@ProviderFor(carsStream)
final carsStreamProvider =
    AutoDisposeStreamProvider<List<HotWheelsCar>>.internal(
      carsStream,
      name: r'carsStreamProvider',
      debugGetCreateSourceHash: const bool.fromEnvironment('dart.vm.product')
          ? null
          : _$carsStreamHash,
      dependencies: null,
      allTransitiveDependencies: null,
    );

@Deprecated('Will be removed in 3.0. Use Ref instead')
// ignore: unused_element
typedef CarsStreamRef = AutoDisposeStreamProviderRef<List<HotWheelsCar>>;
String _$carStreamHash() => r'b9edbdd91a8e5b81a5a6b780d58f302d0265d052';

/// Copied from Dart SDK
class _SystemHash {
  _SystemHash._();

  static int combine(int hash, int value) {
    // ignore: parameter_assignments
    hash = 0x1fffffff & (hash + value);
    // ignore: parameter_assignments
    hash = 0x1fffffff & (hash + ((0x0007ffff & hash) << 10));
    return hash ^ (hash >> 6);
  }

  static int finish(int hash) {
    // ignore: parameter_assignments
    hash = 0x1fffffff & (hash + ((0x03ffffff & hash) << 3));
    // ignore: parameter_assignments
    hash = hash ^ (hash >> 11);
    return 0x1fffffff & (hash + ((0x00003fff & hash) << 15));
  }
}

/// See also [carStream].
@ProviderFor(carStream)
const carStreamProvider = CarStreamFamily();

/// See also [carStream].
class CarStreamFamily extends Family<AsyncValue<HotWheelsCar?>> {
  /// See also [carStream].
  const CarStreamFamily();

  /// See also [carStream].
  CarStreamProvider call(String carId) {
    return CarStreamProvider(carId);
  }

  @override
  CarStreamProvider getProviderOverride(covariant CarStreamProvider provider) {
    return call(provider.carId);
  }

  static const Iterable<ProviderOrFamily>? _dependencies = null;

  @override
  Iterable<ProviderOrFamily>? get dependencies => _dependencies;

  static const Iterable<ProviderOrFamily>? _allTransitiveDependencies = null;

  @override
  Iterable<ProviderOrFamily>? get allTransitiveDependencies =>
      _allTransitiveDependencies;

  @override
  String? get name => r'carStreamProvider';
}

/// See also [carStream].
class CarStreamProvider extends AutoDisposeStreamProvider<HotWheelsCar?> {
  /// See also [carStream].
  CarStreamProvider(String carId)
    : this._internal(
        (ref) => carStream(ref as CarStreamRef, carId),
        from: carStreamProvider,
        name: r'carStreamProvider',
        debugGetCreateSourceHash: const bool.fromEnvironment('dart.vm.product')
            ? null
            : _$carStreamHash,
        dependencies: CarStreamFamily._dependencies,
        allTransitiveDependencies: CarStreamFamily._allTransitiveDependencies,
        carId: carId,
      );

  CarStreamProvider._internal(
    super._createNotifier, {
    required super.name,
    required super.dependencies,
    required super.allTransitiveDependencies,
    required super.debugGetCreateSourceHash,
    required super.from,
    required this.carId,
  }) : super.internal();

  final String carId;

  @override
  Override overrideWith(
    Stream<HotWheelsCar?> Function(CarStreamRef provider) create,
  ) {
    return ProviderOverride(
      origin: this,
      override: CarStreamProvider._internal(
        (ref) => create(ref as CarStreamRef),
        from: from,
        name: null,
        dependencies: null,
        allTransitiveDependencies: null,
        debugGetCreateSourceHash: null,
        carId: carId,
      ),
    );
  }

  @override
  AutoDisposeStreamProviderElement<HotWheelsCar?> createElement() {
    return _CarStreamProviderElement(this);
  }

  @override
  bool operator ==(Object other) {
    return other is CarStreamProvider && other.carId == carId;
  }

  @override
  int get hashCode {
    var hash = _SystemHash.combine(0, runtimeType.hashCode);
    hash = _SystemHash.combine(hash, carId.hashCode);

    return _SystemHash.finish(hash);
  }
}

@Deprecated('Will be removed in 3.0. Use Ref instead')
// ignore: unused_element
mixin CarStreamRef on AutoDisposeStreamProviderRef<HotWheelsCar?> {
  /// The parameter `carId` of this provider.
  String get carId;
}

class _CarStreamProviderElement
    extends AutoDisposeStreamProviderElement<HotWheelsCar?>
    with CarStreamRef {
  _CarStreamProviderElement(super.provider);

  @override
  String get carId => (origin as CarStreamProvider).carId;
}

String _$addCarHash() => r'ddfe3ba13e511e55d786884cea68819756d4289f';

/// See also [AddCar].
@ProviderFor(AddCar)
final addCarProvider =
    AutoDisposeAsyncNotifierProvider<AddCar, String?>.internal(
      AddCar.new,
      name: r'addCarProvider',
      debugGetCreateSourceHash: const bool.fromEnvironment('dart.vm.product')
          ? null
          : _$addCarHash,
      dependencies: null,
      allTransitiveDependencies: null,
    );

typedef _$AddCar = AutoDisposeAsyncNotifier<String?>;
String _$updateCarHash() => r'00b98d311a7966dc851923a99ca444f2569fea50';

/// See also [UpdateCar].
@ProviderFor(UpdateCar)
final updateCarProvider =
    AutoDisposeAsyncNotifierProvider<UpdateCar, void>.internal(
      UpdateCar.new,
      name: r'updateCarProvider',
      debugGetCreateSourceHash: const bool.fromEnvironment('dart.vm.product')
          ? null
          : _$updateCarHash,
      dependencies: null,
      allTransitiveDependencies: null,
    );

typedef _$UpdateCar = AutoDisposeAsyncNotifier<void>;
String _$deleteCarHash() => r'dffe5e96cf7705f396f271d5c0f124f218eca229';

/// See also [DeleteCar].
@ProviderFor(DeleteCar)
final deleteCarProvider =
    AutoDisposeAsyncNotifierProvider<DeleteCar, void>.internal(
      DeleteCar.new,
      name: r'deleteCarProvider',
      debugGetCreateSourceHash: const bool.fromEnvironment('dart.vm.product')
          ? null
          : _$deleteCarHash,
      dependencies: null,
      allTransitiveDependencies: null,
    );

typedef _$DeleteCar = AutoDisposeAsyncNotifier<void>;
// ignore_for_file: type=lint
// ignore_for_file: subtype_of_sealed_class, invalid_use_of_internal_member, invalid_use_of_visible_for_testing_member, deprecated_member_use_from_same_package
