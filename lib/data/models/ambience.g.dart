// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'ambience.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class AmbienceAdapter extends TypeAdapter<Ambience> {
  @override
  final int typeId = 0;

  @override
  Ambience read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return Ambience(
      id: fields[0] as String,
      title: fields[1] as String,
      tag: fields[2] as String,
      durationInSeconds: fields[3] as int,
      description: fields[4] as String,
      imageUrl: fields[5] as String,
      sensoryRecipe: (fields[6] as List).cast<String>(),
      audioPath: fields[7] as String,
    );
  }

  @override
  void write(BinaryWriter writer, Ambience obj) {
    writer
      ..writeByte(8)
      ..writeByte(0)
      ..write(obj.id)
      ..writeByte(1)
      ..write(obj.title)
      ..writeByte(2)
      ..write(obj.tag)
      ..writeByte(3)
      ..write(obj.durationInSeconds)
      ..writeByte(4)
      ..write(obj.description)
      ..writeByte(5)
      ..write(obj.imageUrl)
      ..writeByte(6)
      ..write(obj.sensoryRecipe)
      ..writeByte(7)
      ..write(obj.audioPath);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is AmbienceAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$AmbienceImpl _$$AmbienceImplFromJson(Map<String, dynamic> json) =>
    _$AmbienceImpl(
      id: json['id'] as String,
      title: json['title'] as String,
      tag: json['tag'] as String,
      durationInSeconds: (json['durationInSeconds'] as num).toInt(),
      description: json['description'] as String,
      imageUrl: json['imageUrl'] as String,
      sensoryRecipe: (json['sensoryRecipe'] as List<dynamic>)
          .map((e) => e as String)
          .toList(),
      audioPath: json['audioPath'] as String,
    );

Map<String, dynamic> _$$AmbienceImplToJson(_$AmbienceImpl instance) =>
    <String, dynamic>{
      'id': instance.id,
      'title': instance.title,
      'tag': instance.tag,
      'durationInSeconds': instance.durationInSeconds,
      'description': instance.description,
      'imageUrl': instance.imageUrl,
      'sensoryRecipe': instance.sensoryRecipe,
      'audioPath': instance.audioPath,
    };
