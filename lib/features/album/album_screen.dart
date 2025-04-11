import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:projet_flutter/core/models/album.dart';
import 'package:projet_flutter/core/models/track.dart';
import 'package:projet_flutter/core/services/the_audio_db.dart';
import 'package:projet_flutter/core/services/the_audio_db_client.dart';
import 'package:projet_flutter/core/theme/app_colors.dart';
import 'package:projet_flutter/features/album/bloc/album_bloc.dart';
import 'package:projet_flutter/features/album/bloc/album_event.dart';
import 'package:projet_flutter/features/album/bloc/album_state.dart';
import 'package:projet_flutter/features/album/widgets/album_track_item.dart';
import 'package:projet_flutter/features/favorites/widgets/favorite_button.dart';

class AlbumScreen extends StatefulWidget {
  final String albumId;
  
  const AlbumScreen({
    Key? key, 
    required this.albumId,
  }) : super(key: key);

  @override
  State<AlbumScreen> createState() => _AlbumScreenState();
}

class _AlbumScreenState extends State<AlbumScreen> {
  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => AlbumBloc(audioDbApi: AudioDbApi(client: TheAudioDbClient.create()))
        ..add(FetchAlbumEvent(albumId: widget.albumId)),
      child: BlocListener<AlbumBloc, AlbumState>(
        listener: (context, state) {
          if (state is AlbumError) {
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(content: Text(state.message)),
            );
          }
        },
        child: BlocBuilder<AlbumBloc, AlbumState>(
          builder: (context, state) {
            if (state is AlbumLoading || state is AlbumInitial) {
              return const Scaffold(
                body: Center(child: CircularProgressIndicator()),
              );
            } else if (state is AlbumError) {
              return Scaffold(
                body: Center(child: Text(state.message)),
              );
            } else if (state is AlbumLoaded) {
              return Scaffold(
                body: _buildAlbumContent(context, state),
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
  
  Widget _buildAlbumContent(BuildContext context, AlbumLoaded state) {
    final trackCount = state.tracks.length;
    return CustomScrollView(
      slivers: [
        _buildAppBar(context, state.album, trackCount),
        _buildAlbumInfo(state),
        _buildAlbumDescription(state.album),
        _buildTrackList(state.tracks),
      ],
    );
  }
  
  Widget _buildAppBar(BuildContext context, Album album, int trackCount) {
    return SliverAppBar(
      expandedHeight: 223,
      pinned: true,
      backgroundColor: Colors.black,
      title: Text(
        album.strArtist ?? 'Artiste',
        style: const TextStyle(
          color: Colors.white,
          fontSize: 16,
          fontWeight: FontWeight.w700,
        ),
      ),
      centerTitle: true,
      flexibleSpace: FlexibleSpaceBar(
        centerTitle: true,
        titlePadding: const EdgeInsets.only(bottom: 60),
        title: ConstrainedBox(
          constraints: const BoxConstraints(maxWidth: 200),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            mainAxisSize: MainAxisSize.min,
            children: [
              Text(
                album.strAlbum ?? 'Titre',
                style: const TextStyle(
                  color: Colors.white,
                  fontSize: 24,
                  fontWeight: FontWeight.w800,
                ),
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
                textAlign: TextAlign.center,
              ),
              const SizedBox(height: 5),
              Text(
                '$trackCount chansons',
                style: const TextStyle(
                  color: Colors.white70,
                  fontSize: 14,
                ),
              ),
            ],
          ),
        ),
        background: Container(
          decoration: BoxDecoration(
            color: Colors.black,
            image: DecorationImage(
              image: NetworkImage(album.strAlbumThumb ?? 
                 'https://via.placeholder.com/400x400?text=No+Image'),
              fit: BoxFit.cover,
              opacity: 0.7,
            ),
          ),
          child: Container(
            decoration: BoxDecoration(
              gradient: LinearGradient(
                begin: Alignment.topCenter,
                end: Alignment.bottomCenter,
                colors: [
                  Colors.black.withOpacity(0.7),
                  Colors.black.withOpacity(0.9),
                ],
              ),
            ),
          ),
        ),
      ),
      leading: IconButton(
        icon: const Icon(Icons.arrow_back, color: Colors.white),
        onPressed: () => Navigator.pop(context),
      ),
      actions: [
        album.idAlbum != null
          ? FavoriteButton(
              type: FavoriteType.album,
              id: album.idAlbum!,
              item: album,
            )
          : IconButton(
              icon: const Icon(Icons.favorite_border, color: Colors.white),
              onPressed: () {},
            ),
      ],
    );
  }
  
  Widget _buildAlbumInfo(AlbumLoaded state) {
    return SliverToBoxAdapter(
      child: Container(
        margin: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 16.0),
        decoration: BoxDecoration(
          color: const Color(0xFFF3F3F3),
          borderRadius: BorderRadius.circular(6.0),
        ),
        padding: const EdgeInsets.all(16.0),
        child: Row(
          children: [
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(4),
              ),
              child: Row(
                children: [
                  const Icon(Icons.star, color: Color(0xFF8D8D8D), size: 24),
                  const SizedBox(width: 8),
                  Text(
                    (double.parse(state.album.intScore ?? '0') / 2).toStringAsFixed(1) ?? 'No score',
                    style: const TextStyle(
                      fontSize: 12,
                      color: Color(0xFF8D8D8D),
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(width: 16),
            Text(
              '${state.album.intScoreVotes ?? '0'} votes',
              style: const TextStyle(
                fontSize: 14,
                color: AppColors.textPrimary,
              ),
            ),
          ],
        ),
      ),
    );
  }
  
  Widget _buildAlbumDescription(Album album) {
    return SliverToBoxAdapter(
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              album.strDescriptionEN ?? 
              'Lorem Ipsum is simply dummy text of the printing and typesetting industry. Lorem Ipsum has been the industry\'s standard dummy text ever since the 1500s, when an unknown printer took a galley of type and scrambled it to make...',
              style: TextStyle(
                fontSize: 16,
                color: const Color(0xFF8D8D8D),
              ),
              maxLines: 5,
              overflow: TextOverflow.ellipsis,
            ),
            const SizedBox(height: 36),
            const Text(
              'Titres',
              style: TextStyle(
                fontSize: 24,
                fontWeight: FontWeight.w800,
              ),
            ),
            const Divider(
              color: Color(0xFFE6E6E6),
            ),
          ],
        ),
      ),
    );
  }
  
  Widget _buildTrackList(List<Track> tracks) {
    return SliverList(
      delegate: SliverChildBuilderDelegate(
        (context, index) {
          return Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16.0),
            child: AlbumTrackItem(
              track: tracks[index],
              index: index,
            ),
          );
        },
        childCount: tracks.length,
      ),
    );
  }
}
