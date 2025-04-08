import 'package:flutter/material.dart';
import 'package:projet_flutter/core/theme/app_colors.dart';

class ArtistTrackItem extends StatelessWidget {
  final int rank;
  final String title;
  final VoidCallback? onTap;

  const ArtistTrackItem({
    Key? key,
    required this.rank,
    required this.title,
    this.onTap,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 8.0, horizontal: 16.0),
        child: Row(
          children: [
            // Track rank
            SizedBox(
              width: 20,
              child: Text(
                rank.toString(),
                style: const TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
            const SizedBox(width: 12),
            // Track title
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Padding(
                    padding: const EdgeInsets.symmetric(vertical: 8.0),
                    child: Text(
                      title,
                      style: const TextStyle(
                        fontWeight: FontWeight.w500,
                        fontSize: 16,
                      ),
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                    ),
                  ),
                  const SizedBox(height: 4),
                  Container(
                    height: 1,
                    color: Colors.grey.withOpacity(0.3),
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