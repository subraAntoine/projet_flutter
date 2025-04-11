import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../core/models/artist.dart';
import '../bloc/favorites_bloc.dart';
import '../../../features/artists/artists_screen.dart';

class FavoriteArtistItem extends StatelessWidget {
  final Artist artist;

  const FavoriteArtistItem({
    super.key,
    required this.artist,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 80,
      margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      decoration: BoxDecoration(
        color: const Color(0xFFF3F3F3),
        borderRadius: BorderRadius.circular(6),
      ),
      child: InkWell(
        borderRadius: BorderRadius.circular(12),
        onTap: () {
          if (artist.id != null) {
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => ArtistScreen(artistId: artist.id!),
              ),
            );
          }
        },
        child: Padding(
          padding: const EdgeInsets.all(16),
          child: Row(
            children: [
              // Artist image
              artist.thumb != null && artist.thumb!.isNotEmpty
                ? Container(
                    width: 50,
                    height: 50,
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      image: DecorationImage(
                        image: NetworkImage(artist.thumb!),
                        fit: BoxFit.cover,
                      ),
                    ),
                  )
                : Container(
                    width: 50,
                    height: 50,
                    decoration: BoxDecoration(
                      color: Colors.grey.shade300,
                      shape: BoxShape.circle,
                    ),
                    child: const Icon(Icons.person, size: 30, color: Colors.white),
                  ),
              // Artist name
              const SizedBox(width: 16),
              Expanded(
                child: Text(
                  artist.name ?? 'Unknown Artist',
                  style: const TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.w700,
                  ),
                ),
              ),
              
              // Navigation arrow
              const Icon(
                Icons.chevron_right,
                color: Colors.grey,
                size: 24,
              ),
            ],
          ),
        ),
      ),
    );
  }
}