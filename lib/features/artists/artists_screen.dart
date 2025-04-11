import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:projet_flutter/core/models/artist.dart';
import 'package:projet_flutter/core/models/album.dart';
import 'package:projet_flutter/core/models/track.dart';
import 'package:projet_flutter/core/services/the_audio_db.dart';
import 'package:projet_flutter/core/services/the_audio_db_client.dart';
import 'package:projet_flutter/core/theme/app_colors.dart';
import 'package:projet_flutter/features/album/album_screen.dart';
import 'package:projet_flutter/features/artists/bloc/artist_bloc.dart';
import 'package:projet_flutter/features/artists/bloc/artist_event.dart';
import 'package:projet_flutter/features/artists/bloc/artist_state.dart';
import 'package:projet_flutter/features/artists/widgets/artist_album_item.dart';
import 'package:projet_flutter/features/artists/widgets/artist_track_item.dart';
import 'package:projet_flutter/features/favorites/widgets/favorite_button.dart';

class ArtistScreen extends StatefulWidget {
  final String artistId;
  
  const ArtistScreen({
    Key? key, 
    required this.artistId,
  }) : super(key: key);

  @override
  State<ArtistScreen> createState() => _ArtistScreenState();
}

class _ArtistScreenState extends State<ArtistScreen> {
  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => ArtistBloc(audioDbApi: AudioDbApi(client: TheAudioDbClient.create()))
        ..add(FetchArtistEvent(artistId: widget.artistId)),
      child: BlocListener<ArtistBloc, ArtistState>(
        listener: (context, state) {
          if (state is ArtistError) {
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(content: Text(state.message)),
            );
          }
        },
        child: BlocBuilder<ArtistBloc, ArtistState>(
          builder: (context, state) {
            if (state is ArtistLoading || state is ArtistInitial) {
              return const Scaffold(
                body: Center(child: CircularProgressIndicator(color: AppColors.primary)),
              );
            } else if (state is ArtistError) {
              return Scaffold(
                body: Center(child: Text(state.message)),
              );
            } else if (state is ArtistLoaded) {
              return Scaffold(
                body: _buildArtistContent(context, state),
              );
            } else {
              return const Scaffold(
                body: Center(child: Text('État inconnu')),
              );
            }
          },
        ),
      ),
    );
  }

  Widget _buildArtistContent(BuildContext context, ArtistLoaded state) {
    return CustomScrollView(
      slivers: [
        _buildAppBar(context, state.artist),
        SliverToBoxAdapter(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              _buildArtistInfo(state.artist),
              const SizedBox(height: 20),
              _buildAlbumSection(context, state.albums, state.isLoadingAlbums),
              const SizedBox(height: 20),
              _buildTopTracksSection(context, state.topTracks, state.isLoadingTracks),
            ],
          ),
        ),
      ],
    );
  }

  Widget _buildAppBar(BuildContext context, Artist? artist) {
    return SliverAppBar(
      expandedHeight: 344.0,
      pinned: true,
      leading: IconButton(
        icon: const Icon(Icons.arrow_back_ios, color: Colors.white),
        onPressed: () => Navigator.pop(context),
      ),
      actions: [
        Padding(
          padding: const EdgeInsets.only(top: 8.0, right: 8.0),
          child: CircleAvatar(
            backgroundColor: Colors.white,
            child: artist != null && artist.id != null
              ? FavoriteButton(
                  type: FavoriteType.artist,
                  id: artist.id!,
                  item: artist,
                )
              : const Icon(Icons.favorite_border, color: AppColors.primary),
          ),
        ),
      ],
      flexibleSpace: FlexibleSpaceBar(
        titlePadding: const EdgeInsets.only(left: 16.0, bottom: 16.0),
        title: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              artist?.name ?? 'Artiste',
              style: const TextStyle(
                color: Colors.white,
                fontWeight: FontWeight.bold,
              ),
            ),
            if (artist?.country != null && artist?.country?.isNotEmpty == true)
              Text(
                "${artist?.country} - ${artist?.genre ?? 'R&B'}",
                style: const TextStyle(
                  color: Color.fromARGB(178, 255, 255, 255),
                  fontSize: 14,
                ),
            ),
          ],
        ),
        background: Stack(
          fit: StackFit.expand,
          children: [
            artist?.fanart != null && artist?.fanart?.isNotEmpty == true
              ? Image.network(
                  artist?.fanart ?? '',
                  fit: BoxFit.cover,
                  errorBuilder: (context, error, stackTrace) => Container(
                    color: Colors.grey[300],
                    child: const Icon(Icons.image_not_supported, size: 50),
                  ),
                )
              : Container(color: Colors.grey[300]),
            Container(
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  begin: Alignment.topCenter,
                  end: Alignment.bottomCenter,
                  colors: [
                    Colors.transparent,
                    Colors.black.withAlpha(178),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildArtistInfo(Artist? artist) {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const SizedBox(height: 16),
          if (artist?.biography != null && artist?.biography?.isNotEmpty == true)
            Text(
              artist?.biography ?? '',
              style: const TextStyle(
                fontSize: 16,
                height: 1.5,
                color: Color(0xFF8D8D8D),
              ),
              maxLines: 5,
              overflow: TextOverflow.ellipsis,
            ),
        ],
      ),
    );
  }

  Widget _buildAlbumSection(BuildContext context, List<Album> albums, bool isLoading) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16.0),
          child: Text(
            "Albums (${albums.length})",
            style: const TextStyle(
              fontSize: 24,
              fontWeight: FontWeight.w800,
            ),
          ),
        ),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 10.0, vertical: 10.0),
          child: Container(
            height: 1,
            color: Colors.grey[300],
          ),
        ),
        const SizedBox(height: 12),
        isLoading
          ? const Center(child: CircularProgressIndicator(color: AppColors.primary))
          : albums.isEmpty
            ? const Center(child: Text("Aucun album trouvé"))
            : ListView.builder(
                shrinkWrap: true,
                physics: const NeverScrollableScrollPhysics(),
                itemCount: albums.length,
                padding: const EdgeInsets.symmetric(horizontal: 10.0),
                itemBuilder: (context, index) {
                  final album = albums[index];
                  return Padding(
                    padding: const EdgeInsets.only(bottom: 12.0),
                    child: ArtistAlbumItem(
                      title: album.strAlbum ?? "Album sans titre",
                      year: album.intYearReleased ?? "",
                      imageUrl: album.strAlbumThumb,
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
                    ),
                  );
                },
              ),
      ],
    );
  }

  Widget _buildTopTracksSection(BuildContext context, List<Track> tracks, bool isLoading) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Padding(
          padding: EdgeInsets.symmetric(horizontal: 16.0),
          child: Text(
            "Titres les plus appréciés",
            style: TextStyle(
              fontSize: 24,
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 10.0, vertical: 10.0),
          child: Container(
            height: 1,
            color: Colors.grey[300],
          ),
        ),
        isLoading
          ? const Center(child: CircularProgressIndicator(color: AppColors.primary))
          : tracks.isEmpty
            ? const Center(child: Text("Aucun titre trouvé"))
            : ListView.builder(
                shrinkWrap: true,
                physics: const NeverScrollableScrollPhysics(),
                itemCount: tracks.length,
                itemBuilder: (context, index) {
                  final track = tracks[index];
                  return ArtistTrackItem(
                    rank: index + 1,
                    title: track.title ?? "Titre inconnu",
                    onTap: () {
                      // Handle track play action
                    },
                  );
                },
              ),
      ],
    );
  }
}
