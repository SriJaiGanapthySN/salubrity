import 'package:flutter/material.dart';
import 'package:video_player/video_player.dart';
import 'package:chewie/chewie.dart';
import 'video_error_handler.dart';

class VideoInitializer {
  final BuildContext context;
  final Function(bool) onInitializationStateChanged;
  final Function(bool) onPlayingStateChanged;
  final Function() onVideoInitialized;

  VideoInitializer({
    required this.context,
    required this.onInitializationStateChanged,
    required this.onPlayingStateChanged,
    required this.onVideoInitialized,
  });

  Future<ChewieController?> initializePlayer(
    String videoPath,
    VideoPlayerController controller,
  ) async {
    final errorHandler = VideoErrorHandler(context);

    try {
      onInitializationStateChanged(false);
      onPlayingStateChanged(false);

      await controller.initialize();

      if (!context.mounted) return null;

      final chewieController = ChewieController(
        videoPlayerController: controller,
        autoPlay: false, // Changed from true to false
        looping: false,
        allowFullScreen: true,
        showControls: true,
        aspectRatio: controller.value.aspectRatio,
        errorBuilder: (context, errorMessage) {
          return Center(
            child: Text(
              'Error: $errorMessage',
              style: const TextStyle(color: Colors.white),
            ),
          );
        },
        placeholder: Container(color: Colors.black),
      );

      onInitializationStateChanged(true);
      onPlayingStateChanged(false); // Changed from true to false
      onVideoInitialized();

      return chewieController;
    } catch (e) {
      errorHandler.handlePlatformException(e as Exception);
      return null;
    }
  }
}
