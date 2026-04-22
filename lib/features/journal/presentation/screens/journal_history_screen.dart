import 'package:arvyax/features/journal/bloc/journal_bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:intl/intl.dart';
import '../../../../core/theme/app_colors.dart';
import '../../../../core/theme/app_text_styles.dart';
import '../../../../core/theme/app_decorations.dart';
import '../../../../core/theme/app_icons.dart';
import '../../../../core/constants/app_constants.dart';
import '../../../../shared/components/index.dart';

class JournalHistoryScreen extends StatefulWidget {
  const JournalHistoryScreen({super.key});

  @override
  State<JournalHistoryScreen> createState() => _JournalHistoryScreenState();
}

class _JournalHistoryScreenState extends State<JournalHistoryScreen> {
  @override
  void initState() {
    super.initState();
    context.read<JournalBloc>().add(const LoadJournalEntries());
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Journal History'),
        leading: IconButton(
          icon: const Icon(AppIcons.back),
          onPressed: () {
            if (context.canPop()) {
              context.pop();
            } else {
              context.go('/');
            }
          },
        ),
      ),
      body: BlocBuilder<JournalBloc, JournalState>(
        builder: (context, state) {
          if (state is JournalLoading) {
            return const Center(child: CircularProgressIndicator());
          }

          if (state is JournalError) {
            return EmptyState(
              title: 'Error',
              description: state.message,
              icon: AppIcons.error,
            );
          }

          if (state is JournalLoaded) {
            if (state.entries.isEmpty) {
              return EmptyState(
                title: 'No reflections yet',
                description: 'Start a session to begin journaling',
                icon: AppIcons.journal,
                onActionPressed: () => context.go('/'),
                actionLabel: 'Explore Ambiences',
              );
            }

            return ListView.builder(
              padding: const EdgeInsets.all(spacingMD),
              itemCount: state.entries.length,
              itemBuilder: (context, index) {
                final entry = state.entries[index];
                final dateFormat = DateFormat('MMM dd, yyyy - h:mm a');
                final formattedDate = dateFormat.format(entry.createdAt);

                return GestureDetector(
                  onTap: () {
                    context.push('/journal/${entry.id}', extra: entry);
                  },
                  child: Container(
                    margin: const EdgeInsets.only(bottom: spacingMD),
                    decoration: AppDecorations.cardDecoration(),
                    child: Padding(
                      padding: const EdgeInsets.all(spacingMD),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          // Date and Ambience
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Expanded(
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      formattedDate,
                                      style: AppTextStyles.labelSmall.copyWith(
                                        color: AppColors.textTertiary,
                                      ),
                                    ),
                                    const SizedBox(height: spacingSM),
                                    Text(
                                      entry.ambienceTitle,
                                      style: AppTextStyles.titleMedium,
                                      maxLines: 1,
                                      overflow: TextOverflow.ellipsis,
                                    ),
                                  ],
                                ),
                              ),
                              // Mood Badge
                              _buildMoodBadge(entry.mood),
                            ],
                          ),
                          const SizedBox(height: spacingMD),
                          // Preview Text
                          Text(
                            entry.content,
                            style: AppTextStyles.bodySmall.copyWith(
                              color: AppColors.textSecondary,
                            ),
                            maxLines: 2,
                            overflow: TextOverflow.ellipsis,
                          ),
                        ],
                      ),
                    ),
                  ),
                );
              },
            );
          }

          return const SizedBox();
        },
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
        style: AppTextStyles.labelSmall.copyWith(color: color),
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
