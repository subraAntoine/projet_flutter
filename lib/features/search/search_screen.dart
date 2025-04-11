import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:projet_flutter/core/models/album.dart';
import 'package:projet_flutter/core/models/artist.dart';
import 'package:projet_flutter/core/services/the_audio_db.dart';
import 'package:projet_flutter/core/theme/app_colors.dart';
import 'package:projet_flutter/features/search/bloc/search_bloc.dart';
import 'package:projet_flutter/features/search/bloc/search_event.dart';
import 'package:projet_flutter/features/search/bloc/search_state.dart';
import 'package:projet_flutter/features/artists/artists_screen.dart';
import 'package:projet_flutter/features/album/album_screen.dart';

class SearchScreen extends StatelessWidget {
  const SearchScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => SearchBloc(
        audioDbApi: AudioDbApi(),
      ),
      child: const SearchView(),
    );
  }
}

class SearchView extends StatefulWidget {
  const SearchView({Key? key}) : super(key: key);

  @override
  State<SearchView> createState() => _SearchViewState();
}

class _SearchViewState extends State<SearchView> {
  final TextEditingController _searchController = TextEditingController();

  @override
  void dispose() {
    _searchController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
              child: Text(
                'Rechercher',
                style: Theme.of(context).textTheme.headlineMedium?.copyWith(
                  fontWeight: FontWeight.w900,
                  fontSize: 36,
                ),
              ),
            ),
            _SearchBar(controller: _searchController),
            BlocConsumer<SearchBloc, SearchState>(
              listener: (context, state) {
                if (state.status == SearchStatus.failure && state.errorMessage != null) {
                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(content: Text('Erreur: ${state.errorMessage}')),
                  );
                }
              },
              builder: (context, state) {
                if (state.status == SearchStatus.loading) {
                  return const Padding(
                    padding: EdgeInsets.all(16.0),
                    child: Center(child: CircularProgressIndicator(color: AppColors.primary)),
                  );
                }
                
                return Expanded(
                  child: ListView(
                    children: [
                      if (state.artists.isNotEmpty || state.searchTerm.isNotEmpty) ...[
                        const _SectionTitle(title: 'Artistes'),
                        ...state.artists.map((artist) => _ArtistItem(artist: artist)),
                      ],
                      
                      if (state.albums.isNotEmpty || state.searchTerm.isNotEmpty) ...[
                        const _SectionTitle(title: 'Albums'),
                        ...state.albums.map((album) => _AlbumItem(album: album)),
                      ],
                    ],
                  ),
                );
              },
            ),
          ],
        ),
      ),
    );
  }
}

class _SearchBar extends StatelessWidget {
  final TextEditingController controller;

  const _SearchBar({
    Key? key,
    required this.controller,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<SearchBloc, SearchState>(
      buildWhen: (previous, current) => previous.searchTerm != current.searchTerm,
      builder: (context, state) {
        controller.text = state.searchTerm;
        controller.selection = TextSelection.fromPosition(
          TextPosition(offset: controller.text.length),
        );
        
        return Container(
          width: double.infinity,
          decoration: const BoxDecoration(
            border: Border(
              bottom: BorderSide(
                color: Color(0xFFE6E6E6),
                width: 1.0,
              ),
            ),
          ),
          child: Padding(
            padding: const EdgeInsets.only(bottom: 16.0, left: 16.0, right: 16.0),
            child: SizedBox(
              height: 36,
              child: TextField(
                controller: controller,
                decoration: InputDecoration(
                  hintText: 'Rechercher',
                  hintStyle: TextStyle(color: Colors.black.withOpacity(0.6)),
                  prefixIcon: const Icon(Icons.search, color: Colors.grey),
                  suffixIcon: state.searchTerm.isNotEmpty
                    ? IconButton(
                        icon: const Icon(Icons.clear, color: Colors.grey),
                        onPressed: () {
                          context.read<SearchBloc>().add(SearchCleared());
                          controller.clear();
                        },
                      )
                    : null,
                  filled: true,
                  fillColor: Colors.grey[200],
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(8.0),
                    borderSide: BorderSide.none,
                  ),
                  contentPadding: const EdgeInsets.symmetric(vertical: 0),
                ),
                onSubmitted: (value) {
                  context.read<SearchBloc>().add(SearchSubmitted(value));
                },
                onChanged: (value) {
                  context.read<SearchBloc>().add(SearchTermChanged(value));
                },
              ),
            ),
          ),
        );
      },
    );
  }
}

