import 'package:flutter/material.dart';
import '../../../core/theme/app_colors.dart';
import '../../../core/theme/app_decorations.dart';
import '../../../core/theme/app_text_styles.dart';
import '../../../core/constants/app_constants.dart';

class AmbienceCard extends StatelessWidget {
  final String title;
  final String tag;
  final String duration;
  final String imageUrl;
  final VoidCallback onTap;

  const AmbienceCard({
    super.key,
    required this.title,
    required this.tag,
    required this.duration,
    required this.imageUrl,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        decoration: AppDecorations.cardDecoration(),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Expanded(
              child: Container(
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.vertical(
                    top: Radius.circular(AppDecorations.radiusMD),
                  ),
                ),
                child: ClipRRect(
                  borderRadius: BorderRadius.vertical(
                    top: Radius.circular(AppDecorations.radiusMD),
                  ),
                  child: Image.asset(
                    imageUrl,
                    width: double.infinity,
                    height: double.infinity,
                    fit: BoxFit.cover,
                    errorBuilder: (context, error, stackTrace) {
                      return Container(
                        color: AppColors.primaryLight.withOpacity(0.2),
                        child: Center(
                          child: Icon(
                            Icons.music_note_rounded,
                            size: 48,
                            color: AppColors.primary.withOpacity(0.5),
                          ),
                        ),
                      );
                    },
                  ),
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(spacingMD),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    title,
                    style: AppTextStyles.titleLarge,
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                  ),
                  const SizedBox(height: spacingSM),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      _buildTagChip(tag),
                      Text(
                        duration,
                        style: AppTextStyles.labelSmall,
                        maxLines: 1,
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildTagChip(String tag) {
    final color = _getTagColor(tag);
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
      decoration: BoxDecoration(
        color: color.withOpacity(0.2),
        borderRadius: BorderRadius.circular(AppDecorations.radiusSM),
      ),
      child: Text(tag, style: AppTextStyles.labelSmall.copyWith(color: color)),
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
