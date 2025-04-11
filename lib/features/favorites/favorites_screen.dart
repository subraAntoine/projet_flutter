import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'bloc/favorites_bloc.dart';
import 'widgets/favorite_artist_item.dart';
import 'widgets/favorite_album_item.dart';

class FavoritesScreen extends StatefulWidget {
  const FavoritesScreen({super.key});

  @override
  State<FavoritesScreen> createState() => _FavoritesScreenState();
}

class _FavoritesScreenState extends State<FavoritesScreen> {
  @override
  void initState() {
    super.initState();
    // Load favorites when screen is initialized
    context.read<FavoritesBloc>().add(const LoadFavorites());
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: BlocBuilder<FavoritesBloc, FavoritesState>(
          builder: (context, state) {
            if (state.isLoading) {
              return const Center(child: CircularProgressIndicator());
            }
            
            if (state.error != null) {
              return Center(child: Text('Error: ${state.error}'));
            }
            
            return CustomScrollView(
              slivers: [
                // Header
                SliverToBoxAdapter(
                  child: Container(
                    decoration: BoxDecoration(
                      border: Border(
                        bottom: BorderSide(
                          color: const Color(0xFFE6E6E6),
                          width: 1.0,
                        ),
                      ),
                    ),
                    child: Padding(
                      padding: const EdgeInsets.fromLTRB(16, 16, 16, 0),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const Text(
                            'Favoris',
                            style: TextStyle(
                              fontSize: 36,
                              fontWeight: FontWeight.w800,
                            ),
                          ),
                          const Text(
                            'Mes artistes & albums',
                            style: TextStyle(
                              fontSize: 14,
                              color: Color(0xFF8D8D8D),
                            ),
                          ),
                          const SizedBox(height: 12),
                        ],
                      ),
                    ),
                  ),
                ),
                
                // Artists section
                SliverToBoxAdapter(
                  child: Container(
                    margin: const EdgeInsets.fromLTRB(16, 32, 16, 8),
                    alignment: Alignment.centerLeft,
                    decoration: const BoxDecoration(
                      border: Border(
                        bottom: BorderSide(
                          color: Color(0xFFE6E6E6),
                          width: 1.0,
                        ),
                      ),
                    ),
                    child: const Padding(
                      padding: EdgeInsets.only(bottom: 8),
                      child: Text(
                        'Artistes',
                        style: TextStyle(
                          fontSize: 24,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                  ),
                ),
                
                // Artists list
                SliverToBoxAdapter(
                  child: state.favoriteArtists.isEmpty
                    ? const Padding(
                        padding: EdgeInsets.all(16),
                        child: Text('Aucun artiste favori'),
                      )
                    : ListView.builder(
                        shrinkWrap: true,
                        physics: const NeverScrollableScrollPhysics(),
                        itemCount: state.favoriteArtists.length,
                        itemBuilder: (context, index) {
                          return FavoriteArtistItem(
                            artist: state.favoriteArtists[index],
                          );
                        },
                      ),
                ),
                
                // Albums section
                SliverToBoxAdapter(
                  child: Container(
                    margin: const EdgeInsets.fromLTRB(16, 24, 16, 8),
                    alignment: Alignment.centerLeft,
                    decoration: const BoxDecoration(
                      border: Border(
                        bottom: BorderSide(
                          color: Color(0xFFE6E6E6),
                          width: 1.0,
                        ),
                      ),
                    ),
                    child: const Padding(
                      padding: EdgeInsets.only(bottom: 8),
                      child: Text(
                        'Albums',
                        style: TextStyle(
                          fontSize: 24,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                  ),
                ),
                
                // Albums list
                SliverToBoxAdapter(
                  child: state.favoriteAlbums.isEmpty
                    ? const Padding(
                        padding: EdgeInsets.all(16),
                        child: Text('Aucun album favori'),
                      )
                    : ListView.builder(
                        shrinkWrap: true,
                        physics: const NeverScrollableScrollPhysics(),
                        itemCount: state.favoriteAlbums.length,
                        itemBuilder: (context, index) {
                          return FavoriteAlbumItem(
                            album: state.favoriteAlbums[index],
                          );
                        },
                      ),
                ),
                
                // Bottom padding
                const SliverToBoxAdapter(
                  child: SizedBox(height: 24),
                ),
              ],
            );
          },
        ),
      ),
    );
  }
}
