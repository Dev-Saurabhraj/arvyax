// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'session_state.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class SessionStateAdapter extends TypeAdapter<SessionState> {
  @override
  final int typeId = 2;

  @override
  SessionState read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return SessionState(
      id: fields[0] as String?,
      ambience: fields[1] as Ambience?,
      isPlaying: fields[2] as bool,
      elapsed: fields[3] as Duration,
      startedAt: fields[4] as DateTime?,
    );
  }

  @override
  void write(BinaryWriter writer, SessionState obj) {
    writer
      ..writeByte(5)
      ..writeByte(0)
      ..write(obj.id)
      ..writeByte(1)
      ..write(obj.ambience)
      ..writeByte(2)
      ..write(obj.isPlaying)
      ..writeByte(3)
      ..write(obj.elapsed)
      ..writeByte(4)
      ..write(obj.startedAt);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is SessionStateAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$SessionStateImpl _$$SessionStateImplFromJson(Map<String, dynamic> json) =>
    _$SessionStateImpl(
      id: json['id'] as String?,
      ambience: json['ambience'] == null
          ? null
          : Ambience.fromJson(json['ambience'] as Map<String, dynamic>),
      isPlaying: json['isPlaying'] as bool,
      elapsed: Duration(microseconds: (json['elapsed'] as num).toInt()),
      startedAt: json['startedAt'] == null
          ? null
          : DateTime.parse(json['startedAt'] as String),
    );

Map<String, dynamic> _$$SessionStateImplToJson(_$SessionStateImpl instance) =>
    <String, dynamic>{
      'id': instance.id,
      'ambience': instance.ambience,
      'isPlaying': instance.isPlaying,
      'elapsed': instance.elapsed.inMicroseconds,
      'startedAt': instance.startedAt?.toIso8601String(),
    };
