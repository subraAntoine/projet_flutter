import 'package:flutter/material.dart';
import 'package:projet_flutter/core/services/the_audio_db.dart';
import 'package:projet_flutter/core/theme/app_colors.dart';
import 'package:projet_flutter/features/charts/widgets/chart_item.dart';
import 'package:projet_flutter/core/models/album.dart';
import 'package:projet_flutter/core/models/track.dart';
import 'dart:developer' as developer;

class ChartsScreen extends StatefulWidget {
  const ChartsScreen({super.key});

  @override
  State<ChartsScreen> createState() => _ChartsScreenState();
}

class _ChartsScreenState extends State<ChartsScreen> with SingleTickerProviderStateMixin {
  late TabController _tabController;
  final AudioDbApi _audioDbApi = AudioDbApi();
  List<Track> _tracks = [];
  List<Album> _albums = [];
  bool _isLoading = true;

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 2, vsync: this);
    _fetchData();
  }

  Future<void> _fetchData() async {
    setState(() => _isLoading = true);
    try {
      developer.log('Fetching data...');
      final tracks = await _audioDbApi.fetchTrendingSingles();
      developer.log('Tracks fetched: ${tracks.length}');
      final albums = await _audioDbApi.fetchTrendingAlbums();
      developer.log('Albums fetched: ${albums.length}');
      
      setState(() {
        _tracks = tracks;
        _albums = albums;
        _isLoading = false;
      });
      developer.log('State updated with ${_tracks.length} tracks and ${_albums.length} albums');
    } catch (e) {
      developer.log('Error in _fetchData: $e');
      setState(() => _isLoading = false);
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Erreur lors du chargement des données: $e')),
        );
      }
    }
  }

  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Padding(
              padding: EdgeInsets.only(left: 8.0),
              child: Text(
                'Classements',
                style: TextStyle(
                  fontSize: 36,
                  fontWeight: FontWeight.w800,
                ),
              ),
            ),
            TabBar(
              controller: _tabController,
              labelColor: AppColors.primary,
              unselectedLabelColor: Colors.grey,
              indicatorColor: AppColors.primary,
              indicatorSize: TabBarIndicatorSize.tab,
              tabs: const [
                Tab(text: 'Titres'),
                Tab(text: 'Albums'),
              ],
            ),
            Expanded(
              child: _isLoading
                  ? const Center(child: CircularProgressIndicator(
                    color: AppColors.primary,
                  ))
                  : TabBarView(
                      controller: _tabController,
                      children: [
                        // Titres tab
                        RefreshIndicator(
                          color: AppColors.primary,
                          backgroundColor: AppColors.background,
                          onRefresh: _fetchData,
                          child: _tracks.isEmpty
                              ? const Center(child: Text('Aucun titre disponible'))
                              : ListView.builder(
                                  itemCount: _tracks.length,
                                  itemBuilder: (context, index) {
                                    final track = _tracks[index];
                                    return ChartItem(
                                      rank: index + 1,
                                      imageUrl: track.trackThumb ?? '',
                                      title: track.title,
                                      artist: track.artist,
                                      artistId: track.artistId,
                                    );
                                  },
                                ),
                        ),
                        // Albums tab
                        RefreshIndicator(
                          color: AppColors.primary,
                          backgroundColor: AppColors.background,
                          onRefresh: _fetchData,
                          child: _albums.isEmpty
                              ? const Center(child: Text('Aucun album disponible'))
                              : ListView.builder(
                                  itemCount: _albums.length,
                                  itemBuilder: (context, index) {
                                    final album = _albums[index];
                                    return ChartItem(
                                      rank: index + 1,
                                      imageUrl: album.strAlbumThumb,
                                      title: album.strAlbum,
                                      artist: album.strArtist,
                                      artistId: album.idArtist,
                                    );
                                  },
                                ),
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
