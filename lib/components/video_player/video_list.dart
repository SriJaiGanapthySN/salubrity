import 'package:flutter/material.dart';

class VideoList extends StatelessWidget {
  final List<String> filteredVideoAssets;
  final List<String> videoAssets;
  final int currentVideoIndex;
  final Function(int) onVideoSelected;
  final String Function(String) getVideoTitle;
  final ColorScheme colorScheme;

  const VideoList({
    super.key,
    required this.filteredVideoAssets,
    required this.videoAssets,
    required this.currentVideoIndex,
    required this.onVideoSelected,
    required this.getVideoTitle,
    required this.colorScheme,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 4,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
      child:
          filteredVideoAssets.isEmpty
              ? const Center(
                child: Text('No videos found', style: TextStyle(fontSize: 16)),
              )
              : ListView.builder(
                padding: const EdgeInsets.all(8),
                itemCount: filteredVideoAssets.length,
                itemBuilder: (context, index) {
                  final String video = filteredVideoAssets[index];
                  final int originalIndex = videoAssets.indexOf(video);
                  final bool isSelected = originalIndex == currentVideoIndex;
                  return ListTile(
                    leading: Container(
                      width: 48,
                      height: 48,
                      decoration: BoxDecoration(
                        color:
                            isSelected
                                ? colorScheme.primary
                                : colorScheme.secondary.withOpacity(0.3),
                        borderRadius: BorderRadius.circular(8),
                      ),
                      child: const Icon(
                        Icons.video_library,
                        color: Colors.white,
                      ),
                    ),
                    title: Text(
                      getVideoTitle(video),
                      style: TextStyle(
                        fontWeight:
                            isSelected ? FontWeight.bold : FontWeight.normal,
                        color:
                            isSelected ? colorScheme.primary : Colors.black87,
                      ),
                    ),
                    selected: isSelected,
                    selectedTileColor: colorScheme.secondary.withOpacity(0.1),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10),
                    ),
                    onTap: () {
                      if (originalIndex != currentVideoIndex) {
                        onVideoSelected(originalIndex);
                      }
                    },
                  );
                },
              ),
    );
  }
}
