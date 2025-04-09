import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:projet_flutter/core/services/the_audio_db.dart';
import 'package:projet_flutter/core/services/the_audio_db_client.dart';
import 'package:projet_flutter/features/artists/bloc/artist_event.dart';
import 'package:projet_flutter/features/artists/bloc/artist_state.dart';
import 'dart:developer' as developer;

class ArtistBloc extends Bloc<ArtistEvent, ArtistState> {
  final AudioDbApi _audioDbApi;

  ArtistBloc({required AudioDbApi audioDbApi}) 
      : _audioDbApi = audioDbApi,
        super(ArtistInitial()) {
    on<FetchArtistEvent>(_onFetchArtist);
    on<FetchArtistAlbumsEvent>(_onFetchArtistAlbums);
    on<FetchArtistTopTracksEvent>(_onFetchArtistTopTracks);
    on<RefreshArtistDataEvent>(_onRefreshArtistData);
  }

  Future<void> _onFetchArtist(
    FetchArtistEvent event,
    Emitter<ArtistState> emit,
  ) async {
    emit(ArtistLoading());
    
    try {
      developer.log('Fetching artist data for ID: ${event.artistId}');
      final artistList = await _audioDbApi.fetchArtistData(event.artistId);
      
      if (artistList.isNotEmpty) {
        final artist = artistList.first;
        developer.log('Artist data fetched successfully: ${artist.name}');
        emit(ArtistLoaded(artist: artist));
        
        // Fetch additional data
        add(FetchArtistAlbumsEvent(artistId: event.artistId));
        add(FetchArtistTopTracksEvent(artistId: event.artistId));
      } else {
        developer.log('No artist data found');
        emit(const ArtistError(message: 'Aucune information trouvée pour cet artiste'));
      }
    } catch (e) {
      developer.log('Error fetching artist data: $e');
      emit(ArtistError(message: 'Erreur lors du chargement des données: $e'));
    }
  }

  Future<void> _onFetchArtistAlbums(
    FetchArtistAlbumsEvent event,
    Emitter<ArtistState> emit,
  ) async {
    if (state is ArtistLoaded) {
      final currentState = state as ArtistLoaded;
      emit(currentState.copyWith(isLoadingAlbums: true));
      
      try {
        developer.log('Fetching albums for artist ID: ${event.artistId}');
        final albums = await _audioDbApi.fetchArtistAlbums(event.artistId);
        developer.log('Albums fetched successfully: ${albums.length}');
        
        if (state is ArtistLoaded) {
          final updatedState = (state as ArtistLoaded);
          emit(updatedState.copyWith(
            albums: albums,
            isLoadingAlbums: false,
          ));
        }
      } catch (e) {
        developer.log('Error fetching albums: $e');
        if (state is ArtistLoaded) {
          final updatedState = (state as ArtistLoaded);
          emit(updatedState.copyWith(isLoadingAlbums: false));
        }
      }
    }
  }

  Future<void> _onFetchArtistTopTracks(
    FetchArtistTopTracksEvent event,
    Emitter<ArtistState> emit,
  ) async {
    if (state is ArtistLoaded) {
      final currentState = state as ArtistLoaded;
      emit(currentState.copyWith(isLoadingTracks: true));
      
      try {
        developer.log('Fetching top tracks for artist ID: ${event.artistId}');
        final tracks = await _audioDbApi.fetchArtistTopTracks(event.artistId);
        developer.log('Top tracks fetched successfully: ${tracks.length}');
        
        if (state is ArtistLoaded) {
          final updatedState = (state as ArtistLoaded);
          emit(updatedState.copyWith(
            topTracks: tracks,
            isLoadingTracks: false,
          ));
        }
      } catch (e) {
        developer.log('Error fetching top tracks: $e');
        if (state is ArtistLoaded) {
          final updatedState = (state as ArtistLoaded);
          emit(updatedState.copyWith(isLoadingTracks: false));
        }
      }
    }
  }

  Future<void> _onRefreshArtistData(
    RefreshArtistDataEvent event,
    Emitter<ArtistState> emit,
  ) async {
    add(FetchArtistEvent(artistId: event.artistId));
  }
} 