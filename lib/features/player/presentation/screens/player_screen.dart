import 'dart:ui' as ui;

import 'package:arvyax/features/player/bloc/player_bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter/services.dart';
import 'package:go_router/go_router.dart';
import '../../../../core/theme/app_colors.dart';
import '../../../../core/theme/app_text_styles.dart';
import '../../../../core/theme/app_decorations.dart';
import '../../../../core/theme/app_icons.dart';
import '../../../../core/constants/app_constants.dart';
import '../../../../shared/components/index.dart';

class PlayerScreen extends StatefulWidget {
  const PlayerScreen({super.key});

  @override
  State<PlayerScreen> createState() => _PlayerScreenState();
}

class _PlayerScreenState extends State<PlayerScreen> {
  final Map<String, Future<Color>> _ambientColorCache = {};

  String _formatDuration(Duration duration) {
    final minutes = duration.inMinutes;
    final seconds = duration.inSeconds % 60;
    return '${minutes.toString().padLeft(2, '0')}:${seconds.toString().padLeft(2, '0')}';
  }

  Future<void> _confirmEndSession(BuildContext context) async {
    final confirmed = await showConfirmationDialog(
      context,
      title: 'Exit Session?',
      message: 'Do you want to exit the session?',
      confirmLabel: 'Exit',
      confirmColor: AppColors.error,
    );

    if (confirmed && context.mounted) {
      context.read<PlayerBloc>().add(const EndSession());
    }
  }

  Future<Color> _ambientColorForImage(String imagePath) {
    return _ambientColorCache.putIfAbsent(
      imagePath,
      () => _extractAmbientColor(imagePath),
    );
  }

  Future<Color> _extractAmbientColor(String imagePath) async {
    try {
      final data = await rootBundle.load(imagePath);
      final codec = await ui.instantiateImageCodec(
        data.buffer.asUint8List(),
        targetWidth: 32,
        targetHeight: 32,
      );
      final frame = await codec.getNextFrame();
      final pixels = await frame.image.toByteData(
        format: ui.ImageByteFormat.rawRgba,
      );

      if (pixels == null) return AppColors.primary;

      var red = 0;
      var green = 0;
      var blue = 0;
      var count = 0;

      for (var i = 0; i < pixels.lengthInBytes; i += 4) {
        final r = pixels.getUint8(i);
        final g = pixels.getUint8(i + 1);
        final b = pixels.getUint8(i + 2);
        final a = pixels.getUint8(i + 3);
        final brightness = (r + g + b) / 3;

        if (a < 180 || brightness < 28 || brightness > 238) continue;

        red += r;
        green += g;
        blue += b;
        count++;
      }

      if (count == 0) return AppColors.primary;

      final sampled = Color.fromARGB(
        255,
        (red / count).round(),
        (green / count).round(),
        (blue / count).round(),
      );
      final hsl = HSLColor.fromColor(sampled);

      return hsl
          .withSaturation(hsl.saturation.clamp(0.35, 0.82))
          .withLightness(hsl.lightness.clamp(0.38, 0.58))
          .toColor();
    } catch (_) {
      return AppColors.primary;
    }
  }

