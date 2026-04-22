import 'dart:convert';
import 'package:flutter/services.dart';
import '../models/ambience.dart';

abstract class AmbienceLocalDataSource {
  Future<List<Ambience>> getAmbiences();
}

class AmbienceLocalDataSourceImpl implements AmbienceLocalDataSource {
  @override
  Future<List<Ambience>> getAmbiences() async {
    try {
      final jsonString = await rootBundle.loadString(
        'assets/data/ambiences.json',
      );
      final jsonData = jsonDecode(jsonString) as List<dynamic>;
      return jsonData
          .map((item) => Ambience.fromJson(item as Map<String, dynamic>))
          .toList();
    } catch (e) {
      throw Exception('Failed to load ambiences: $e');
    }
  }
}
