// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'session_state.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models');

SessionState _$SessionStateFromJson(Map<String, dynamic> json) {
  return _SessionState.fromJson(json);
}

/// @nodoc
mixin _$SessionState {
  @HiveField(0)
  String? get id => throw _privateConstructorUsedError;
  @HiveField(1)
  Ambience? get ambience => throw _privateConstructorUsedError;
  @HiveField(2)
  bool get isPlaying => throw _privateConstructorUsedError;
  @HiveField(3)
  Duration get elapsed => throw _privateConstructorUsedError;
  @HiveField(4)
  DateTime? get startedAt => throw _privateConstructorUsedError;

  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;
  @JsonKey(ignore: true)
  $SessionStateCopyWith<SessionState> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $SessionStateCopyWith<$Res> {
  factory $SessionStateCopyWith(
          SessionState value, $Res Function(SessionState) then) =
      _$SessionStateCopyWithImpl<$Res, SessionState>;
  @useResult
  $Res call(
      {@HiveField(0) String? id,
      @HiveField(1) Ambience? ambience,
      @HiveField(2) bool isPlaying,
      @HiveField(3) Duration elapsed,
      @HiveField(4) DateTime? startedAt});

  $AmbienceCopyWith<$Res>? get ambience;
}

/// @nodoc
class _$SessionStateCopyWithImpl<$Res, $Val extends SessionState>
    implements $SessionStateCopyWith<$Res> {
  _$SessionStateCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = freezed,
    Object? ambience = freezed,
    Object? isPlaying = null,
    Object? elapsed = null,
    Object? startedAt = freezed,
  }) {
    return _then(_value.copyWith(
      id: freezed == id
          ? _value.id
          : id // ignore: cast_nullable_to_non_nullable
              as String?,
      ambience: freezed == ambience
          ? _value.ambience
          : ambience // ignore: cast_nullable_to_non_nullable
              as Ambience?,
      isPlaying: null == isPlaying
          ? _value.isPlaying
          : isPlaying // ignore: cast_nullable_to_non_nullable
              as bool,
      elapsed: null == elapsed
          ? _value.elapsed
          : elapsed // ignore: cast_nullable_to_non_nullable
              as Duration,
      startedAt: freezed == startedAt
          ? _value.startedAt
          : startedAt // ignore: cast_nullable_to_non_nullable
              as DateTime?,
    ) as $Val);
  }

  @override
  @pragma('vm:prefer-inline')
  $AmbienceCopyWith<$Res>? get ambience {
    if (_value.ambience == null) {
      return null;
    }

    return $AmbienceCopyWith<$Res>(_value.ambience!, (value) {
      return _then(_value.copyWith(ambience: value) as $Val);
    });
  }
}

/// @nodoc
abstract class _$$SessionStateImplCopyWith<$Res>
    implements $SessionStateCopyWith<$Res> {
  factory _$$SessionStateImplCopyWith(
          _$SessionStateImpl value, $Res Function(_$SessionStateImpl) then) =
      __$$SessionStateImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {@HiveField(0) String? id,
      @HiveField(1) Ambience? ambience,
      @HiveField(2) bool isPlaying,
      @HiveField(3) Duration elapsed,
      @HiveField(4) DateTime? startedAt});

  @override
  $AmbienceCopyWith<$Res>? get ambience;
}

/// @nodoc
class __$$SessionStateImplCopyWithImpl<$Res>
    extends _$SessionStateCopyWithImpl<$Res, _$SessionStateImpl>
    implements _$$SessionStateImplCopyWith<$Res> {
  __$$SessionStateImplCopyWithImpl(
      _$SessionStateImpl _value, $Res Function(_$SessionStateImpl) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = freezed,
    Object? ambience = freezed,
    Object? isPlaying = null,
    Object? elapsed = null,
    Object? startedAt = freezed,
  }) {
    return _then(_$SessionStateImpl(
      id: freezed == id
          ? _value.id
          : id // ignore: cast_nullable_to_non_nullable
              as String?,
      ambience: freezed == ambience
          ? _value.ambience
          : ambience // ignore: cast_nullable_to_non_nullable
              as Ambience?,
      isPlaying: null == isPlaying
          ? _value.isPlaying
          : isPlaying // ignore: cast_nullable_to_non_nullable
              as bool,
      elapsed: null == elapsed
          ? _value.elapsed
          : elapsed // ignore: cast_nullable_to_non_nullable
              as Duration,
      startedAt: freezed == startedAt
          ? _value.startedAt
          : startedAt // ignore: cast_nullable_to_non_nullable
              as DateTime?,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$SessionStateImpl extends _SessionState {
  const _$SessionStateImpl(
      {@HiveField(0) required this.id,
      @HiveField(1) required this.ambience,
      @HiveField(2) required this.isPlaying,
      @HiveField(3) required this.elapsed,
      @HiveField(4) required this.startedAt})
      : super._();

  factory _$SessionStateImpl.fromJson(Map<String, dynamic> json) =>
      _$$SessionStateImplFromJson(json);

  @override
  @HiveField(0)
  final String? id;
  @override
  @HiveField(1)
  final Ambience? ambience;
  @override
  @HiveField(2)
  final bool isPlaying;
  @override
  @HiveField(3)
  final Duration elapsed;
  @override
  @HiveField(4)
  final DateTime? startedAt;

  @override
  String toString() {
    return 'SessionState(id: $id, ambience: $ambience, isPlaying: $isPlaying, elapsed: $elapsed, startedAt: $startedAt)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$SessionStateImpl &&
            (identical(other.id, id) || other.id == id) &&
            (identical(other.ambience, ambience) ||
                other.ambience == ambience) &&
            (identical(other.isPlaying, isPlaying) ||
                other.isPlaying == isPlaying) &&
            (identical(other.elapsed, elapsed) || other.elapsed == elapsed) &&
            (identical(other.startedAt, startedAt) ||
                other.startedAt == startedAt));
  }

  @JsonKey(ignore: true)
  @override
  int get hashCode =>
      Object.hash(runtimeType, id, ambience, isPlaying, elapsed, startedAt);

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$SessionStateImplCopyWith<_$SessionStateImpl> get copyWith =>
      __$$SessionStateImplCopyWithImpl<_$SessionStateImpl>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$SessionStateImplToJson(
      this,
    );
  }
}

abstract class _SessionState extends SessionState {
  const factory _SessionState(
      {@HiveField(0) required final String? id,
      @HiveField(1) required final Ambience? ambience,
      @HiveField(2) required final bool isPlaying,
      @HiveField(3) required final Duration elapsed,
      @HiveField(4) required final DateTime? startedAt}) = _$SessionStateImpl;
  const _SessionState._() : super._();

  factory _SessionState.fromJson(Map<String, dynamic> json) =
      _$SessionStateImpl.fromJson;

  @override
  @HiveField(0)
  String? get id;
  @override
  @HiveField(1)
  Ambience? get ambience;
  @override
  @HiveField(2)
  bool get isPlaying;
  @override
  @HiveField(3)
  Duration get elapsed;
  @override
  @HiveField(4)
  DateTime? get startedAt;
  @override
  @JsonKey(ignore: true)
  _$$SessionStateImplCopyWith<_$SessionStateImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