  @override
  Widget build(BuildContext context) {
    return BlocListener<PlayerBloc, PlayerState>(
      listener: (context, state) {
        if (state is SessionEnded) {
          context.push('/journal-reflection', extra: state.sessionState);
        }
      },
      child: Scaffold(
        appBar: AppBar(
          leading: IconButton(
            icon: const Icon(AppIcons.back),
            onPressed: () => context.pop(),
          ),
          title: const Text('Session'),
          actions: [
            IconButton(
              icon: const Icon(AppIcons.power),
              color: AppColors.error,
              tooltip: 'End session',
              onPressed: () => _confirmEndSession(context),
            ),
          ],
        ),
        body: BlocBuilder<PlayerBloc, PlayerState>(
          builder: (context, state) {
            if (state is PlayerInitial) {
              return EmptyState(
                title: 'No Active Session',
                description:
                    'Choose an ambience from the home screen to begin a session.',
                icon: AppIcons.music,
                actionLabel: 'Explore Ambiences',
                onActionPressed: () => context.go('/'),
              );
            }

            if (state is PlayerStarting) {
              return Center(
                child: Padding(
                  padding: const EdgeInsets.all(spacingLG),
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      const CircularProgressIndicator(),
                      const SizedBox(height: spacingLG),
                      Text(
                        'Starting ${state.ambience.title}',
                        style: AppTextStyles.titleLarge,
                        textAlign: TextAlign.center,
                      ),
                      const SizedBox(height: spacingSM),
                      Text(
                        'Preparing your audio session...',
                        style: AppTextStyles.bodyMedium.copyWith(
                          color: AppColors.textSecondary,
                        ),
                        textAlign: TextAlign.center,
                      ),
                    ],
                  ),
                ),
              );
            }

            if (state is PlayerError) {
              return Center(
                child: EmptyState(
                  title: 'Error',
                  description: state.message,
                  icon: AppIcons.error,
                  actionLabel: 'Back to Home',
                  onActionPressed: () => context.go('/'),
                ),
              );
            }

            if (state is PlayerActive || state is PlayerPaused) {
              final sessionState = (state is PlayerActive)
                  ? state.sessionState
                  : (state as PlayerPaused).sessionState;
              final isPlaying = state is PlayerActive;
              final isLooping = state is PlayerActive
                  ? state.isLooping
                  : (state as PlayerPaused).isLooping;
              final ambience = sessionState.ambience;

              if (ambience == null) {
                return const Center(child: Text('No ambience selected'));
              }

              return FutureBuilder<Color>(
                future: _ambientColorForImage(ambience.imageUrl),
                builder: (context, colorSnapshot) {
                  final ambientColor = colorSnapshot.data ?? AppColors.primary;

                  return SingleChildScrollView(
                    child: Column(
                      children: [
                        Padding(
                          padding: const EdgeInsets.fromLTRB(
                            spacingLG,
                            spacingLG,
                            spacingLG,
                            spacingMD,
                          ),
                          child: Container(
                            height: 280,
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(
                                AppDecorations.radiusXL,
                              ),
                              boxShadow: [
                                BoxShadow(
                                  color: ambientColor.withOpacity(0.28),
                                  blurRadius: 28,
                                  offset: const Offset(0, 14),
                                  spreadRadius: -2,
                                ),
                                BoxShadow(
                                  color: ambientColor.withOpacity(0.16),
                                  blurRadius: 46,
                                  offset: const Offset(0, 22),
                                  spreadRadius: -16,
                                ),
                              ],
                            ),
                            child: ClipRRect(
                              borderRadius: BorderRadius.circular(
                                AppDecorations.radiusXL,
                              ),
                              child: Stack(
                                fit: StackFit.expand,
                                children: [
                                  Image.asset(
                                    ambience.imageUrl,
                                    width: double.infinity,
                                    height: double.infinity,
                                    fit: BoxFit.cover,
                                    errorBuilder: (context, error, stackTrace) {
                                      return DecoratedBox(
                                        decoration: BoxDecoration(
                                          gradient: LinearGradient(
                                            begin: Alignment.topLeft,
                                            end: Alignment.bottomRight,
                                            colors: [
                                              ambientColor.withOpacity(0.18),
                                              ambientColor.withOpacity(0.08),
                                            ],
                                          ),
                                        ),
                                        child: Center(
                                          child: Icon(
                                            AppIcons.music,
                                            size: 96,
                                            color: ambientColor.withOpacity(
                                              0.6,
                                            ),
                                          ),
                                        ),
                                      );
                                    },
                                  ),
                                  DecoratedBox(
                                    decoration: BoxDecoration(
                                      gradient: LinearGradient(
                                        begin: Alignment.topCenter,
                                        end: Alignment.bottomCenter,
                                        colors: [
                                          ambientColor.withOpacity(0.04),
                                          AppColors.textPrimary.withOpacity(
                                            0.56,
                                          ),
                                        ],
                                      ),
                                    ),
                                  ),
                                  Align(
                                    alignment: Alignment.bottomLeft,
                                    child: Padding(
                                      padding: const EdgeInsets.all(spacingLG),
                                      child: Text(
                                        ambience.title,
                                        style: AppTextStyles.headlineLarge
                                            .copyWith(color: AppColors.white),
                                        textAlign: TextAlign.left,
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.all(spacingLG),
                          child: Padding(
                            padding: const EdgeInsets.all(spacingMD),
                            child: Column(
                              children: [
                                // Frequency Wave Visualization
                                FrequencyWave(
                                  color: ambientColor,
                                  height: 140,
                                  isPlaying: isPlaying,
                                  frequencyData: state is PlayerActive
                                      ? state.frequencyData
                                      : const [],
                                ),
                                const SizedBox(height: spacingXL),

                                // Time Display
                                Text(
                                  _formatDuration(sessionState.elapsed),
                                  style: AppTextStyles.displayMedium,
                                ),
                                const SizedBox(height: spacingSM),
                                Text(
                                  _formatDuration(sessionState.remaining),
                                  style: AppTextStyles.bodyMedium.copyWith(
                                    color: AppColors.textSecondary,
                                  ),
                                ),
                                const SizedBox(height: spacingLG),

                                // Seek Slider
                                SliderTheme(
                                  data: SliderThemeData(
                                    trackHeight: 4,
                                    thumbShape: const RoundSliderThumbShape(
                                      enabledThumbRadius: 8,
                                    ),
                                  ),
                                  child: Slider(
                                    value: (ambience.durationInSeconds > 0)
                                        ? sessionState.elapsed.inSeconds
                                                  .toDouble() /
                                              ambience.durationInSeconds
                                        : 0,
                                    activeColor: ambientColor,
                                    inactiveColor: AppColors.grey200,
                                    onChanged: (value) {
                                      final newDuration = Duration(
                                        seconds:
                                            (value * ambience.durationInSeconds)
                                                .toInt(),
                                      );
                                      context.read<PlayerBloc>().add(
                                        SeekAudio(newDuration),
                                      );
                                    },
                                  ),
                                ),
                                const SizedBox(height: spacingLG),

                                // Playback Controls
                                SizedBox(
                                  height: 88,
                                  child: Stack(
                                    alignment: Alignment.center,
                                    children: [
                                      Align(
                                        alignment: Alignment.centerLeft,
                                        child: IconButton(
                                          icon: const Icon(
                                            AppIcons.skipPrevious,
                                          ),
                                          iconSize: 32,
                                          color: AppColors.textSecondary,
                                          onPressed: () {
                                            context.read<PlayerBloc>().add(
                                              SeekAudio(Duration.zero),
                                            );
                                          },
                                        ),
                                      ),
                                      GestureDetector(
                                        onTap: () {
                                          if (isPlaying) {
                                            context.read<PlayerBloc>().add(
                                              const PauseAudio(),
                                            );
                                          } else {
                                            context.read<PlayerBloc>().add(
                                              const PlayAudio(),
                                            );
                                          }
                                        },
                                        child: Container(
                                          width: 80,
                                          height: 80,
                                          decoration: BoxDecoration(
                                            color: ambientColor,
                                            shape: BoxShape.circle,
                                            boxShadow: [
                                              BoxShadow(
                                                color: ambientColor.withOpacity(
                                                  0.28,
                                                ),
                                                blurRadius: 20,
                                                offset: const Offset(0, 8),
                                              ),
                                            ],
                                          ),
                                          child: Icon(
                                            isPlaying
                                                ? AppIcons.pause
                                                : AppIcons.play,
                                            color: AppColors.white,
                                            size: 40,
                                          ),
                                        ),
                                      ),
                                      Align(
                                        alignment: Alignment.centerRight,
                                        child: IconButton(
                                          icon: const Icon(AppIcons.loop),
                                          iconSize: 32,
                                          color: isLooping
                                              ? ambientColor
                                              : AppColors.textSecondary,
                                          tooltip: isLooping
                                              ? 'Loop on'
                                              : 'Loop off',
                                          onPressed: () {
                                            context.read<PlayerBloc>().add(
                                              const ToggleLoop(),
                                            );
                                          },
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                      ],
                    ),
                  );
                },
              );
            }

            if (state is SessionEnded) {
              return Center(
                child: EmptyState(
                  title: 'Session Complete',
                  description:
                      'Your session has ended. Opening reflection next.',
                  icon: AppIcons.check,
                  actionLabel: 'Go Home',
                  onActionPressed: () => context.go('/'),
                ),
              );
            }

            return EmptyState(
              title: 'Something Went Wrong',
              description: 'The player reached an unknown state.',
              icon: AppIcons.error,
              actionLabel: 'Back to Home',
              onActionPressed: () => context.go('/'),
            );
          },
        ),
      ),
    );
  }
}
