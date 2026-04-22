import 'package:flutter/material.dart';
import '../../../core/theme/app_colors.dart';
import '../../../core/theme/app_icons.dart';
import '../../../core/theme/app_text_styles.dart';
import '../../../core/constants/app_constants.dart';
import '../../../data/models/journal_entry.dart';

class MoodSelector extends StatefulWidget {
  final Mood? selectedMood;
  final ValueChanged<Mood> onMoodSelected;

  const MoodSelector({
    super.key,
    this.selectedMood,
    required this.onMoodSelected,
  });

  @override
  State<MoodSelector> createState() => _MoodSelectorState();
}

class _MoodSelectorState extends State<MoodSelector> {
  late Mood _selectedMood;

  @override
  void initState() {
    super.initState();
    _selectedMood = widget.selectedMood ?? Mood.calm;
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text('How are you feeling?', style: AppTextStyles.titleMedium),
        const SizedBox(height: spacingMD),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            _buildMoodOption(
              mood: Mood.calm,
              icon: AppIcons.calm,
              label: 'Calm',
              color: AppColors.moodCalm,
            ),
            _buildMoodOption(
              mood: Mood.grounded,
              icon: AppIcons.grounded,
              label: 'Grounded',
              color: AppColors.moodGrounded,
            ),
            _buildMoodOption(
              mood: Mood.energized,
              icon: AppIcons.energized,
              label: 'Energized',
              color: AppColors.moodEnergized,
            ),
            _buildMoodOption(
              mood: Mood.sleepy,
              icon: AppIcons.sleepy,
              label: 'Sleepy',
              color: AppColors.moodSleepy,
            ),
          ],
        ),
      ],
    );
  }

  Widget _buildMoodOption({
    required Mood mood,
    required IconData icon,
    required String label,
    required Color color,
  }) {
    final isSelected = _selectedMood == mood;

    return GestureDetector(
      onTap: () {
        setState(() => _selectedMood = mood);
        widget.onMoodSelected(mood);
      },
      child: Column(
        children: [
          Container(
            width: 56,
            height: 56,
            decoration: BoxDecoration(
              color: color.withOpacity(isSelected ? 0.2 : 0.1),
              border: Border.all(color: color, width: isSelected ? 2 : 1),
              borderRadius: BorderRadius.circular(12),
            ),
            child: Icon(icon, color: color, size: 28),
          ),
          const SizedBox(height: spacingSM),
          Text(
            label,
            style: AppTextStyles.labelSmall.copyWith(
              color: isSelected ? color : AppColors.textSecondary,
              fontWeight: isSelected ? FontWeight.w600 : FontWeight.w400,
            ),
          ),
        ],
      ),
    );
  }
}
