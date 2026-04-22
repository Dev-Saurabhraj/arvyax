// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'ambience.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models');

Ambience _$AmbienceFromJson(Map<String, dynamic> json) {
  return _Ambience.fromJson(json);
}

/// @nodoc
mixin _$Ambience {
  @HiveField(0)
  @HiveField(0)
  String get id => throw _privateConstructorUsedError;
  @HiveField(1)
  String get title => throw _privateConstructorUsedError;
  @HiveField(2)
  String get tag => throw _privateConstructorUsedError;
  @HiveField(3)
  int get durationInSeconds => throw _privateConstructorUsedError;
  @HiveField(4)
  String get description => throw _privateConstructorUsedError;
  @HiveField(5)
  String get imageUrl => throw _privateConstructorUsedError;
  @HiveField(6)
  List<String> get sensoryRecipe => throw _privateConstructorUsedError;
  @HiveField(7)
  String get audioPath => throw _privateConstructorUsedError;

  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;
  @JsonKey(ignore: true)
  $AmbienceCopyWith<Ambience> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $AmbienceCopyWith<$Res> {
  factory $AmbienceCopyWith(Ambience value, $Res Function(Ambience) then) =
      _$AmbienceCopyWithImpl<$Res, Ambience>;
  @useResult
  $Res call(
      {@HiveField(0) @HiveField(0) String id,
      @HiveField(1) String title,
      @HiveField(2) String tag,
      @HiveField(3) int durationInSeconds,
      @HiveField(4) String description,
      @HiveField(5) String imageUrl,
      @HiveField(6) List<String> sensoryRecipe,
      @HiveField(7) String audioPath});
}

/// @nodoc
class _$AmbienceCopyWithImpl<$Res, $Val extends Ambience>
    implements $AmbienceCopyWith<$Res> {
  _$AmbienceCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? title = null,
    Object? tag = null,
    Object? durationInSeconds = null,
    Object? description = null,
    Object? imageUrl = null,
    Object? sensoryRecipe = null,
    Object? audioPath = null,
  }) {
    return _then(_value.copyWith(
      id: null == id
          ? _value.id
          : id // ignore: cast_nullable_to_non_nullable
              as String,
      title: null == title
          ? _value.title
          : title // ignore: cast_nullable_to_non_nullable
              as String,
      tag: null == tag
          ? _value.tag
          : tag // ignore: cast_nullable_to_non_nullable
              as String,
      durationInSeconds: null == durationInSeconds
          ? _value.durationInSeconds
          : durationInSeconds // ignore: cast_nullable_to_non_nullable
              as int,
      description: null == description
          ? _value.description
          : description // ignore: cast_nullable_to_non_nullable
              as String,
      imageUrl: null == imageUrl
          ? _value.imageUrl
          : imageUrl // ignore: cast_nullable_to_non_nullable
              as String,
      sensoryRecipe: null == sensoryRecipe
          ? _value.sensoryRecipe
          : sensoryRecipe // ignore: cast_nullable_to_non_nullable
              as List<String>,
      audioPath: null == audioPath
          ? _value.audioPath
          : audioPath // ignore: cast_nullable_to_non_nullable
              as String,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$AmbienceImplCopyWith<$Res>
    implements $AmbienceCopyWith<$Res> {
  factory _$$AmbienceImplCopyWith(
          _$AmbienceImpl value, $Res Function(_$AmbienceImpl) then) =
      __$$AmbienceImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {@HiveField(0) @HiveField(0) String id,
      @HiveField(1) String title,
      @HiveField(2) String tag,
      @HiveField(3) int durationInSeconds,
      @HiveField(4) String description,
      @HiveField(5) String imageUrl,
      @HiveField(6) List<String> sensoryRecipe,
      @HiveField(7) String audioPath});
}

/// @nodoc
class __$$AmbienceImplCopyWithImpl<$Res>
    extends _$AmbienceCopyWithImpl<$Res, _$AmbienceImpl>
    implements _$$AmbienceImplCopyWith<$Res> {
  __$$AmbienceImplCopyWithImpl(
      _$AmbienceImpl _value, $Res Function(_$AmbienceImpl) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? title = null,
    Object? tag = null,
    Object? durationInSeconds = null,
    Object? description = null,
    Object? imageUrl = null,
    Object? sensoryRecipe = null,
    Object? audioPath = null,
  }) {
    return _then(_$AmbienceImpl(
      id: null == id
          ? _value.id
          : id // ignore: cast_nullable_to_non_nullable
              as String,
      title: null == title
          ? _value.title
          : title // ignore: cast_nullable_to_non_nullable
              as String,
      tag: null == tag
          ? _value.tag
          : tag // ignore: cast_nullable_to_non_nullable
              as String,
      durationInSeconds: null == durationInSeconds
          ? _value.durationInSeconds
          : durationInSeconds // ignore: cast_nullable_to_non_nullable
              as int,
      description: null == description
          ? _value.description
          : description // ignore: cast_nullable_to_non_nullable
              as String,
      imageUrl: null == imageUrl
          ? _value.imageUrl
          : imageUrl // ignore: cast_nullable_to_non_nullable
              as String,
      sensoryRecipe: null == sensoryRecipe
          ? _value._sensoryRecipe
          : sensoryRecipe // ignore: cast_nullable_to_non_nullable
              as List<String>,
      audioPath: null == audioPath
          ? _value.audioPath
          : audioPath // ignore: cast_nullable_to_non_nullable
              as String,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$AmbienceImpl implements _Ambience {
  const _$AmbienceImpl(
      {@HiveField(0) @HiveField(0) required this.id,
      @HiveField(1) required this.title,
      @HiveField(2) required this.tag,
      @HiveField(3) required this.durationInSeconds,
      @HiveField(4) required this.description,
      @HiveField(5) required this.imageUrl,
      @HiveField(6) required final List<String> sensoryRecipe,
      @HiveField(7) required this.audioPath})
      : _sensoryRecipe = sensoryRecipe;

  factory _$AmbienceImpl.fromJson(Map<String, dynamic> json) =>
      _$$AmbienceImplFromJson(json);

  @override
  @HiveField(0)
  @HiveField(0)
  final String id;
  @override
  @HiveField(1)
  final String title;
  @override
  @HiveField(2)
  final String tag;
  @override
  @HiveField(3)
  final int durationInSeconds;
  @override
  @HiveField(4)
  final String description;
  @override
  @HiveField(5)
  final String imageUrl;
  final List<String> _sensoryRecipe;
  @override
  @HiveField(6)
  List<String> get sensoryRecipe {
    if (_sensoryRecipe is EqualUnmodifiableListView) return _sensoryRecipe;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_sensoryRecipe);
  }

  @override
  @HiveField(7)
  final String audioPath;

  @override
  String toString() {
    return 'Ambience(id: $id, title: $title, tag: $tag, durationInSeconds: $durationInSeconds, description: $description, imageUrl: $imageUrl, sensoryRecipe: $sensoryRecipe, audioPath: $audioPath)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$AmbienceImpl &&
            (identical(other.id, id) || other.id == id) &&
            (identical(other.title, title) || other.title == title) &&
            (identical(other.tag, tag) || other.tag == tag) &&
            (identical(other.durationInSeconds, durationInSeconds) ||
                other.durationInSeconds == durationInSeconds) &&
            (identical(other.description, description) ||
                other.description == description) &&
            (identical(other.imageUrl, imageUrl) ||
                other.imageUrl == imageUrl) &&
            const DeepCollectionEquality()
                .equals(other._sensoryRecipe, _sensoryRecipe) &&
            (identical(other.audioPath, audioPath) ||
                other.audioPath == audioPath));
  }

  @JsonKey(ignore: true)
  @override
  int get hashCode => Object.hash(
      runtimeType,
      id,
      title,
      tag,
      durationInSeconds,
      description,
      imageUrl,
      const DeepCollectionEquality().hash(_sensoryRecipe),
      audioPath);

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$AmbienceImplCopyWith<_$AmbienceImpl> get copyWith =>
      __$$AmbienceImplCopyWithImpl<_$AmbienceImpl>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$AmbienceImplToJson(
      this,
    );
  }
}

abstract class _Ambience implements Ambience {
  const factory _Ambience(
      {@HiveField(0) @HiveField(0) required final String id,
      @HiveField(1) required final String title,
      @HiveField(2) required final String tag,
      @HiveField(3) required final int durationInSeconds,
      @HiveField(4) required final String description,
      @HiveField(5) required final String imageUrl,
      @HiveField(6) required final List<String> sensoryRecipe,
      @HiveField(7) required final String audioPath}) = _$AmbienceImpl;

  factory _Ambience.fromJson(Map<String, dynamic> json) =
      _$AmbienceImpl.fromJson;

  @override
  @HiveField(0)
  @HiveField(0)
  String get id;
  @override
  @HiveField(1)
  String get title;
  @override
  @HiveField(2)
  String get tag;
  @override
  @HiveField(3)
  int get durationInSeconds;
  @override
  @HiveField(4)
  String get description;
  @override
  @HiveField(5)
  String get imageUrl;
  @override
  @HiveField(6)
  List<String> get sensoryRecipe;
  @override
  @HiveField(7)
  String get audioPath;
  @override
  @JsonKey(ignore: true)
  _$$AmbienceImplCopyWith<_$AmbienceImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
