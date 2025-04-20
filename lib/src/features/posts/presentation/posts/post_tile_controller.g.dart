// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'post_tile_controller.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

String _$postOwnerHash() => r'0fbe273315ce859b14b276f7b042c23eb437ef96';

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

/// See also [postOwner].
@ProviderFor(postOwner)
const postOwnerProvider = PostOwnerFamily();

/// See also [postOwner].
class PostOwnerFamily extends Family<AsyncValue<AppUser>> {
  /// See also [postOwner].
  const PostOwnerFamily();

  /// See also [postOwner].
  PostOwnerProvider call(String postOwnerId) {
    return PostOwnerProvider(postOwnerId);
  }

  @override
  PostOwnerProvider getProviderOverride(covariant PostOwnerProvider provider) {
    return call(provider.postOwnerId);
  }

  static const Iterable<ProviderOrFamily>? _dependencies = null;

  @override
  Iterable<ProviderOrFamily>? get dependencies => _dependencies;

  static const Iterable<ProviderOrFamily>? _allTransitiveDependencies = null;

  @override
  Iterable<ProviderOrFamily>? get allTransitiveDependencies =>
      _allTransitiveDependencies;

  @override
  String? get name => r'postOwnerProvider';
}

/// See also [postOwner].
class PostOwnerProvider extends AutoDisposeFutureProvider<AppUser> {
  /// See also [postOwner].
  PostOwnerProvider(String postOwnerId)
    : this._internal(
        (ref) => postOwner(ref as PostOwnerRef, postOwnerId),
        from: postOwnerProvider,
        name: r'postOwnerProvider',
        debugGetCreateSourceHash:
            const bool.fromEnvironment('dart.vm.product')
                ? null
                : _$postOwnerHash,
        dependencies: PostOwnerFamily._dependencies,
        allTransitiveDependencies: PostOwnerFamily._allTransitiveDependencies,
        postOwnerId: postOwnerId,
      );

  PostOwnerProvider._internal(
    super._createNotifier, {
    required super.name,
    required super.dependencies,
    required super.allTransitiveDependencies,
    required super.debugGetCreateSourceHash,
    required super.from,
    required this.postOwnerId,
  }) : super.internal();

  final String postOwnerId;

  @override
  Override overrideWith(
    FutureOr<AppUser> Function(PostOwnerRef provider) create,
  ) {
    return ProviderOverride(
      origin: this,
      override: PostOwnerProvider._internal(
        (ref) => create(ref as PostOwnerRef),
        from: from,
        name: null,
        dependencies: null,
        allTransitiveDependencies: null,
        debugGetCreateSourceHash: null,
        postOwnerId: postOwnerId,
      ),
    );
  }

  @override
  AutoDisposeFutureProviderElement<AppUser> createElement() {
    return _PostOwnerProviderElement(this);
  }

  @override
  bool operator ==(Object other) {
    return other is PostOwnerProvider && other.postOwnerId == postOwnerId;
  }

  @override
  int get hashCode {
    var hash = _SystemHash.combine(0, runtimeType.hashCode);
    hash = _SystemHash.combine(hash, postOwnerId.hashCode);

    return _SystemHash.finish(hash);
  }
}

@Deprecated('Will be removed in 3.0. Use Ref instead')
// ignore: unused_element
mixin PostOwnerRef on AutoDisposeFutureProviderRef<AppUser> {
  /// The parameter `postOwnerId` of this provider.
  String get postOwnerId;
}

class _PostOwnerProviderElement
    extends AutoDisposeFutureProviderElement<AppUser>
    with PostOwnerRef {
  _PostOwnerProviderElement(super.provider);

  @override
  String get postOwnerId => (origin as PostOwnerProvider).postOwnerId;
}

String _$postTileControllerHash() =>
    r'0bafedfa1e43df13bd91af31ca1ae34c01e8022f';

/// See also [PostTileController].
@ProviderFor(PostTileController)
final postTileControllerProvider =
    AutoDisposeAsyncNotifierProvider<PostTileController, void>.internal(
      PostTileController.new,
      name: r'postTileControllerProvider',
      debugGetCreateSourceHash:
          const bool.fromEnvironment('dart.vm.product')
              ? null
              : _$postTileControllerHash,
      dependencies: null,
      allTransitiveDependencies: null,
    );

typedef _$PostTileController = AutoDisposeAsyncNotifier<void>;
// ignore_for_file: type=lint
// ignore_for_file: subtype_of_sealed_class, invalid_use_of_internal_member, invalid_use_of_visible_for_testing_member, deprecated_member_use_from_same_package
