import 'package:arvyax/core/constants/app_constants.dart';
import 'package:arvyax/core/theme/app_colors.dart';
import 'package:arvyax/core/theme/app_decorations.dart';
import 'package:arvyax/core/theme/app_icons.dart';
import 'package:arvyax/core/theme/app_text_styles.dart';
import 'package:arvyax/data/models/ambience.dart';
import 'package:arvyax/features/player/bloc/player_bloc.dart';
import 'package:arvyax/shared/components/index.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';

class AmbienceDetailsScreen extends StatelessWidget {
  final Ambience ambience;

  const AmbienceDetailsScreen({super.key, required this.ambience});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Ambience'),
        leading: IconButton(
          icon: const Icon(AppIcons.back),
          onPressed: () => context.pop(),
        ),
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            // Hero Image
            Container(
              width: double.infinity,
              height: 280,
              decoration: BoxDecoration(
                gradient: AppDecorations.peacefulGradient,
              ),
              child: ClipRRect(
                child: Image.asset(
                  ambience.imageUrl,
                  width: double.infinity,
                  height: double.infinity,
                  fit: BoxFit.cover,
                  errorBuilder: (context, error, stackTrace) {
                    return Center(
                      child: Icon(
                        AppIcons.music,
                        size: 120,
                        color: AppColors.primary.withOpacity(0.5),
                      ),
                    );
                  },
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(spacingLG),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // Title & Tag
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              ambience.title,
                              style: AppTextStyles.displaySmall,
                            ),
                            const SizedBox(height: spacingSM),
                            Container(
                              padding: const EdgeInsets.symmetric(
                                horizontal: spacingMD,
                                vertical: spacingSM,
                              ),
                              decoration: BoxDecoration(
                                color: _getTagColor(
                                  ambience.tag,
                                ).withOpacity(0.2),
                                borderRadius: BorderRadius.circular(20),
                              ),
                              child: Text(
                                ambience.tag,
                                style: AppTextStyles.labelMedium.copyWith(
                                  color: _getTagColor(ambience.tag),
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: spacingLG),

                  // Duration
                  Container(
                    padding: const EdgeInsets.all(spacingMD),
                    decoration: AppDecorations.cardDecoration(),
                    child: Row(
                      children: [
                        Icon(AppIcons.timer, color: AppColors.primary),
                        const SizedBox(width: spacingMD),
                        Text(
                          '${ambience.durationInSeconds ~/ 60} minutes',
                          style: AppTextStyles.bodyMedium,
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(height: spacingLG),

                  // Description
                  Text('Description', style: AppTextStyles.titleLarge),
                  const SizedBox(height: spacingMD),
                  Text(
                    ambience.description,
                    style: AppTextStyles.bodyMedium.copyWith(
                      color: AppColors.textSecondary,
                    ),
                  ),
                  const SizedBox(height: spacingLG),

                  // Sensory Recipe
                  Text('Sensory Recipe', style: AppTextStyles.titleLarge),
                  const SizedBox(height: spacingMD),
                  SensoryRecipeChips(recipes: ambience.sensoryRecipe),
                  const SizedBox(height: spacingXL),

                  // Start Session Button
                  PrimaryButton(
                    text: 'Start Session',
                    onPressed: () {
                      context.read<PlayerBloc>().add(StartSession(ambience));
                      context.push('/player');
                    },
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Color _getTagColor(String tag) {
    switch (tag.toLowerCase()) {
      case 'focus':
        return AppColors.tagFocus;
      case 'calm':
        return AppColors.tagCalm;
      case 'sleep':
        return AppColors.tagSleep;
      case 'reset':
        return AppColors.tagReset;
      default:
        return AppColors.primary;
    }
  }
}
