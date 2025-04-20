// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'posts_repository.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

String _$postsRepositoryHash() => r'a16b075018e5f5c3ddd42b2f1e32e2ecdd411887';

/// See also [postsRepository].
@ProviderFor(postsRepository)
final postsRepositoryProvider = Provider<PostsRepository>.internal(
  postsRepository,
  name: r'postsRepositoryProvider',
  debugGetCreateSourceHash:
      const bool.fromEnvironment('dart.vm.product')
          ? null
          : _$postsRepositoryHash,
  dependencies: null,
  allTransitiveDependencies: null,
);

@Deprecated('Will be removed in 3.0. Use Ref instead')
// ignore: unused_element
typedef PostsRepositoryRef = ProviderRef<PostsRepository>;
String _$postsHash() => r'a33e2fb1e9f3bc71b3d8ac104efe93f60431bc2b';

/// See also [posts].
@ProviderFor(posts)
final postsProvider = AutoDisposeStreamProvider<List<Post>>.internal(
  posts,
  name: r'postsProvider',
  debugGetCreateSourceHash:
      const bool.fromEnvironment('dart.vm.product') ? null : _$postsHash,
  dependencies: null,
  allTransitiveDependencies: null,
);

@Deprecated('Will be removed in 3.0. Use Ref instead')
// ignore: unused_element
typedef PostsRef = AutoDisposeStreamProviderRef<List<Post>>;
String _$userPostHash() => r'b0257a88c79e9341e02dc52929e1b06e7c6cff6f';

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

/// See also [userPost].
@ProviderFor(userPost)
const userPostProvider = UserPostFamily();

/// See also [userPost].
class UserPostFamily extends Family<AsyncValue<Post>> {
  /// See also [userPost].
  const UserPostFamily();

  /// See also [userPost].
  UserPostProvider call(String userId, String postId) {
    return UserPostProvider(userId, postId);
  }

  @override
  UserPostProvider getProviderOverride(covariant UserPostProvider provider) {
    return call(provider.userId, provider.postId);
  }

  static const Iterable<ProviderOrFamily>? _dependencies = null;

  @override
  Iterable<ProviderOrFamily>? get dependencies => _dependencies;

  static const Iterable<ProviderOrFamily>? _allTransitiveDependencies = null;

  @override
  Iterable<ProviderOrFamily>? get allTransitiveDependencies =>
      _allTransitiveDependencies;

  @override
  String? get name => r'userPostProvider';
}

/// See also [userPost].
class UserPostProvider extends AutoDisposeStreamProvider<Post> {
  /// See also [userPost].
  UserPostProvider(String userId, String postId)
    : this._internal(
        (ref) => userPost(ref as UserPostRef, userId, postId),
        from: userPostProvider,
        name: r'userPostProvider',
        debugGetCreateSourceHash:
            const bool.fromEnvironment('dart.vm.product')
                ? null
                : _$userPostHash,
        dependencies: UserPostFamily._dependencies,
        allTransitiveDependencies: UserPostFamily._allTransitiveDependencies,
        userId: userId,
        postId: postId,
      );

  UserPostProvider._internal(
    super._createNotifier, {
    required super.name,
    required super.dependencies,
    required super.allTransitiveDependencies,
    required super.debugGetCreateSourceHash,
    required super.from,
    required this.userId,
    required this.postId,
  }) : super.internal();

  final String userId;
  final String postId;

  @override
  Override overrideWith(Stream<Post> Function(UserPostRef provider) create) {
    return ProviderOverride(
      origin: this,
      override: UserPostProvider._internal(
        (ref) => create(ref as UserPostRef),
        from: from,
        name: null,
        dependencies: null,
        allTransitiveDependencies: null,
        debugGetCreateSourceHash: null,
        userId: userId,
        postId: postId,
      ),
    );
  }

  @override
  AutoDisposeStreamProviderElement<Post> createElement() {
    return _UserPostProviderElement(this);
  }

  @override
  bool operator ==(Object other) {
    return other is UserPostProvider &&
        other.userId == userId &&
        other.postId == postId;
  }

  @override
  int get hashCode {
    var hash = _SystemHash.combine(0, runtimeType.hashCode);
    hash = _SystemHash.combine(hash, userId.hashCode);
    hash = _SystemHash.combine(hash, postId.hashCode);

    return _SystemHash.finish(hash);
  }
}

@Deprecated('Will be removed in 3.0. Use Ref instead')
// ignore: unused_element
mixin UserPostRef on AutoDisposeStreamProviderRef<Post> {
  /// The parameter `userId` of this provider.
  String get userId;

  /// The parameter `postId` of this provider.
  String get postId;
}

class _UserPostProviderElement extends AutoDisposeStreamProviderElement<Post>
    with UserPostRef {
  _UserPostProviderElement(super.provider);

  @override
  String get userId => (origin as UserPostProvider).userId;
  @override
  String get postId => (origin as UserPostProvider).postId;
}

// ignore_for_file: type=lint
// ignore_for_file: subtype_of_sealed_class, invalid_use_of_internal_member, invalid_use_of_visible_for_testing_member, deprecated_member_use_from_same_package
