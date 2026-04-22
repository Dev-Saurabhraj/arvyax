import 'package:go_router/go_router.dart';
import 'package:flutter/material.dart';
import '../data/models/ambience.dart';
import '../data/models/journal_entry.dart';
import '../data/models/session_state.dart';
import '../features/ambience/presentation/screens/ambience_home_screen.dart';
import '../features/ambience/presentation/screens/ambience_details_screen.dart';
import '../features/player/presentation/screens/player_screen.dart';
import '../features/journal/presentation/screens/journal_reflection_screen.dart';
import '../features/journal/presentation/screens/journal_history_screen.dart';
import '../features/journal/presentation/screens/journal_detail_screen.dart';

final GoRouter appRouter = GoRouter(
  initialLocation: '/',
  routes: [
    GoRoute(
      path: '/',
      name: 'home',
      builder: (context, state) => const AmbienceHomeScreen(),
    ),
    GoRoute(
      path: '/ambience/:id',
      name: 'ambience-details',
      builder: (context, state) {
        final extra = state.extra as Ambience?;
        if (extra != null) {
          return AmbienceDetailsScreen(ambience: extra);
        }
        return const Scaffold(body: Center(child: Text('Ambience not found')));
      },
    ),
    GoRoute(
      path: '/player',
      name: 'player',
      builder: (context, state) => const PlayerScreen(),
    ),
    GoRoute(
      path: '/journal-reflection',
      name: 'journal-reflection',
      builder: (context, state) {
        final extra = state.extra as SessionState?;
        if (extra != null) {
          return JournalReflectionScreen(sessionState: extra);
        }
        return const Scaffold(body: Center(child: Text('Session not found')));
      },
    ),
    GoRoute(
      path: '/journal-history',
      name: 'journal-history',
      builder: (context, state) => const JournalHistoryScreen(),
    ),
    GoRoute(
      path: '/journal/:id',
      name: 'journal-detail',
      builder: (context, state) {
        final extra = state.extra as JournalEntry?;
        if (extra != null) {
          return JournalDetailScreen(entry: extra);
        }
        return const Scaffold(body: Center(child: Text('Entry not found')));
      },
    ),
  ],
);
