// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'journal_entry.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models');

JournalEntry _$JournalEntryFromJson(Map<String, dynamic> json) {
  return _JournalEntry.fromJson(json);
}

/// @nodoc
mixin _$JournalEntry {
  @HiveField(0)
  String get id => throw _privateConstructorUsedError;
  @HiveField(1)
  String get ambienceId => throw _privateConstructorUsedError;
  @HiveField(2)
  String get ambienceTitle => throw _privateConstructorUsedError;
  @HiveField(3)
  String get content => throw _privateConstructorUsedError;
  @HiveField(4)
  Mood get mood => throw _privateConstructorUsedError;
  @HiveField(5)
  DateTime get createdAt => throw _privateConstructorUsedError;

  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;
  @JsonKey(ignore: true)
  $JournalEntryCopyWith<JournalEntry> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $JournalEntryCopyWith<$Res> {
  factory $JournalEntryCopyWith(
          JournalEntry value, $Res Function(JournalEntry) then) =
      _$JournalEntryCopyWithImpl<$Res, JournalEntry>;
  @useResult
  $Res call(
      {@HiveField(0) String id,
      @HiveField(1) String ambienceId,
      @HiveField(2) String ambienceTitle,
      @HiveField(3) String content,
      @HiveField(4) Mood mood,
      @HiveField(5) DateTime createdAt});
}

/// @nodoc
class _$JournalEntryCopyWithImpl<$Res, $Val extends JournalEntry>
    implements $JournalEntryCopyWith<$Res> {
  _$JournalEntryCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? ambienceId = null,
    Object? ambienceTitle = null,
    Object? content = null,
    Object? mood = null,
    Object? createdAt = null,
  }) {
    return _then(_value.copyWith(
      id: null == id
          ? _value.id
          : id // ignore: cast_nullable_to_non_nullable
              as String,
      ambienceId: null == ambienceId
          ? _value.ambienceId
          : ambienceId // ignore: cast_nullable_to_non_nullable
              as String,
      ambienceTitle: null == ambienceTitle
          ? _value.ambienceTitle
          : ambienceTitle // ignore: cast_nullable_to_non_nullable
              as String,
      content: null == content
          ? _value.content
          : content // ignore: cast_nullable_to_non_nullable
              as String,
      mood: null == mood
          ? _value.mood
          : mood // ignore: cast_nullable_to_non_nullable
              as Mood,
      createdAt: null == createdAt
          ? _value.createdAt
          : createdAt // ignore: cast_nullable_to_non_nullable
              as DateTime,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$JournalEntryImplCopyWith<$Res>
    implements $JournalEntryCopyWith<$Res> {
  factory _$$JournalEntryImplCopyWith(
          _$JournalEntryImpl value, $Res Function(_$JournalEntryImpl) then) =
      __$$JournalEntryImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {@HiveField(0) String id,
      @HiveField(1) String ambienceId,
      @HiveField(2) String ambienceTitle,
      @HiveField(3) String content,
      @HiveField(4) Mood mood,
      @HiveField(5) DateTime createdAt});
}

/// @nodoc
class __$$JournalEntryImplCopyWithImpl<$Res>
    extends _$JournalEntryCopyWithImpl<$Res, _$JournalEntryImpl>
    implements _$$JournalEntryImplCopyWith<$Res> {
  __$$JournalEntryImplCopyWithImpl(
      _$JournalEntryImpl _value, $Res Function(_$JournalEntryImpl) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? ambienceId = null,
    Object? ambienceTitle = null,
    Object? content = null,
    Object? mood = null,
    Object? createdAt = null,
  }) {
    return _then(_$JournalEntryImpl(
      id: null == id
          ? _value.id
          : id // ignore: cast_nullable_to_non_nullable
              as String,
      ambienceId: null == ambienceId
          ? _value.ambienceId
          : ambienceId // ignore: cast_nullable_to_non_nullable
              as String,
      ambienceTitle: null == ambienceTitle
          ? _value.ambienceTitle
          : ambienceTitle // ignore: cast_nullable_to_non_nullable
              as String,
      content: null == content
          ? _value.content
          : content // ignore: cast_nullable_to_non_nullable
              as String,
      mood: null == mood
          ? _value.mood
          : mood // ignore: cast_nullable_to_non_nullable
              as Mood,
      createdAt: null == createdAt
          ? _value.createdAt
          : createdAt // ignore: cast_nullable_to_non_nullable
              as DateTime,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$JournalEntryImpl implements _JournalEntry {
  const _$JournalEntryImpl(
      {@HiveField(0) required this.id,
      @HiveField(1) required this.ambienceId,
      @HiveField(2) required this.ambienceTitle,
      @HiveField(3) required this.content,
      @HiveField(4) required this.mood,
      @HiveField(5) required this.createdAt});

  factory _$JournalEntryImpl.fromJson(Map<String, dynamic> json) =>
      _$$JournalEntryImplFromJson(json);

  @override
  @HiveField(0)
  final String id;
  @override
  @HiveField(1)
  final String ambienceId;
  @override
  @HiveField(2)
  final String ambienceTitle;
  @override
  @HiveField(3)
  final String content;
  @override
  @HiveField(4)
  final Mood mood;
  @override
  @HiveField(5)
  final DateTime createdAt;

  @override
  String toString() {
    return 'JournalEntry(id: $id, ambienceId: $ambienceId, ambienceTitle: $ambienceTitle, content: $content, mood: $mood, createdAt: $createdAt)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$JournalEntryImpl &&
            (identical(other.id, id) || other.id == id) &&
            (identical(other.ambienceId, ambienceId) ||
                other.ambienceId == ambienceId) &&
            (identical(other.ambienceTitle, ambienceTitle) ||
                other.ambienceTitle == ambienceTitle) &&
            (identical(other.content, content) || other.content == content) &&
            (identical(other.mood, mood) || other.mood == mood) &&
            (identical(other.createdAt, createdAt) ||
                other.createdAt == createdAt));
  }

  @JsonKey(ignore: true)
  @override
  int get hashCode => Object.hash(
      runtimeType, id, ambienceId, ambienceTitle, content, mood, createdAt);

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$JournalEntryImplCopyWith<_$JournalEntryImpl> get copyWith =>
      __$$JournalEntryImplCopyWithImpl<_$JournalEntryImpl>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$JournalEntryImplToJson(
      this,
    );
  }
}

abstract class _JournalEntry implements JournalEntry {
  const factory _JournalEntry(
      {@HiveField(0) required final String id,
      @HiveField(1) required final String ambienceId,
      @HiveField(2) required final String ambienceTitle,
      @HiveField(3) required final String content,
      @HiveField(4) required final Mood mood,
      @HiveField(5) required final DateTime createdAt}) = _$JournalEntryImpl;

  factory _JournalEntry.fromJson(Map<String, dynamic> json) =
      _$JournalEntryImpl.fromJson;

  @override
  @HiveField(0)
  String get id;
  @override
  @HiveField(1)
  String get ambienceId;
  @override
  @HiveField(2)
  String get ambienceTitle;
  @override
  @HiveField(3)
  String get content;
  @override
  @HiveField(4)
  Mood get mood;
  @override
  @HiveField(5)
  DateTime get createdAt;
  @override
  @JsonKey(ignore: true)
  _$$JournalEntryImplCopyWith<_$JournalEntryImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
