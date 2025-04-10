import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:projet_flutter/core/services/the_audio_db.dart';
import 'package:projet_flutter/core/models/track.dart';
import 'package:projet_flutter/features/album/bloc/album_event.dart';
import 'package:projet_flutter/features/album/bloc/album_state.dart';
import 'dart:developer' as developer;

class AlbumBloc extends Bloc<AlbumEvent, AlbumState> {
  final AudioDbApi _audioDbApi;

  AlbumBloc({required AudioDbApi audioDbApi}) 
      : _audioDbApi = audioDbApi,
        super(AlbumInitial()) {
    on<FetchAlbumEvent>(_onFetchAlbum);
    on<FetchAlbumTracksEvent>(_onFetchAlbumTracks);
    on<RefreshAlbumEvent>(_onRefreshAlbum);
  }

  Future<void> _onFetchAlbum(
    FetchAlbumEvent event,
    Emitter<AlbumState> emit,
  ) async {
    emit(AlbumLoading());
    
    try {
      developer.log('Fetching album data for ID: ${event.albumId}');
      final album = await _audioDbApi.fetchAlbumById(event.albumId);
      
      if (album != null) {
        developer.log('Album data fetched successfully: ${album.strAlbum}');
        
        // Mocking rating and vote count data for the UI
        final rating = 4.9;
        final voteCount = 348;
        
        emit(AlbumLoaded(
          album: album,
          rating: rating,
          voteCount: voteCount,
        ));
        
        // Fetch tracks for this album
        add(FetchAlbumTracksEvent(albumId: event.albumId));
      } else {
        developer.log('No album data found');
        emit(const AlbumError(message: 'Aucune information trouvée pour cet album'));
      }
    } catch (e) {
      developer.log('Error fetching album data: $e');
      emit(AlbumError(message: 'Erreur lors du chargement des données: $e'));
    }
  }

  Future<void> _onFetchAlbumTracks(
    FetchAlbumTracksEvent event,
    Emitter<AlbumState> emit,
  ) async {
    if (state is AlbumLoaded) {
      final currentState = state as AlbumLoaded;
      emit(currentState.copyWith(isLoadingTracks: true));
      
      try {
        developer.log('Fetching tracks for album ID: ${event.albumId}');
        
        final tracks = await _audioDbApi.fetchAlbumTracks(event.albumId);
        
        developer.log('Tracks fetched successfully: ${tracks.length}');
        
        if (state is AlbumLoaded) {
          final updatedState = (state as AlbumLoaded);
          emit(updatedState.copyWith(
            tracks: tracks,
            isLoadingTracks: false,
          ));
        }
      } catch (e) {
        developer.log('Error fetching tracks: $e');
        if (state is AlbumLoaded) {
          final updatedState = (state as AlbumLoaded);
          emit(updatedState.copyWith(isLoadingTracks: false));
        }
      }
    }
  }

  Future<void> _onRefreshAlbum(
    RefreshAlbumEvent event,
    Emitter<AlbumState> emit,
  ) async {
    add(FetchAlbumEvent(albumId: event.albumId));
  }
} 