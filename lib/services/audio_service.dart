import 'package:audioplayers/audioplayers.dart';

class AudioService {
  final AudioPlayer _audioPlayer = AudioPlayer();
  bool _isInitialized = false;
  Duration _currentPosition = Duration.zero;
  Duration _totalDuration = Duration.zero;
  int _currentSongIndex = -1; // Track current song index
  List<String> _cachedSongsList = [];

  AudioService() {
    // Initialize position and duration listeners
    _audioPlayer.onPositionChanged.listen((position) {
      _currentPosition = position;
    });

    _audioPlayer.onDurationChanged.listen((duration) {
      _totalDuration = duration;
    });
  }

  Future<bool> initialize() async {
    try {
      await _audioPlayer.setReleaseMode(ReleaseMode.stop);
      _isInitialized = true;
      return true;
    } catch (e) {
      print('Failed to initialize audio player: $e');
      _isInitialized = false;
      return false;
    }
  }

  // Add these methods to get current position and total duration
  Future<double> getCurrentPosition() async {
    try {
      return _currentPosition.inMilliseconds.toDouble();
    } catch (e) {
      print('Error getting current position: $e');
      return 0;
    }
  }

  Future<double> getTotalDuration() async {
    try {
      if (_totalDuration == Duration.zero) {
        return 1; // Avoid division by zero
      }
      return _totalDuration.inMilliseconds.toDouble();
    } catch (e) {
      print('Error getting total duration: $e');
      return 1; // Return 1 to avoid division by zero
    }
  }

  bool get isInitialized => _isInitialized;

  // Get current song index
  int get currentSongIndex => _currentSongIndex;

  Future<List<String>> getSongsList() async {
    if (_cachedSongsList.isNotEmpty) {
      return _cachedSongsList;
    }

    await Future.delayed(const Duration(seconds: 1)); // Simulate loading time

    _cachedSongsList = [
      'assets/audio/Binaural1.mp3',
      'assets/audio/Binaural2.mp3',
      'assets/audio/Binaural3.mp3',
      'assets/audio/Subliminal1.mp3',
      'assets/audio/Subliminal2.mp3',
      'assets/audio/Subliminal3.mp3',
    ];

    return _cachedSongsList;
  }

  Future<bool> playSong(String assetPath) async {
    if (!_isInitialized) {
      if (!await initialize()) {
        return false;
      }
    }

    try {
      // Find and update the current song index
      final songs = await getSongsList();
      _currentSongIndex = songs.indexOf(assetPath);

      // In audioplayers, we need to remove the 'assets/' prefix
      String path = assetPath.replaceFirst('assets/', '');
      await _audioPlayer.stop();
      await _audioPlayer.play(AssetSource(path));
      return true;
    } catch (e) {
      print('Error playing song: $e');
      return false;
    }
  }

  Future<bool> pauseSong() async {
    if (!_isInitialized) return false;

    try {
      await _audioPlayer.pause();
      return true;
    } catch (e) {
      print('Error pausing song: $e');
      return false;
    }
  }

  Future<bool> resumeSong() async {
    if (!_isInitialized) return false;

    try {
      await _audioPlayer.resume();
      return true;
    } catch (e) {
      print('Error resuming song: $e');
      return false;
    }
  }

  Future<bool> stopSong() async {
    if (!_isInitialized) return false;

    try {
      await _audioPlayer.stop();
      return true;
    } catch (e) {
      print('Error stopping song: $e');
      return false;
    }
  }

  // Method to play the next song
  Future<bool> playNextSong() async {
    final songs = await getSongsList();
    if (songs.isEmpty || _currentSongIndex < 0) return false;

    int nextIndex = (_currentSongIndex + 1) % songs.length;
    return await playSong(songs[nextIndex]);
  }

  // Method to play the previous song
  Future<bool> playPreviousSong() async {
    final songs = await getSongsList();
    if (songs.isEmpty || _currentSongIndex < 0) return false;

    int previousIndex = (_currentSongIndex - 1 + songs.length) % songs.length;
    return await playSong(songs[previousIndex]);
  }

  // Method to get the current song
  Future<String?> getCurrentSong() async {
    final songs = await getSongsList();
    if (_currentSongIndex >= 0 && _currentSongIndex < songs.length) {
      return songs[_currentSongIndex];
    }
    return null;
  }

  Future<bool> setVolume(double volume) async {
    if (!_isInitialized) return false;

    try {
      await _audioPlayer.setVolume(volume);
      return true;
    } catch (e) {
      print('Error setting volume: $e');
      return false;
    }
  }

  Future<bool> seekTo(Duration position) async {
    if (!_isInitialized) return false;

    try {
      await _audioPlayer.seek(position);
      return true;
    } catch (e) {
      print('Error seeking: $e');
      return false;
    }
  }

  // Streams for monitoring player state
  Stream<Duration> get positionStream => _audioPlayer.onPositionChanged;
  Stream<Duration> get durationStream => _audioPlayer.onDurationChanged;
  Stream<PlayerState> get stateStream => _audioPlayer.onPlayerStateChanged;

  void dispose() {
    try {
      _audioPlayer.dispose();
    } catch (e) {
      print('Error disposing audio player: $e');
    }
  }
}
