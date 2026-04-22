import 'package:arvyax/features/journal/bloc/journal_bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:uuid/uuid.dart';
import '../../../../core/theme/app_colors.dart';
import '../../../../core/theme/app_text_styles.dart';
import '../../../../core/constants/app_constants.dart';
import '../../../../data/models/journal_entry.dart';
import '../../../../data/models/session_state.dart';
import '../../../../shared/components/index.dart';

class JournalReflectionScreen extends StatefulWidget {
  final SessionState sessionState;

  const JournalReflectionScreen({super.key, required this.sessionState});

  @override
  State<JournalReflectionScreen> createState() =>
      _JournalReflectionScreenState();
}

class _JournalReflectionScreenState extends State<JournalReflectionScreen> {
  late TextEditingController _journalController;
  Mood _selectedMood = Mood.calm;
  bool _isLoading = false;

  @override
  void initState() {
    super.initState();
    _journalController = TextEditingController();
  }

  @override
  void dispose() {
    _journalController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Reflection'),
        leading: IconButton(
          icon: const Icon(Icons.close_rounded),
          onPressed: () => context.pop(),
        ),
      ),
      body: BlocListener<JournalBloc, JournalState>(
        listener: (context, state) {
          if (state is JournalSaved) {
            context.go('/journal-history');
          }
        },
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(spacingLG),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // Title
                Text(
                  'What is gently present with you right now?',
                  style: AppTextStyles.displaySmall,
                ),
                const SizedBox(height: spacingLG),

                // Journal Text Input
                TextField(
                  controller: _journalController,
                  maxLines: 6,
                  decoration: InputDecoration(
                    hintText: 'Write your thoughts here...',
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(12),
                      borderSide: const BorderSide(color: AppColors.grey200),
                    ),
                    enabledBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(12),
                      borderSide: const BorderSide(color: AppColors.grey200),
                    ),
                    focusedBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(12),
                      borderSide: const BorderSide(
                        color: AppColors.primary,
                        width: 2,
                      ),
                    ),
                    filled: true,
                    fillColor: AppColors.backgroundDark,
                    contentPadding: const EdgeInsets.all(spacingMD),
                  ),
                  style: AppTextStyles.bodyMedium,
                ),
                const SizedBox(height: spacingXL),

                // Mood Selector
                MoodSelector(
                  selectedMood: _selectedMood,
                  onMoodSelected: (mood) {
                    setState(() => _selectedMood = mood);
                  },
                ),
                const SizedBox(height: spacingXL),

                // Save Button
                PrimaryButton(
                  text: 'Save Reflection',
                  isLoading: _isLoading,
                  onPressed: _saveReflection,
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Future<void> _saveReflection() async {
    if (_journalController.text.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Please write your reflection')),
      );
      return;
    }

    setState(() => _isLoading = true);

    final entry = JournalEntry(
      id: const Uuid().v4(),
      ambienceId: widget.sessionState.ambience?.id ?? '',
      ambienceTitle: widget.sessionState.ambience?.title ?? 'Unknown',
      content: _journalController.text,
      mood: _selectedMood,
      createdAt: DateTime.now(),
    );

    if (mounted) {
      context.read<JournalBloc>().add(SaveJournalEntry(entry));
    }
  }
}
