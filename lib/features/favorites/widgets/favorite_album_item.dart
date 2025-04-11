import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../core/models/album.dart';
import '../bloc/favorites_bloc.dart';
import '../../../features/album/album_screen.dart';

class FavoriteAlbumItem extends StatelessWidget {
  final Album album;

  const FavoriteAlbumItem({
    super.key,
    required this.album,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 80, // Increased height to fix overflow
      margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      decoration: BoxDecoration(
        color: const Color(0xFFF3F3F3),
        borderRadius: BorderRadius.circular(6),
      ),
      child: InkWell(
        borderRadius: BorderRadius.circular(12),
        onTap: () {
          if (album.idAlbum != null) {
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => AlbumScreen(albumId: album.idAlbum!),
              ),
            );
          }
        },
        child: Padding(
          padding: const EdgeInsets.all(16),
          child: Row(
            children: [
              // Album image
              AspectRatio(
                aspectRatio: 1,
                child: SizedBox(
                  width: 50,
                  height: 50,
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(6),
                    child: album.strAlbumThumb != null && album.strAlbumThumb!.isNotEmpty
                      ? Image.network(
                          album.strAlbumThumb!,
                          width: 50,
                          height: 50,
                          fit: BoxFit.cover,
                        )
                      : Container(
                          width: 50,
                          height: 50,
                          color: Colors.grey.shade300,
                          child: const Icon(Icons.album, size: 30, color: Colors.white),
                        ),
                  ),
                ),
              ),
              
              // Album info
              const SizedBox(width: 16),
              Expanded(
                child: LayoutBuilder(
                  builder: (context, constraints) {
                    return Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          album.strAlbum ?? 'Unknown Album',
                          style: const TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.w700,
                          ),
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                        ),
                        const SizedBox(height: 4),
                        Text(
                          album.strArtist ?? 'Unknown Artist', 
                          style: TextStyle(
                            fontSize: 14,
                            color: const Color(0xFF8D8D8D),
                          ),
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                        ),
                      ],
                    );
                  }
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