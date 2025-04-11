import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:projet_flutter/core/services/the_audio_db.dart';
import 'package:projet_flutter/features/search/bloc/search_event.dart';
import 'package:projet_flutter/features/search/bloc/search_state.dart';
import 'dart:async';

class SearchBloc extends Bloc<SearchEvent, SearchState> {
  final AudioDbApi _audioDbApi;
  
  SearchBloc({required AudioDbApi audioDbApi}) 
      : _audioDbApi = audioDbApi,
        super(const SearchState()) {
    on<SearchTermChanged>(_onSearchTermChanged);
    on<SearchSubmitted>(_onSearchSubmitted);
    on<SearchCleared>(_onSearchCleared);
  }
  
  FutureOr<void> _onSearchTermChanged(
    SearchTermChanged event, 
    Emitter<SearchState> emit,
  ) {
    emit(state.copyWith(searchTerm: event.term));
  }
  
  FutureOr<void> _onSearchSubmitted(
    SearchSubmitted event, 
    Emitter<SearchState> emit,
  ) async {
    if (event.term.isEmpty) return;
    
    emit(state.copyWith(status: SearchStatus.loading));
    
    try {
      final artists = await _audioDbApi.searchArtistByName(event.term);
      final albums = await _audioDbApi.searchAlbumsByArtist(event.term);
      
      emit(state.copyWith(
        status: SearchStatus.success,
        artists: artists,
        albums: albums,
      ));
    } catch (e) {
      emit(state.copyWith(
        status: SearchStatus.failure,
        errorMessage: e.toString(),
      ));
    }
  }
  
  FutureOr<void> _onSearchCleared(
    SearchCleared event, 
    Emitter<SearchState> emit,
  ) {
    emit(const SearchState());
  }
} 