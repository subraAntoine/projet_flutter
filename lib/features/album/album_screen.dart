import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:projet_flutter/core/models/album.dart';
import 'package:projet_flutter/core/models/track.dart';
import 'package:projet_flutter/core/services/the_audio_db.dart';
import 'package:projet_flutter/core/services/the_audio_db_client.dart';
import 'package:projet_flutter/features/album/bloc/album_bloc.dart';
import 'package:projet_flutter/features/album/bloc/album_event.dart';
import 'package:projet_flutter/features/album/bloc/album_state.dart';
import 'package:projet_flutter/features/album/widgets/album_track_item.dart';

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
    return CustomScrollView(
      slivers: [
        _buildAppBar(context, state.album),
        _buildAlbumInfo(state),
        _buildAlbumDescription(state.album),
        _buildTrackList(state.tracks),
      ],
    );
  }
  
  Widget _buildAppBar(BuildContext context, Album album) {
    return SliverAppBar(
      expandedHeight: 223,
      pinned: true,
      flexibleSpace: FlexibleSpaceBar(
        title: Text(
          album.strAlbum ?? 'Unknown Album',
          style: const TextStyle(
            color: Colors.white,
            fontWeight: FontWeight.bold,
          ),
        ),
        background: Container(
          decoration: BoxDecoration(
            image: DecorationImage(
              image: NetworkImage(album.strAlbumThumb ?? 
                 'https://via.placeholder.com/400x400?text=No+Image'),
              fit: BoxFit.cover,
            ),
          ),
          child: Container(
            decoration: BoxDecoration(
              gradient: LinearGradient(
                begin: Alignment.topCenter,
                end: Alignment.bottomCenter,
                colors: [
                  Colors.transparent,
                  Colors.black.withOpacity(0.7),
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
        IconButton(
          icon: const Icon(Icons.favorite_border, color: Colors.white),
          onPressed: () {},
        ),
      ],
    );
  }
  
  Widget _buildAlbumInfo(AlbumLoaded state) {
    return SliverToBoxAdapter(
      child: Container(
        color: Colors.grey[200],
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              '${state.album.strArtist ?? "Unknown Artist"}',
              style: const TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 8),
            Row(
              children: [
                const Icon(Icons.star, color: Colors.amber, size: 18),
                const SizedBox(width: 4),
                Text(
                  state.rating.toString(),
                  style: const TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const SizedBox(width: 12),
                Text(
                  '${state.voteCount} votes',
                  style: TextStyle(
                    fontSize: 16,
                    color: Colors.grey[600],
                  ),
                ),
              ],
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
                fontSize: 14,
                color: Colors.grey[600],
              ),
              maxLines: 5,
              overflow: TextOverflow.ellipsis,
            ),
            const SizedBox(height: 24),
            const Text(
              'Titres',
              style: TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.bold,
              ),
            ),
            const Divider(),
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
