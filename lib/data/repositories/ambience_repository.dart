import '../datasources/ambience_local_datasource.dart';
import '../models/ambience.dart';

abstract class AmbienceRepository {
  Future<List<Ambience>> getAmbiences();
}

class AmbienceRepositoryImpl implements AmbienceRepository {
  final AmbienceLocalDataSource localDataSource;

  AmbienceRepositoryImpl(this.localDataSource);

  @override
  Future<List<Ambience>> getAmbiences() async {
    return await localDataSource.getAmbiences();
  }
}
