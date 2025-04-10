import 'package:flutter/material.dart';
import 'package:projet_flutter/core/models/track.dart';

class AlbumTrackItem extends StatelessWidget {
  final Track track;
  final int index;

  const AlbumTrackItem({
    Key? key,
    required this.track,
    required this.index,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 6.0),
      child: Row(
        children: [
          SizedBox(
            width: 30,
            child: Text(
              (index + 1).toString(),
              style: const TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.bold,
                color: Colors.black,
              ),
            ),
          ),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  track.title ?? 'Unknown',
                  style: const TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.w500,
                    color: Colors.black,
                  ),
                  overflow: TextOverflow.ellipsis,
                  maxLines: 1,
                ),
                const SizedBox(height: 8),
                Container(
                  height: 1,
                  color: const Color(0xFFE6E6E6),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
} 