import 'package:flutter/material.dart';

class SongsList extends StatelessWidget {
  final List<String> filteredSongs;
  final String? currentSong;
  final bool isPlaying;
  final String searchQuery;
  final Function(String) onSongTap;

  const SongsList({
    super.key,
    required this.filteredSongs,
    required this.currentSong,
    required this.isPlaying,
    required this.searchQuery,
    required this.onSongTap,
  });

  @override
  Widget build(BuildContext context) {
    if (filteredSongs.isEmpty) {
      return Center(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Icon(Icons.music_off, size: 100, color: Colors.grey[300]),
            const SizedBox(height: 20),
            Text(
              searchQuery.isEmpty
                  ? 'No songs available'
                  : 'No matches found for "$searchQuery"',
              style: TextStyle(
                fontSize: 18,
                color: Colors.grey[600],
                fontWeight: FontWeight.w500,
              ),
            ),
            if (searchQuery.isNotEmpty)
              Padding(
                padding: const EdgeInsets.only(top: 16.0),
                child: ElevatedButton.icon(
                  icon: const Icon(Icons.refresh),
                  label: const Text('Show All Songs'),
                  onPressed: () => onSongTap(''),
                  style: ElevatedButton.styleFrom(
                    foregroundColor: Colors.white,
                    backgroundColor: Theme.of(context).colorScheme.primary,
                    padding: const EdgeInsets.symmetric(
                      horizontal: 16,
                      vertical: 10,
                    ),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(20),
                    ),
                  ),
                ),
              ),
          ],
        ),
      );
    }

    return ListView.builder(
      itemCount: filteredSongs.length,
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
      itemBuilder: (context, index) {
        final song = filteredSongs[index];
        final songName = song.split('/').last.replaceAll('.mp3', '');
        final isCurrentlyPlaying = currentSong == song && isPlaying;
        final isSelected = currentSong == song;

        return AnimatedContainer(
          duration: const Duration(milliseconds: 300),
          margin: const EdgeInsets.symmetric(vertical: 6, horizontal: 4),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(12),
            boxShadow: [
              BoxShadow(
                color:
                    isSelected
                        ? Theme.of(context).colorScheme.primary.withOpacity(0.3)
                        : Colors.grey.withOpacity(0.1),
                blurRadius: 8,
                offset: const Offset(0, 3),
              ),
            ],
          ),
          child: Material(
            color: Colors.transparent,
            child: InkWell(
              borderRadius: BorderRadius.circular(12),
              splashColor: Theme.of(
                context,
              ).colorScheme.primary.withOpacity(0.1),
              highlightColor: Theme.of(
                context,
              ).colorScheme.primary.withOpacity(0.05),
              onTap: () => onSongTap(song),
              child: Card(
                margin: EdgeInsets.zero,
                elevation: 0,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(12),
                  side: BorderSide(
                    color:
                        isSelected
                            ? Theme.of(context).colorScheme.primary
                            : Colors.transparent,
                    width: 1.5,
                  ),
                ),
                color:
                    isSelected
                        ? Theme.of(
                          context,
                        ).colorScheme.primary.withOpacity(0.08)
                        : Colors.white,
                child: Padding(
                  padding: const EdgeInsets.all(12.0),
                  child: Row(
                    children: [
                      Hero(
                        tag:
                            isSelected
                                ? 'music_icon_${song.hashCode}'
                                : 'idle_${song.hashCode}',
                        child: Container(
                          width: 60,
                          height: 60,
                          decoration: BoxDecoration(
                            gradient: LinearGradient(
                              colors:
                                  isSelected
                                      ? [
                                        Theme.of(context).colorScheme.primary,
                                        Theme.of(context).colorScheme.secondary,
                                      ]
                                      : [
                                        Colors.grey.shade200,
                                        Colors.grey.shade300,
                                      ],
                              begin: Alignment.topLeft,
                              end: Alignment.bottomRight,
                            ),
                            borderRadius: BorderRadius.circular(12),
                            boxShadow: [
                              BoxShadow(
                                color:
                                    isSelected
                                        ? Theme.of(
                                          context,
                                        ).colorScheme.primary.withOpacity(0.4)
                                        : Colors.grey.withOpacity(0.2),
                                blurRadius: 8,
                                offset: const Offset(0, 3),
                              ),
                            ],
                          ),
                          child:
                              isCurrentlyPlaying
                                  ? Center(
                                    child: Stack(
                                      alignment: Alignment.center,
                                      children: [
                                        Icon(
                                          Icons.music_note,
                                          color: Colors.white,
                                          size: 30,
                                        ),
                                        SizedBox(
                                          width: 40,
                                          height: 40,
                                          child: CircularProgressIndicator(
                                            strokeWidth: 2,
                                            valueColor:
                                                AlwaysStoppedAnimation<Color>(
                                                  Colors.white.withOpacity(0.7),
                                                ),
                                          ),
                                        ),
                                      ],
                                    ),
                                  )
                                  : Icon(
                                    isSelected
                                        ? Icons.music_note
                                        : Icons.music_note_outlined,
                                    color:
                                        isSelected
                                            ? Colors.white
                                            : Colors.grey[600],
                                    size: 30,
                                  ),
                        ),
                      ),
                      const SizedBox(width: 16),
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              songName,
                              style: TextStyle(
                                fontWeight:
                                    isSelected
                                        ? FontWeight.bold
                                        : FontWeight.w500,
                                color:
                                    isSelected
                                        ? Theme.of(context).colorScheme.primary
                                        : Colors.black87,
                                fontSize: 16,
                              ),
                              overflow: TextOverflow.ellipsis,
                            ),
                            const SizedBox(height: 4),
                            if (isSelected)
                              Container(
                                padding: const EdgeInsets.symmetric(
                                  horizontal: 8,
                                  vertical: 3,
                                ),
                                decoration: BoxDecoration(
                                  color: Theme.of(
                                    context,
                                  ).colorScheme.primary.withOpacity(0.1),
                                  borderRadius: BorderRadius.circular(12),
                                ),
                                child: Text(
                                  isCurrentlyPlaying
                                      ? 'Now Playing'
                                      : 'Selected',
                                  style: TextStyle(
                                    color:
                                        Theme.of(context).colorScheme.primary,
                                    fontSize: 12,
                                    fontWeight: FontWeight.w500,
                                  ),
                                ),
                              ),
                          ],
                        ),
                      ),
                      if (isCurrentlyPlaying)
                        Container(
                          width: 40,
                          height: 40,
                          decoration: BoxDecoration(
                            shape: BoxShape.circle,
                            color: Theme.of(
                              context,
                            ).colorScheme.primary.withOpacity(0.1),
                          ),
                          child: Icon(
                            Icons.equalizer,
                            color: Theme.of(context).colorScheme.primary,
                          ),
                        )
                      else
                        Icon(
                          Icons.play_circle_outline,
                          color: Colors.grey[400],
                          size: 28,
                        ),
                    ],
                  ),
                ),
              ),
            ),
          ),
        );
      },
    );
  }
}
