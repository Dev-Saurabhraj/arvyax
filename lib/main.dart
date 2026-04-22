import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'core/theme/app_theme.dart';
import 'config/router.dart';
import 'config/service_locator.dart';
import 'features/ambience/bloc/ambience_bloc.dart';
import 'features/player/bloc/player_bloc.dart';
import 'features/journal/bloc/journal_bloc.dart';
import 'data/models/ambience.dart';
import 'data/models/journal_entry.dart';
import 'data/models/session_state.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  // Initialize Hive
  await Hive.initFlutter();

  // Register Hive adapters
  Hive.registerAdapter(AmbienceAdapter());
  Hive.registerAdapter(JournalEntryAdapter());
  Hive.registerAdapter(SessionStateAdapter());
  Hive.registerAdapter(MoodAdapter());

  // Setup service locator / dependency injection
  setupServiceLocator();

  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider<AmbienceBloc>(create: (context) => getIt<AmbienceBloc>()),
        BlocProvider<PlayerBloc>(create: (context) => getIt<PlayerBloc>()),
        BlocProvider<JournalBloc>(create: (context) => getIt<JournalBloc>()),
      ],
      child: MaterialApp.router(
        title: 'ArvyaX',
        theme: AppTheme.lightTheme,
        routerConfig: appRouter,
        debugShowCheckedModeBanner: false,
      ),
    );
  }
}
