import 'package:get_it/get_it.dart';
import '../data/datasources/ambience_local_datasource.dart';
import '../data/datasources/journal_local_datasource.dart';
import '../data/datasources/session_local_datasource.dart';
import '../data/repositories/ambience_repository.dart';
import '../data/repositories/journal_repository.dart';
import '../data/repositories/session_repository.dart';
import '../features/ambience/bloc/ambience_bloc.dart';
import '../features/player/bloc/player_bloc.dart';
import '../features/journal/bloc/journal_bloc.dart';

final getIt = GetIt.instance;

void setupServiceLocator() {
  // Data Sources
  getIt.registerSingleton<AmbienceLocalDataSource>(
    AmbienceLocalDataSourceImpl(),
  );
  getIt.registerSingleton<JournalLocalDataSource>(JournalLocalDataSourceImpl());
  getIt.registerSingleton<SessionLocalDataSource>(SessionLocalDataSourceImpl());

  // Repositories
  getIt.registerSingleton<AmbienceRepository>(
    AmbienceRepositoryImpl(getIt<AmbienceLocalDataSource>()),
  );
  getIt.registerSingleton<JournalRepository>(
    JournalRepositoryImpl(getIt<JournalLocalDataSource>()),
  );
  getIt.registerSingleton<SessionRepository>(
    SessionRepositoryImpl(getIt<SessionLocalDataSource>()),
  );

  // BLoCs
  getIt.registerSingleton<AmbienceBloc>(
    AmbienceBloc(repository: getIt<AmbienceRepository>()),
  );
  getIt.registerSingleton<PlayerBloc>(
    PlayerBloc(sessionRepository: getIt<SessionRepository>()),
  );
  getIt.registerSingleton<JournalBloc>(
    JournalBloc(repository: getIt<JournalRepository>()),
  );
}
