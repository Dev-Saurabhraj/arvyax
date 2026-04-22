import 'package:flutter/material.dart';
import '../../../core/theme/app_colors.dart';
import '../../../core/theme/app_decorations.dart';
import '../../../core/theme/app_text_styles.dart';
import '../../../core/theme/app_icons.dart';
import '../../../core/constants/app_constants.dart';

class MiniPlayer extends StatelessWidget {
  final String title;
  final bool isPlaying;
  final Duration elapsed;
  final Duration total;
  final String? imageUrl;
  final VoidCallback onPlayPause;
  final VoidCallback onTap;

  const MiniPlayer({
    super.key,
    required this.title,
    required this.isPlaying,
    required this.elapsed,
    required this.total,
    this.imageUrl,
    required this.onPlayPause,
    required this.onTap,
  });

  String _formatDuration(Duration duration) {
    final minutes = duration.inMinutes;
    final seconds = duration.inSeconds % 60;
    return '${minutes.toString().padLeft(2, '0')}:${seconds.toString().padLeft(2, '0')}';
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        decoration: BoxDecoration(
          color: AppColors.surface,
          border: Border(top: BorderSide(color: AppColors.grey200, width: 1)),
          boxShadow: AppDecorations.boxShadowMedium,
        ),
        padding: const EdgeInsets.symmetric(
          horizontal: spacingMD,
          vertical: spacingSM,
        ),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            // Progress bar
            ClipRRect(
              borderRadius: BorderRadius.circular(2),
              child: LinearProgressIndicator(
                value: total.inSeconds > 0
                    ? elapsed.inSeconds / total.inSeconds
                    : 0,
                backgroundColor: AppColors.grey200,
                valueColor: AlwaysStoppedAnimation<Color>(AppColors.primary),
                minHeight: 2,
              ),
            ),
            const SizedBox(height: spacingSM),
            // Content
            Row(
              children: [
                ClipRRect(
                  borderRadius: BorderRadius.circular(AppDecorations.radiusSM),
                  child: SizedBox(
                    width: 48,
                    height: 48,
                    child: imageUrl == null || imageUrl!.isEmpty
                        ? _buildFallbackArt()
                        : Image.asset(
                            imageUrl!,
                            width: 48,
                            height: 48,
                            fit: BoxFit.cover,
                            errorBuilder: (context, error, stackTrace) =>
                                _buildFallbackArt(),
                          ),
                  ),
                ),
                const SizedBox(width: spacingMD),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        title,
                        style: AppTextStyles.labelLarge,
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                      ),
                      Text(
                        '${_formatDuration(elapsed)} / ${_formatDuration(total)}',
                        style: AppTextStyles.labelSmall.copyWith(
                          color: AppColors.textTertiary,
                        ),
                      ),
                    ],
                  ),
                ),
                IconButton(
                  icon: Icon(
                    isPlaying ? AppIcons.pause : AppIcons.play,
                    color: AppColors.primary,
                    size: 20,
                  ),
                  onPressed: onPlayPause,
                  splashRadius: 20,
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildFallbackArt() {
    return Container(
      color: AppColors.primaryLight.withOpacity(0.2),
      child: Icon(
        AppIcons.music,
        color: AppColors.primary.withOpacity(0.6),
        size: 24,
      ),
    );
  }
}
