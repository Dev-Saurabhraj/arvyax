import 'package:flutter/material.dart';
import '../../../core/theme/app_colors.dart';
import '../../../core/theme/app_text_styles.dart';
import '../../../core/theme/app_decorations.dart';
import '../../../core/constants/app_constants.dart';

class SensoryRecipeChips extends StatelessWidget {
  final List<String> recipes;

  const SensoryRecipeChips({super.key, required this.recipes});

  @override
  Widget build(BuildContext context) {
    return Wrap(
      spacing: spacingSM,
      runSpacing: spacingSM,
      children: recipes.map((recipe) => _buildChip(recipe)).toList(),
    );
  }

  Widget _buildChip(String recipe) {
    return Container(
      padding: const EdgeInsets.symmetric(
        horizontal: spacingMD,
        vertical: spacingSM,
      ),
      decoration: BoxDecoration(
        color: AppColors.primaryLight.withOpacity(0.1),
        border: Border.all(color: AppColors.primaryLight.withOpacity(0.3)),
        borderRadius: BorderRadius.circular(AppDecorations.radiusLG),
      ),
      child: Text(
        recipe,
        style: AppTextStyles.labelMedium.copyWith(color: AppColors.primary),
      ),
    );
  }
}
