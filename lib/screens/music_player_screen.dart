import 'package:flutter/material.dart';

import 'package:ssalubrity/components/music_player/search_bar.dart' as custom;

import 'package:ssalubrity/components/music_player/loading_indicator.dart';
import 'package:ssalubrity/components/music_player/now_playing_bar.dart';
import 'package:ssalubrity/components/music_player/songs_list.dart';
import 'package:ssalubrity/services/audio_service.dart';

class MusicPlayerScreen extends StatefulWidget {
  const MusicPlayerScreen({super.key});

  @override
  State<MusicPlayerScreen> createState() => _MusicPlayerScreenState();
}

class _MusicPlayerScreenState extends State<MusicPlayerScreen>
    with SingleTickerProviderStateMixin {
  final AudioService _audioService = AudioService();
  String? _currentSong;
  bool _isPlaying = false;
  String _searchQuery = '';
  late List<String> _allSongs;
  List<String> _filteredSongs = [];
  bool _audioAvailable = true;
  bool _isLoading = true;
  double _playProgress = 0.0;
  late AnimationController _playPauseController;

  @override
  void initState() {
    super.initState();
    _playPauseController = AnimationController(
      duration: const Duration(milliseconds: 500),
      vsync: this,
    );
    _checkAudioAndLoadSongs();

    Future.delayed(Duration.zero, () {
      _setupProgressUpdater();
    });
  }

  void _setupProgressUpdater() {
    Future.doWhile(() async {
      if (_isPlaying && mounted) {
        try {
          final progress = await _audioService.getCurrentPosition();
          final total = await _audioService.getTotalDuration();

          if (mounted && total > 0) {
            setState(() {
              _playProgress = progress / total;
              _playProgress = _playProgress.clamp(0.0, 1.0);
            });
          }
        } catch (e) {
          print('Error updating progress: $e');
        }
      }
      await Future.delayed(const Duration(milliseconds: 500));
      return mounted;
    });
  }

  Future<void> _checkAudioAndLoadSongs() async {
    setState(() => _isLoading = true);
    _audioAvailable = await _audioService.initialize();

    if (!_audioAvailable && mounted) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Audio playback is not available on this device'),
          duration: Duration(seconds: 5),
          behavior: SnackBarBehavior.floating,
        ),
      );
    }

    await _loadSongs();
    setState(() => _isLoading = false);
  }

  Future<void> _loadSongs() async {
    _allSongs = await _audioService.getSongsList();
    _filterSongs();
  }

  void _filterSongs() {
    setState(() {
      if (_searchQuery.isEmpty) {
        _filteredSongs = List.from(_allSongs);
      } else {
        _filteredSongs =
            _allSongs
                .where(
                  (song) =>
                      song.toLowerCase().contains(_searchQuery.toLowerCase()),
                )
                .toList();
      }
    });
  }

  void _playSong(String song) async {
    if (!_audioAvailable) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Audio playback is not available'),
          duration: Duration(seconds: 3),
          behavior: SnackBarBehavior.floating,
        ),
      );
      return;
    }

    if (_currentSong == song && _isPlaying) {
      bool success = await _audioService.pauseSong();
      if (success) {
        setState(() {
          _isPlaying = false;
          _playPauseController.reverse();
        });
      }
    } else if (_currentSong == song && !_isPlaying) {
      bool success = await _audioService.resumeSong();
      if (success) {
        setState(() {
          _isPlaying = true;
          _playPauseController.forward();
        });
      }
    } else {
      setState(() => _playProgress = 0.0);
      bool success = await _audioService.playSong(song);
      if (success) {
        setState(() {
          _currentSong = song;
          _isPlaying = true;
          _playPauseController.forward();
        });
      } else {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content: Text('Failed to play audio'),
            duration: Duration(seconds: 3),
            behavior: SnackBarBehavior.floating,
          ),
        );
      }
    }
  }

  void _playNextSong() async {
    if (!_audioAvailable) return;

    bool success = await _audioService.playNextSong();
    if (success) {
      String? currentSong = await _audioService.getCurrentSong();
      setState(() {
        _currentSong = currentSong;
        _isPlaying = true;
        _playProgress = 0.0;
        _playPauseController.forward();
      });
    }
  }

  void _playPreviousSong() async {
    if (!_audioAvailable) return;

    bool success = await _audioService.playPreviousSong();
    if (success) {
      String? currentSong = await _audioService.getCurrentSong();
      setState(() {
        _currentSong = currentSong;
        _isPlaying = true;
        _playProgress = 0.0;
        _playPauseController.forward();
      });
    }
  }

  @override
  void dispose() {
    _playPauseController.dispose();
    _audioService.dispose();
    super.dispose();
  }

  void _handlePlayPause() {
    if (_isPlaying) {
      _audioService.pauseSong();
      _playPauseController.reverse();
    } else {
      _audioService.resumeSong();
      _playPauseController.forward();
    }
    setState(() {
      _isPlaying = !_isPlaying;
    });
  }

  void _handleSearch(String query) {
    setState(() {
      _searchQuery = query;
      _filterSongs();
    });
  }

  void _handleClearSearch() {
    setState(() {
      _searchQuery = '';
      _filterSongs();
    });
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final primaryColor = theme.colorScheme.primary;
    final secondaryColor = theme.colorScheme.secondary;

    return Scaffold(
      extendBodyBehindAppBar: true,
      appBar: AppBar(
        title: const Text(
          'Music Therapy',
          style: TextStyle(
            fontWeight: FontWeight.bold,
            fontSize: 22,
            letterSpacing: 0.5,
          ),
        ),
        centerTitle: true,
        elevation: 0,
        backgroundColor: Colors.transparent,
        flexibleSpace: Container(
          decoration: BoxDecoration(
            gradient: LinearGradient(
              colors: [primaryColor, secondaryColor],
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
            ),
          ),
        ),
      ),
      body: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
            colors: [Colors.grey[100]!, Colors.white],
          ),
        ),
        child: Column(
          children: [
            Container(
              padding: EdgeInsets.only(
                top: MediaQuery.of(context).padding.top + kToolbarHeight,
              ),
              child: custom.SearchBar(
                searchQuery: _searchQuery,
                onSearchChanged: _handleSearch,
                onClearSearch: _handleClearSearch,
              ),
            ),
            Expanded(
              child:
                  _isLoading
                      ? const LoadingIndicator()
                      : Container(
                        margin: const EdgeInsets.symmetric(horizontal: 8),
                        decoration: BoxDecoration(
                          color: Colors.white.withOpacity(0.7),
                          borderRadius: BorderRadius.circular(20),
                        ),
                        child: ClipRRect(
                          borderRadius: BorderRadius.circular(20),
                          child: SongsList(
                            filteredSongs: _filteredSongs,
                            currentSong: _currentSong,
                            isPlaying: _isPlaying,
                            searchQuery: _searchQuery,
                            onSongTap: _playSong,
                          ),
                        ),
                      ),
            ),
            if (_currentSong != null)
              NowPlayingBar(
                currentSong: _currentSong!,
                playProgress: _playProgress,
                isPlaying: _isPlaying,
                playPauseController: _playPauseController,
                onPlayPause: _handlePlayPause,
                onPrevious: _playPreviousSong,
                onNext: _playNextSong,
              ),
          ],
        ),
      ),
    );
  }
}
