import 'package:flutter/material.dart';
import 'package:projet_flutter/core/theme/app_colors.dart';
import 'package:projet_flutter/features/artists/artists_screen.dart';

class ChartItem extends StatelessWidget {
  final int rank;
  final String imageUrl;
  final String title;
  final String artist;
  final String? artistId;

  const ChartItem({
    Key? key,
    required this.rank,
    required this.imageUrl,
    required this.title,
    required this.artist,
    this.artistId,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        if (artistId != null) {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => ArtistScreen(artistId: artistId!),
            ),
          );
        }
      },
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 24.0, vertical: 8.0),
        child: Row(
          children: [
            // Rank number
            SizedBox(
              width: 20,
              child: Text(
                rank.toString(),
                style: const TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
            const SizedBox(width: 12),
            // Album/Track artwork
            ClipRRect(
              borderRadius: BorderRadius.circular(4),
              child: Image.network(
                imageUrl,
                width: 40,
                height: 40,
                fit: BoxFit.cover,
                errorBuilder: (context, error, stackTrace) {
                  return Container(
                    width: 40,
                    height: 40,
                    color: Colors.grey[300],
                    child: const Icon(Icons.music_note),
                  );
                },
              ),
            ),
            const SizedBox(width: 12),
            // Title and artist
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    title,
                    style: const TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.w700,
                    ),
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                  ),
                  const SizedBox(height: 4),
                  Text(
                    artist,
                    style: TextStyle(
                      fontSize: 14,
                      color: AppColors.textSecondary,
                    ),
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
} 