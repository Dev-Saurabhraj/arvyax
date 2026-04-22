import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:hive/hive.dart';

part 'ambience.freezed.dart';
part 'ambience.g.dart';

@HiveType(typeId: 0)
@freezed
class Ambience with _$Ambience {
  const factory Ambience({
    @HiveField(0) @HiveField(0) required String id,
    @HiveField(1) required String title,
    @HiveField(2) required String tag,
    @HiveField(3) required int durationInSeconds,
    @HiveField(4) required String description,
    @HiveField(5) required String imageUrl,
    @HiveField(6) required List<String> sensoryRecipe,
    @HiveField(7) required String audioPath,
  }) = _Ambience;

  factory Ambience.fromJson(Map<String, dynamic> json) =>
      _$AmbienceFromJson(json);
}