class _SectionTitle extends StatelessWidget {
  final String title;
  
  const _SectionTitle({
    Key? key,
    required this.title,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.fromLTRB(16.0, 24.0, 16.0, 8.0),
          child: Text(
            title,
            style: const TextStyle(
              fontSize: 24,
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16.0),
          child: const Divider(height: 1, thickness: 1, color: Color(0xFFE6E6E6)),
        ),
        const SizedBox(height: 16.0),
      ],
    );
  }
}

class _ArtistItem extends StatelessWidget {
  final Artist artist;
  
  const _ArtistItem({
    Key? key,
    required this.artist,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 4.0),
      child: Container(
        height: 70,
        decoration: BoxDecoration(
          color: const Color(0xFFF5F5F5),
          borderRadius: BorderRadius.circular(6.0),
        ),
        child: Center(
          child: ListTile(
            dense: true,
            contentPadding: const EdgeInsets.symmetric(horizontal: 16.0),
            leading: ClipOval(
              child: artist.thumb != null
                ? Image.network(
                    artist.thumb!,
                    width: 50,
                    height: 50,
                    fit: BoxFit.cover,
                    errorBuilder: (context, error, stackTrace) => const CircleAvatar(
                      radius: 25,
                      backgroundColor: Colors.white,
                      child: Icon(Icons.person, color: Colors.grey),
                    ),
                  )
                : const CircleAvatar(
                    radius: 25,
                    backgroundColor: Colors.white,
                    child: Icon(Icons.person, color: Colors.grey),
                  ),
            ),
            title: Text(
              artist.name ?? 'Inconnu',
              style: const TextStyle(
                fontWeight: FontWeight.w700,
                fontSize: 16,
              ),
            ),
            trailing: const Icon(Icons.chevron_right, color: Colors.grey),
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
          ),
        ),
      ),
    );
  }
}

class _AlbumItem extends StatelessWidget {
  final Album album;
  
  const _AlbumItem({
    Key? key,
    required this.album,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 4.0),
      child: Container(
        height: 70,
        decoration: BoxDecoration(
          color: const Color(0xFFF5F5F5),
          borderRadius: BorderRadius.circular(6.0),
        ),
        child: Center(
          child: ListTile(
            dense: true,
            contentPadding: const EdgeInsets.symmetric(horizontal: 16.0),
            leading: album.strAlbumThumb != null
              ? ClipRRect(
                  borderRadius: BorderRadius.circular(4.0),
                  child: Image.network(
                    album.strAlbumThumb!,
                    width: 50,
                    height: 50,
                    fit: BoxFit.cover,
                    errorBuilder: (context, error, stackTrace) => Container(
                      width: 50,
                      height: 50,
                      color: Colors.grey[300],
                      child: const Icon(Icons.album, color: Colors.white),
                    ),
                  ),
                )
              : Container(
                  width: 50,
                  height: 50,
                  decoration: BoxDecoration(
                    color: Colors.grey[300],
                    borderRadius: BorderRadius.circular(4.0),
                  ),
                  child: const Icon(Icons.album, color: Colors.white),
                ),
            title: Text(
              album.strAlbum ?? 'Inconnu',
              style: const TextStyle(
                fontWeight: FontWeight.w700,
                fontSize: 16,
              ),
            ),
            subtitle: Text(
              album.strArtist ?? '',
              style: TextStyle(
                color: const Color(0xFF8D8D8D),
                fontSize: 14,
              ),
            ),
            trailing: const Icon(Icons.chevron_right, color: Colors.grey),
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
        ),
      ),
    );
  }
}

