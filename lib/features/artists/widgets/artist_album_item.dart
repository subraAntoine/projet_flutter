import 'package:flutter/material.dart';

class ArtistAlbumItem extends StatelessWidget {
  final String title;
  final String? year;
  final String? imageUrl;
  final VoidCallback? onTap;

  const ArtistAlbumItem({
    Key? key,
    required this.title,
    this.year,
    this.imageUrl,
    this.onTap,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        padding: const EdgeInsets.all(16.0),
        decoration: BoxDecoration(
          color: Colors.grey.shade100,
          borderRadius: BorderRadius.circular(6),
        ),
        child: Row(
          children: [
            // Album artwork
            Container(
              width: 50,
              height: 50,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(6),
              ),
              clipBehavior: Clip.antiAlias,
              child: imageUrl != null && imageUrl!.isNotEmpty
                  ? Image.network(
                      imageUrl!,
                      fit: BoxFit.cover,
                      errorBuilder: (context, error, stackTrace) => Container(
                        color: Colors.grey[300],
                        child: const Icon(Icons.album, color: Colors.white, size: 50),
                      ),
                    )
                  : Container(
                      color: Colors.grey[300],
                      child: const Icon(Icons.album, color: Colors.white, size: 50),
                    ),
            ),
            
            const SizedBox(width: 16),
            
            // Title and year
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    title,
                    style: const TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 16,
                    ),
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                  ),
                  if (year != null)
                    Text(
                      year!,
                      style: TextStyle(
                        color: const Color(0xFF8D8D8D),
                        fontSize: 14,
                      ),
                    ),
                ],
              ),
            ),
            
            // Arrow icon
            Icon(
              Icons.chevron_right,
              color: Colors.grey.shade400,
              size: 30,
            ),
          ],
        ),
      ),
    );
  }
} 