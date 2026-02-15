// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'auth_provider.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

String _$authServiceHash() => r'1a086f396b6916ee8c5a9a14df3ece637f134805';

/// See also [authService].
@ProviderFor(authService)
final authServiceProvider = Provider<AuthService>.internal(
  authService,
  name: r'authServiceProvider',
  debugGetCreateSourceHash: const bool.fromEnvironment('dart.vm.product')
      ? null
      : _$authServiceHash,
  dependencies: null,
  allTransitiveDependencies: null,
);

@Deprecated('Will be removed in 3.0. Use Ref instead')
// ignore: unused_element
typedef AuthServiceRef = ProviderRef<AuthService>;
String _$authStateHash() => r'717511aaf372cc1336681b0d5d9a60ee40e1fa23';

/// See also [authState].
@ProviderFor(authState)
final authStateProvider = StreamProvider<User?>.internal(
  authState,
  name: r'authStateProvider',
  debugGetCreateSourceHash: const bool.fromEnvironment('dart.vm.product')
      ? null
      : _$authStateHash,
  dependencies: null,
  allTransitiveDependencies: null,
);

@Deprecated('Will be removed in 3.0. Use Ref instead')
// ignore: unused_element
typedef AuthStateRef = StreamProviderRef<User?>;
String _$signInHash() => r'91ae7cd7a0d24c7d3ca4b676a83fa2533d5b2e39';

/// See also [SignIn].
@ProviderFor(SignIn)
final signInProvider = AutoDisposeAsyncNotifierProvider<SignIn, void>.internal(
  SignIn.new,
  name: r'signInProvider',
  debugGetCreateSourceHash: const bool.fromEnvironment('dart.vm.product')
      ? null
      : _$signInHash,
  dependencies: null,
  allTransitiveDependencies: null,
);

typedef _$SignIn = AutoDisposeAsyncNotifier<void>;
String _$signOutHash() => r'd353f3252ef2ae2acd5cd5fb38d9eea427f4ac69';

/// See also [SignOut].
@ProviderFor(SignOut)
final signOutProvider =
    AutoDisposeAsyncNotifierProvider<SignOut, void>.internal(
      SignOut.new,
      name: r'signOutProvider',
      debugGetCreateSourceHash: const bool.fromEnvironment('dart.vm.product')
          ? null
          : _$signOutHash,
      dependencies: null,
      allTransitiveDependencies: null,
    );

typedef _$SignOut = AutoDisposeAsyncNotifier<void>;
// ignore_for_file: type=lint
// ignore_for_file: subtype_of_sealed_class, invalid_use_of_internal_member, invalid_use_of_visible_for_testing_member, deprecated_member_use_from_same_package
