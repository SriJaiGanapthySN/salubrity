import 'package:flutter/material.dart';
import 'now_playing/progress_bar.dart';
import 'now_playing/wave_visualization.dart';
import 'now_playing/album_art.dart';
import 'now_playing/song_info.dart';
import 'now_playing/playback_controls.dart';

class NowPlayingBar extends StatefulWidget {
  final String currentSong;
  final double playProgress;
  final bool isPlaying;
  final AnimationController playPauseController;
  final VoidCallback onPlayPause;
  final VoidCallback onPrevious;
  final VoidCallback onNext;

  const NowPlayingBar({
    super.key,
    required this.currentSong,
    required this.playProgress,
    required this.isPlaying,
    required this.playPauseController,
    required this.onPlayPause,
    required this.onPrevious,
    required this.onNext,
  });

  @override
  State<NowPlayingBar> createState() => _NowPlayingBarState();
}

class _NowPlayingBarState extends State<NowPlayingBar>
    with SingleTickerProviderStateMixin {
  late AnimationController _waveController;

  @override
  void initState() {
    super.initState();
    _waveController = AnimationController(
      vsync: this,
      duration: const Duration(seconds: 2),
    )..repeat();
  }

  @override
  void dispose() {
    _waveController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final songName = widget.currentSong.split('/').last.replaceAll('.mp3', '');
    final theme = Theme.of(context);
    final primaryColor = theme.colorScheme.primary;
    final secondaryColor = theme.colorScheme.secondary;

    return Container(
      padding: const EdgeInsets.only(top: 8, bottom: 16, left: 16, right: 16),
      decoration: BoxDecoration(
        color: Colors.white,
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.1),
            spreadRadius: 0,
            blurRadius: 20,
            offset: const Offset(0, -4),
          ),
        ],
        borderRadius: const BorderRadius.only(
          topLeft: Radius.circular(24),
          topRight: Radius.circular(24),
        ),
      ),
      child: Column(
        children: [
          // Custom progress indicator
          ProgressBar(
            progress: widget.playProgress,
            primaryColor: primaryColor,
            secondaryColor: secondaryColor,
          ),

          // Sound wave visualization
          WaveVisualization(
            waveController: _waveController,
            primaryColor: primaryColor,
            isPlaying: widget.isPlaying,
          ),

          // Player controls and song info
          Row(
            children: [
              // Album art with gradient
              AlbumArt(
                isPlaying: widget.isPlaying,
                primaryColor: primaryColor,
                secondaryColor: secondaryColor,
                waveController: _waveController,
              ),

              const SizedBox(width: 16),

              // Song info
              Expanded(
                child: SongInfo(
                  songName: songName,
                  playProgress: widget.playProgress,
                  primaryColor: primaryColor,
                  secondaryColor: secondaryColor,
                ),
              ),

              // Playback controls
              PlaybackControls(
                onPrevious: widget.onPrevious,
                onPlayPause: widget.onPlayPause,
                onNext: widget.onNext,
                playPauseController: widget.playPauseController,
                primaryColor: primaryColor,
                secondaryColor: secondaryColor,
              ),
            ],
          ),
        ],
      ),
    );
  }
}
