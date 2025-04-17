import 'package:flutter/material.dart';
import 'package:video_player/video_player.dart';
import 'package:chewie/chewie.dart';
import 'package:flutter/services.dart';
import '../components/video_player/video_controls.dart';
import '../components/video_player/video_list.dart';
import '../components/video_player/search_bar.dart';
import '../components/video_player/video_display.dart';
import '../components/video_player/volume_dialog.dart';
import '../services/video_initializer.dart';
import '../services/video_error_handler.dart';

class VideoPlayerScreen extends StatefulWidget {
  const VideoPlayerScreen({super.key});

  @override
  State<VideoPlayerScreen> createState() => _VideoPlayerScreenState();
}

class _VideoPlayerScreenState extends State<VideoPlayerScreen>
    with SingleTickerProviderStateMixin {
  final List<String> videoAssets = [
    'assets/videos/why health is wealth.mp4',
    'assets/videos/Discipline is power.mp4',
    'assets/videos/Dont push happiness.mp4',
    'assets/videos/myth of self improvement.mp4',
    'assets/videos/React or Respond.mp4',
    'assets/videos/Billgates formula.mp4',
  ];

  int currentVideoIndex = 0;
  late VideoPlayerController _videoPlayerController;
  ChewieController? _chewieController;
  bool _isInitialized = false;
  bool _isPlaying = false;
  double _volume = 1.0;

  final TextEditingController _searchController = TextEditingController();
  List<String> filteredVideoAssets = [];
  late AnimationController _searchAnimationController;
  final Duration _animationDuration = const Duration(milliseconds: 200);

  @override
  void initState() {
    super.initState();
    _searchAnimationController = AnimationController(
      vsync: this,
      duration: _animationDuration,
    );
    filteredVideoAssets = List.from(videoAssets);
    _initializePlayer(videoAssets[currentVideoIndex]);
  }

  void _initializePlayer(String videoPath) {
    try {
      String encodedPath = Uri.encodeFull(videoPath);
      debugPrint('Initializing video with path: $encodedPath');

      _videoPlayerController = VideoPlayerController.asset(encodedPath);

      final initializer = VideoInitializer(
        context: context,
        onInitializationStateChanged:
            (value) => setState(() => _isInitialized = value),
        onPlayingStateChanged: (value) => setState(() => _isPlaying = value),
        onVideoInitialized:
            () => _videoPlayerController.addListener(_videoListener),
      );

      initializer
          .initializePlayer(encodedPath, _videoPlayerController)
          .then((controller) {
            if (controller != null) {
              setState(() {
                _chewieController = ChewieController(
                  videoPlayerController: _videoPlayerController,
                  autoPlay: false,
                  looping: false,
                  aspectRatio: _videoPlayerController.value.aspectRatio,
                  allowPlaybackSpeedChanging: true,
                  showControls: true,
                  errorBuilder: (context, errorMessage) {
                    return Center(
                      child: Padding(
                        padding: const EdgeInsets.all(16.0),
                        child: Text(
                          'Error: $errorMessage',
                          style: const TextStyle(color: Colors.red),
                          textAlign: TextAlign.center,
                        ),
                      ),
                    );
                  },
                );
              });
            }
          })
          .catchError((error) {
            debugPrint('Error initializing video player: $error');
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(content: Text('Failed to load video: $error')),
            );
          });
    } catch (e) {
      debugPrint('Exception in _initializePlayer: $e');
      ScaffoldMessenger.of(
        context,
      ).showSnackBar(SnackBar(content: Text('Error: $e')));
    }
  }

  void _videoListener() {
    if (_videoPlayerController.value.position >=
            _videoPlayerController.value.duration &&
        !_videoPlayerController.value.isPlaying) {
      _playNextVideo();
    }

    if (mounted) {
      setState(() {
        _isPlaying = _videoPlayerController.value.isPlaying;
      });
    }
  }

  String _getVideoTitle(String path) {
    String fileName = path.split('/').last;
    String nameWithoutExt = fileName.split('.').first;

    return nameWithoutExt
        .split('_')
        .map(
          (word) =>
              word.isEmpty
                  ? ''
                  : '${word[0].toUpperCase()}${word.substring(1)}',
        )
        .join(' ');
  }

  void _playNextVideo() {
    if (currentVideoIndex < videoAssets.length - 1) {
      currentVideoIndex++;
    } else {
      currentVideoIndex = 0;
    }
    _changeVideo(currentVideoIndex);
  }

  void _playPreviousVideo() {
    if (currentVideoIndex > 0) {
      currentVideoIndex--;
    } else {
      currentVideoIndex = videoAssets.length - 1;
    }
    _changeVideo(currentVideoIndex);
  }

  void _changeVideo(int index) {
    _videoPlayerController.removeListener(_videoListener);
    _chewieController?.dispose();
    _videoPlayerController.dispose();

    setState(() {
      _isInitialized = false;
      currentVideoIndex = index;
    });

    _initializePlayer(videoAssets[index]);
  }

  void _filterVideos(String query) {
    setState(() {
      if (query.isEmpty) {
        filteredVideoAssets = List.from(videoAssets);
      } else {
        filteredVideoAssets =
            videoAssets
                .where(
                  (video) => _getVideoTitle(
                    video,
                  ).toLowerCase().contains(query.toLowerCase()),
                )
                .toList();
      }
    });
  }

  @override
  void dispose() {
    _searchAnimationController.dispose();
    _searchController.dispose();
    _videoPlayerController.removeListener(_videoListener);
    _chewieController?.dispose();
    _videoPlayerController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;

    return Scaffold(
      backgroundColor: Colors.grey[100],
      appBar: AppBar(
        systemOverlayStyle: SystemUiOverlayStyle.dark,
        title: Text(
          'Video Player',
          style: TextStyle(
            fontWeight: FontWeight.bold,
            color: colorScheme.primary,
          ),
        ),
        backgroundColor: Colors.white,
        elevation: 0,
        centerTitle: true,
        actions: [
          IconButton(
            icon: const Icon(Icons.info_outline),
            onPressed: () {
              Navigator.pushNamed(context, '/about');
            },
          ),
        ],
      ),
      body: Column(
        children: [
          VideoSearchBar(
            controller: _searchController,
            onSearch: _filterVideos,
            animationDuration: _animationDuration,
          ),
          VideoDisplay(
            isInitialized: _isInitialized,
            chewieController: _chewieController,
            videoTitle: _getVideoTitle(videoAssets[currentVideoIndex]),
          ),
          VideoControls(
            onPreviousPressed: _playPreviousVideo,
            onVolumePressed: () => _showVolumeDialog(context, colorScheme),
            onNextPressed: _playNextVideo,
            colorScheme: colorScheme,
          ),
          Expanded(
            child: Padding(
              padding: const EdgeInsets.all(16.0),
              child: VideoList(
                filteredVideoAssets: filteredVideoAssets,
                videoAssets: videoAssets,
                currentVideoIndex: currentVideoIndex,
                onVideoSelected: _changeVideo,
                getVideoTitle: _getVideoTitle,
                colorScheme: colorScheme,
              ),
            ),
          ),
        ],
      ),
    );
  }

  void _showVolumeDialog(BuildContext context, ColorScheme colorScheme) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return VolumeDialog(
          volume: _volume,
          onVolumeChanged: (value) {
            setState(() {
              _volume = value;
              _videoPlayerController.setVolume(_volume);
            });
          },
        );
      },
    );
  }
}
