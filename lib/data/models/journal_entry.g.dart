// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'journal_entry.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class JournalEntryAdapter extends TypeAdapter<JournalEntry> {
  @override
  final int typeId = 1;

  @override
  JournalEntry read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return JournalEntry(
      id: fields[0] as String,
      ambienceId: fields[1] as String,
      ambienceTitle: fields[2] as String,
      content: fields[3] as String,
      mood: fields[4] as Mood,
      createdAt: fields[5] as DateTime,
    );
  }

  @override
  void write(BinaryWriter writer, JournalEntry obj) {
    writer
      ..writeByte(6)
      ..writeByte(0)
      ..write(obj.id)
      ..writeByte(1)
      ..write(obj.ambienceId)
      ..writeByte(2)
      ..write(obj.ambienceTitle)
      ..writeByte(3)
      ..write(obj.content)
      ..writeByte(4)
      ..write(obj.mood)
      ..writeByte(5)
      ..write(obj.createdAt);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is JournalEntryAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}

class MoodAdapter extends TypeAdapter<Mood> {
  @override
  final int typeId = 3;

  @override
  Mood read(BinaryReader reader) {
    switch (reader.readByte()) {
      case 0:
        return Mood.calm;
      case 1:
        return Mood.grounded;
      case 2:
        return Mood.energized;
      case 3:
        return Mood.sleepy;
      default:
        return Mood.calm;
    }
  }

  @override
  void write(BinaryWriter writer, Mood obj) {
    switch (obj) {
      case Mood.calm:
        writer.writeByte(0);
        break;
      case Mood.grounded:
        writer.writeByte(1);
        break;
      case Mood.energized:
        writer.writeByte(2);
        break;
      case Mood.sleepy:
        writer.writeByte(3);
        break;
    }
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is MoodAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$JournalEntryImpl _$$JournalEntryImplFromJson(Map<String, dynamic> json) =>
    _$JournalEntryImpl(
      id: json['id'] as String,
      ambienceId: json['ambienceId'] as String,
      ambienceTitle: json['ambienceTitle'] as String,
      content: json['content'] as String,
      mood: $enumDecode(_$MoodEnumMap, json['mood']),
      createdAt: DateTime.parse(json['createdAt'] as String),
    );

Map<String, dynamic> _$$JournalEntryImplToJson(_$JournalEntryImpl instance) =>
    <String, dynamic>{
      'id': instance.id,
      'ambienceId': instance.ambienceId,
      'ambienceTitle': instance.ambienceTitle,
      'content': instance.content,
      'mood': _$MoodEnumMap[instance.mood]!,
      'createdAt': instance.createdAt.toIso8601String(),
    };

const _$MoodEnumMap = {
  Mood.calm: 'calm',
  Mood.grounded: 'grounded',
  Mood.energized: 'energized',
  Mood.sleepy: 'sleepy',
};
