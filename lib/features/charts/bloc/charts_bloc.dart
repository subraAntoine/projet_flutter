import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:projet_flutter/core/services/the_audio_db.dart';
import 'package:projet_flutter/core/services/the_audio_db_client.dart';
import 'package:projet_flutter/features/charts/bloc/charts_event.dart';
import 'package:projet_flutter/features/charts/bloc/charts_state.dart';
import 'dart:developer' as developer;

class ChartsBloc extends Bloc<ChartsEvent, ChartsState> {
  final AudioDbApi _audioDbApi;

  ChartsBloc({required AudioDbApi audioDbApi}) 
      : _audioDbApi = audioDbApi,
        super(ChartsInitial()) {
    on<FetchChartsEvent>(_onFetchCharts);
    on<RefreshChartsEvent>(_onRefreshCharts);
  }

  Future<void> _onFetchCharts(
    FetchChartsEvent event,
    Emitter<ChartsState> emit,
  ) async {
    emit(ChartsLoading());
    await _fetchData(emit);
  }

  Future<void> _onRefreshCharts(
    RefreshChartsEvent event,
    Emitter<ChartsState> emit,
  ) async {
    await _fetchData(emit);
  }

  Future<void> _fetchData(Emitter<ChartsState> emit) async {
    try {
      developer.log('Fetching data...');
      final tracks = await _audioDbApi.fetchTrendingSingles();
      developer.log('Tracks fetched: ${tracks.length}');
      final albums = await _audioDbApi.fetchTrendingAlbums();
      developer.log('Albums fetched: ${albums.length}');
      
      emit(ChartsLoaded(tracks: tracks, albums: albums));
      developer.log('State updated with ${tracks.length} tracks and ${albums.length} albums');
    } catch (e) {
      developer.log('Error in _fetchData: $e');
      emit(ChartsError(message: 'Erreur lors du chargement des données: $e'));
    }
  }
} 