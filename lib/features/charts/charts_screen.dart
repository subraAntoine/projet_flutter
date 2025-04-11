import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:projet_flutter/core/services/the_audio_db.dart';
import 'package:projet_flutter/core/services/the_audio_db_client.dart';
import 'package:projet_flutter/core/theme/app_colors.dart';
import 'package:projet_flutter/features/charts/bloc/charts_bloc.dart';
import 'package:projet_flutter/features/charts/bloc/charts_event.dart';
import 'package:projet_flutter/features/charts/bloc/charts_state.dart';
import 'package:projet_flutter/features/charts/widgets/chart_item.dart';

class ChartsScreen extends StatefulWidget {
  const ChartsScreen({super.key});

  @override
  State<ChartsScreen> createState() => _ChartsScreenState();
}

class _ChartsScreenState extends State<ChartsScreen> with SingleTickerProviderStateMixin {
  late TabController _tabController;
  
  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 2, vsync: this);
  }

  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => ChartsBloc(
        audioDbApi: AudioDbApi(client: TheAudioDbClient.create()),
      )..add(FetchChartsEvent()),
      child: BlocListener<ChartsBloc, ChartsState>(
        listener: (context, state) {
          if (state is ChartsError) {
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(content: Text(state.message)),
            );
          }
        },
        child: Scaffold(
          body: SafeArea(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Padding(
                  padding: EdgeInsets.only(left: 16.0),
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
                  child: BlocBuilder<ChartsBloc, ChartsState>(
                    builder: (context, state) {
                      if (state is ChartsLoading || state is ChartsInitial) {
                        return const Center(child: CircularProgressIndicator(
                          color: AppColors.primary,
                        ));
                      } else if (state is ChartsLoaded) {
                        return TabBarView(
                          controller: _tabController,
                          children: [
                            // Titres tab
                            RefreshIndicator(
                              color: AppColors.primary,
                              backgroundColor: AppColors.background,
                              onRefresh: () async {
                                context.read<ChartsBloc>().add(RefreshChartsEvent());
                              },
                              child: state.tracks.isEmpty
                                  ? const Center(child: Text('Aucun titre disponible'))
                                  : ListView.builder(
                                      itemCount: state.tracks.length,
                                      itemBuilder: (context, index) {
                                        final track = state.tracks[index];
                                        return ChartItem(
                                          rank: index + 1,
                                          imageUrl: track.trackThumb ?? '',
                                          title: track.title ?? 'Unknown Title',
                                          artist: track.artist ?? 'Unknown Artist', 
                                          artistId: track.artistId,
                                        );
                                      },
                                    ),
                            ),
                            // Albums tab
                            RefreshIndicator(
                              color: AppColors.primary,
                              backgroundColor: AppColors.background,
                              onRefresh: () async {
                                context.read<ChartsBloc>().add(RefreshChartsEvent());
                              },
                              child: state.albums.isEmpty
                                  ? const Center(child: Text('Aucun album disponible'))
                                  : ListView.builder(
                                      itemCount: state.albums.length,
                                      itemBuilder: (context, index) {
                                        final album = state.albums[index];
                                        return ChartItem(
                                          rank: index + 1,
                                          imageUrl: album.strAlbumThumb ?? '',
                                          title: album.strAlbum ?? 'Unknown Album',
                                          artist: album.strArtist ?? 'Unknown Artist',
                                          artistId: album.idArtist,
                                          albumId: album.idAlbum,
                                        );
                                      },
                                    ),
                            ),
                          ],
                        );
                      } else if (state is ChartsError) {
                        return Center(
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Text('Erreur: ${state.message}'),
                              const SizedBox(height: 16),
                              ElevatedButton(
                                onPressed: () {
                                  context.read<ChartsBloc>().add(FetchChartsEvent());
                                },
                                child: const Text('Réessayer'),
                              ),
                            ],
                          ),
                        );
                      } else {
                        return const Center(child: Text('État inconnu'));
                      }
                    },
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
