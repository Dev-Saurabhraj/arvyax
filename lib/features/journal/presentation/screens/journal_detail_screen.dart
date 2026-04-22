import 'package:arvyax/data/models/journal_entry.dart';
import 'package:arvyax/features/journal/bloc/journal_bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:intl/intl.dart';
import '../../../../core/theme/app_colors.dart';
import '../../../../core/theme/app_text_styles.dart';
import '../../../../core/theme/app_icons.dart';
import '../../../../core/constants/app_constants.dart';
import '../../../../shared/components/index.dart';

class JournalDetailScreen extends StatelessWidget {
  final JournalEntry entry;

  const JournalDetailScreen({super.key, required this.entry});

  @override
  Widget build(BuildContext context) {
    final dateFormat = DateFormat('MMMM dd, yyyy · h:mm a');
    final formattedDate = dateFormat.format(entry.createdAt);

    return Scaffold(
      appBar: AppBar(
        title: const Text('Reflection'),
        leading: IconButton(
          icon: const Icon(AppIcons.back),
          onPressed: () => context.pop(),
        ),
        actions: [
          IconButton(
            icon: const Icon(AppIcons.delete),
            onPressed: () async {
              final confirmed = await showConfirmationDialog(
                context,
                title: 'Delete reflection?',
                message: 'This action cannot be undone.',
                confirmLabel: 'Delete',
                confirmColor: AppColors.error,
              );

              if (confirmed && context.mounted) {
                context.read<JournalBloc>().add(DeleteJournalEntry(entry.id));
                context.pop();
              }
            },
          ),
        ],
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(spacingLG),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Date and Mood
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        formattedDate,
                        style: AppTextStyles.labelMedium.copyWith(
                          color: AppColors.textTertiary,
                        ),
                      ),
                      const SizedBox(height: spacingSM),
                      Text(
                        entry.ambienceTitle,
                        style: AppTextStyles.headlineMedium,
                      ),
                    ],
                  ),
                  _buildMoodBadge(entry.mood),
                ],
              ),
              const SizedBox(height: spacingXL),

              // Entry Content
              Container(
                padding: const EdgeInsets.all(spacingMD),
                decoration: BoxDecoration(
                  color: AppColors.backgroundDark,
                  borderRadius: BorderRadius.circular(12),
                ),
                child: Text(
                  entry.content,
                  style: AppTextStyles.bodyMedium.copyWith(height: 1.6),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildMoodBadge(dynamic mood) {
    final color = _getMoodColor(mood.toString());
    return Container(
      padding: const EdgeInsets.symmetric(
        horizontal: spacingMD,
        vertical: spacingSM,
      ),
      decoration: BoxDecoration(
        color: color.withOpacity(0.2),
        borderRadius: BorderRadius.circular(20),
      ),
      child: Text(
        _getMoodLabel(mood.toString()),
        style: AppTextStyles.titleMedium.copyWith(color: color),
      ),
    );
  }

  Color _getMoodColor(String mood) {
    if (mood.contains('calm')) return AppColors.moodCalm;
    if (mood.contains('grounded')) return AppColors.moodGrounded;
    if (mood.contains('energized')) return AppColors.moodEnergized;
    if (mood.contains('sleepy')) return AppColors.moodSleepy;
    return AppColors.primary;
  }

  String _getMoodLabel(String mood) {
    if (mood.contains('calm')) return 'Calm';
    if (mood.contains('grounded')) return 'Grounded';
    if (mood.contains('energized')) return 'Energized';
    if (mood.contains('sleepy')) return 'Sleepy';
    return 'Unknown';
  }
}
