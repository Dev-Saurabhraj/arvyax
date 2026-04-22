import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import '../../../../core/theme/app_colors.dart';
import '../../../../core/theme/app_text_styles.dart';
import '../../../../core/theme/app_decorations.dart';
import '../../../../core/theme/app_icons.dart';
import '../../../../core/constants/app_constants.dart';
import '../../../ambience/bloc/ambience_bloc.dart';
import '../../../player/bloc/player_bloc.dart';
import '../../../../shared/components/index.dart';

class AmbienceHomeScreen extends StatefulWidget {
  const AmbienceHomeScreen({super.key});

  @override
  State<AmbienceHomeScreen> createState() => _AmbienceHomeScreenState();
}

class _AmbienceHomeScreenState extends State<AmbienceHomeScreen> {
  String _searchQuery = '';
  String? _selectedTag;
  final _searchController = TextEditingController();

  final tags = ['Focus', 'Calm', 'Sleep', 'Reset'];

  @override
  void initState() {
    super.initState();
    context.read<AmbienceBloc>().add(const LoadAmbiences());
  }

  @override
  void dispose() {
    _searchController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('ArvyaX'),
        elevation: 0,
        actions: [
          IconButton(
            icon: const Icon(AppIcons.history),
            onPressed: () => context.push('/journal-history'),
            tooltip: 'View Journal History',
          ),
        ],
      ),
      body: BlocBuilder<PlayerBloc, PlayerState>(
        builder: (context, playerState) {
          final hasActiveSession =
              playerState is PlayerActive || playerState is PlayerPaused;

          return Column(
            children: [
              Expanded(
                child: BlocBuilder<AmbienceBloc, AmbienceState>(
                  builder: (context, state) {
                    if (state is AmbienceLoading) {
                      return const Center(child: CircularProgressIndicator());
                    }

                    if (state is AmbienceError) {
                      return EmptyState(
                        title: 'Error',
                        description: state.message,
                        icon: AppIcons.error,
                      );
                    }

                    if (state is AmbienceLoaded) {
                      return SingleChildScrollView(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            // Search Bar
                            Padding(
                              padding: const EdgeInsets.fromLTRB(
                                spacingMD,
                                spacingMD,
                                spacingMD,
                                spacingSM,
                              ),
                              child: TextField(
                                controller: _searchController,
                                decoration: InputDecoration(
                                  hintText: 'Search ambiences...',
                                  prefixIcon: const Icon(AppIcons.search),
                                  border: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(12),
                                    borderSide: const BorderSide(
                                      color: AppColors.grey200,
                                    ),
                                  ),
                                  enabledBorder: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(12),
                                    borderSide: const BorderSide(
                                      color: AppColors.grey200,
                                    ),
                                  ),
                                  filled: true,
                                  fillColor: AppColors.backgroundDark,
                                ),
                                onChanged: (value) {
                                  setState(() => _searchQuery = value);
                                  _filterAmbiences();
                                },
                              ),
                            ),
                            // Tag Filter Chips
                            Padding(
                              padding: const EdgeInsets.symmetric(
                                horizontal: spacingMD,
                                vertical: spacingSM,
                              ),
                              child: SingleChildScrollView(
                                scrollDirection: Axis.horizontal,
                                child: Row(
                                  crossAxisAlignment: CrossAxisAlignment.center,
                                  children: [
                                    if (_selectedTag != null ||
                                        _searchQuery.isNotEmpty) ...[
                                      _buildClearChip(),
                                      const SizedBox(width: spacingSM),
                                    ],
                                    ...tags.map(
                                      (tag) => Padding(
                                        padding: const EdgeInsets.only(
                                          right: spacingSM,
                                        ),
                                        child: _buildTagChip(
                                          tag,
                                          isSelected: _selectedTag == tag,
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                            // Ambience Grid
                            if (state.filteredAmbiences.isEmpty)
                              EmptyState(
                                title: 'No ambiences found',
                                description:
                                    'Try adjusting your search or filters',
                                icon: AppIcons.explore,
                                onActionPressed: () {
                                  setState(() {
                                    _selectedTag = null;
                                    _searchQuery = '';
                                    _searchController.clear();
                                  });
                                  context.read<AmbienceBloc>().add(
                                    const FilterAmbiences(query: '', tag: null),
                                  );
                                },
                                actionLabel: 'Clear Filters',
                              )
                            else
                              Padding(
                                padding: const EdgeInsets.all(spacingMD),
                                child: GridView.builder(
                                  shrinkWrap: true,
                                  physics: const NeverScrollableScrollPhysics(),
                                  gridDelegate:
                                      const SliverGridDelegateWithFixedCrossAxisCount(
                                        crossAxisCount: 2,
                                        childAspectRatio: 0.85,
                                        crossAxisSpacing: spacingMD,
                                        mainAxisSpacing: spacingMD,
                                      ),
                                  itemCount: state.filteredAmbiences.length,
                                  itemBuilder: (context, index) {
                                    final ambience =
                                        state.filteredAmbiences[index];
                                    return AmbienceCard(
                                      title: ambience.title,
                                      tag: ambience.tag,
                                      duration:
                                          '${ambience.durationInSeconds ~/ 60} min',
                                      imageUrl: ambience.imageUrl,
                                      onTap: () {
                                        context.push(
                                          '/ambience/${ambience.id}',
                                          extra: ambience,
                                        );
                                      },
                                    );
                                  },
                                ),
                              ),
                          ],
                        ),
                      );
                    }

                    return const SizedBox();
                  },
                ),
              ),
              // Mini Player
              if (hasActiveSession &&
                  (playerState is PlayerActive || playerState is PlayerPaused))
                BlocBuilder<PlayerBloc, PlayerState>(
                  builder: (context, state) {
                    if (state is PlayerActive || state is PlayerPaused) {
                      final sessionState = (state is PlayerActive)
                          ? state.sessionState
                          : (state as PlayerPaused).sessionState;

                      return MiniPlayer(
                        title: sessionState.ambience?.title ?? 'Session',
                        isPlaying: sessionState.isPlaying,
                        elapsed: sessionState.elapsed,
                        total: Duration(
                          seconds:
                              sessionState.ambience?.durationInSeconds ?? 0,
                        ),
                        imageUrl: sessionState.ambience?.imageUrl,
                        onPlayPause: () {
                          if (sessionState.isPlaying) {
                            context.read<PlayerBloc>().add(const PauseAudio());
                          } else {
                            context.read<PlayerBloc>().add(const PlayAudio());
                          }
                        },
                        onTap: () {
                          context.push('/player');
                        },
                      );
                    }
                    return const SizedBox();
                  },
                ),
            ],
          );
        },
      ),
    );
  }

  void _filterAmbiences() {
    context.read<AmbienceBloc>().add(
      FilterAmbiences(query: _searchQuery, tag: _selectedTag),
    );
  }

  Widget _buildTagChip(String tag, {required bool isSelected}) {
    final color = _getTagColor(tag);

    return GestureDetector(
      onTap: () {
        setState(() {
          _selectedTag = isSelected ? null : tag;
        });
        _filterAmbiences();
      },
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 180),
        curve: Curves.easeOut,
        height: 38,
        padding: const EdgeInsets.symmetric(horizontal: spacingMD),
        decoration: BoxDecoration(
          color: isSelected ? color : AppColors.surface,
          borderRadius: BorderRadius.circular(AppDecorations.radiusXL),
          border: Border.all(
            color: isSelected ? color : AppColors.grey200,
            width: 1,
          ),
          boxShadow: isSelected
              ? [
                  BoxShadow(
                    color: color.withOpacity(0.22),
                    blurRadius: 12,
                    offset: const Offset(0, 5),
                  ),
                ]
              : AppDecorations.boxShadowSmall,
        ),
        child: Row(
          mainAxisSize: MainAxisSize.min,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Container(
              width: 8,
              height: 8,
              decoration: BoxDecoration(
                color: isSelected ? AppColors.white : color,
                shape: BoxShape.circle,
              ),
            ),
            const SizedBox(width: spacingSM),
            Text(
              tag,
              style: AppTextStyles.labelMedium.copyWith(
                color: isSelected ? AppColors.white : AppColors.textSecondary,
                fontWeight: isSelected ? FontWeight.w700 : FontWeight.w600,
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildClearChip() {
    return GestureDetector(
      onTap: () {
        setState(() {
          _selectedTag = null;
          _searchQuery = '';
          _searchController.clear();
        });
        context.read<AmbienceBloc>().add(
          const FilterAmbiences(query: '', tag: null),
        );
      },
      child: Container(
        height: 38,
        padding: const EdgeInsets.symmetric(horizontal: spacingMD),
        decoration: BoxDecoration(
          color: AppColors.grey900,
          borderRadius: BorderRadius.circular(AppDecorations.radiusXL),
          boxShadow: AppDecorations.boxShadowSmall,
        ),
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            Text(
              'Clear',
              style: AppTextStyles.labelMedium.copyWith(
                color: AppColors.white,
                fontWeight: FontWeight.w700,
              ),
            ),
            const SizedBox(width: spacingSM),
            const Icon(AppIcons.close, color: AppColors.white, size: 16),
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
