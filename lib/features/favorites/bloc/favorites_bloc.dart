import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:equatable/equatable.dart';
import '../../../core/services/favorites_service.dart';
import '../../../core/models/artist.dart';
import '../../../core/models/album.dart';

// Events
abstract class FavoritesEvent extends Equatable {
  const FavoritesEvent();

  @override
  List<Object?> get props => [];
}

class LoadFavorites extends FavoritesEvent {
  const LoadFavorites();
}

class AddFavoriteArtist extends FavoritesEvent {
  final Artist artist;

  const AddFavoriteArtist(this.artist);

  @override
  List<Object?> get props => [artist];
}

class RemoveFavoriteArtist extends FavoritesEvent {
  final String artistId;

  const RemoveFavoriteArtist(this.artistId);

  @override
  List<Object?> get props => [artistId];
}

class AddFavoriteAlbum extends FavoritesEvent {
  final Album album;

  const AddFavoriteAlbum(this.album);

  @override
  List<Object?> get props => [album];
}

class RemoveFavoriteAlbum extends FavoritesEvent {
  final String albumId;

  const RemoveFavoriteAlbum(this.albumId);

  @override
  List<Object?> get props => [albumId];
}

// State
class FavoritesState extends Equatable {
  final List<Artist> favoriteArtists;
  final List<Album> favoriteAlbums;
  final bool isLoading;
  final String? error;

  const FavoritesState({
    this.favoriteArtists = const [],
    this.favoriteAlbums = const [],
    this.isLoading = false,
    this.error,
  });

  FavoritesState copyWith({
    List<Artist>? favoriteArtists,
    List<Album>? favoriteAlbums,
    bool? isLoading,
    String? error,
  }) {
    return FavoritesState(
      favoriteArtists: favoriteArtists ?? this.favoriteArtists,
      favoriteAlbums: favoriteAlbums ?? this.favoriteAlbums,
      isLoading: isLoading ?? this.isLoading,
      error: error ?? this.error,
    );
  }

  @override
  List<Object?> get props => [favoriteArtists, favoriteAlbums, isLoading, error];
}

// Bloc
class FavoritesBloc extends Bloc<FavoritesEvent, FavoritesState> {
  final FavoritesService _favoritesService = FavoritesService();

  FavoritesBloc() : super(const FavoritesState()) {
    on<LoadFavorites>(_onLoadFavorites);
    on<AddFavoriteArtist>(_onAddFavoriteArtist);
    on<RemoveFavoriteArtist>(_onRemoveFavoriteArtist);
    on<AddFavoriteAlbum>(_onAddFavoriteAlbum);
    on<RemoveFavoriteAlbum>(_onRemoveFavoriteAlbum);
  }

  Future<void> _onLoadFavorites(
    LoadFavorites event,
    Emitter<FavoritesState> emit,
  ) async {
    emit(state.copyWith(isLoading: true));
    try {
      final artists = await _favoritesService.getFavoriteArtists();
      final albums = await _favoritesService.getFavoriteAlbums();
      emit(state.copyWith(
        favoriteArtists: artists,
        favoriteAlbums: albums,
        isLoading: false,
      ));
    } catch (e) {
      emit(state.copyWith(
        isLoading: false,
        error: 'Failed to load favorites: ${e.toString()}',
      ));
    }
  }

  Future<void> _onAddFavoriteArtist(
    AddFavoriteArtist event,
    Emitter<FavoritesState> emit,
  ) async {
    try {
      await _favoritesService.addFavoriteArtist(event.artist);
      final updatedArtists = await _favoritesService.getFavoriteArtists();
      emit(state.copyWith(favoriteArtists: updatedArtists));
    } catch (e) {
      emit(state.copyWith(
        error: 'Failed to add artist to favorites: ${e.toString()}',
      ));
    }
  }

  Future<void> _onRemoveFavoriteArtist(
    RemoveFavoriteArtist event,
    Emitter<FavoritesState> emit,
  ) async {
    try {
      await _favoritesService.removeFavoriteArtist(event.artistId);
      final updatedArtists = await _favoritesService.getFavoriteArtists();
      emit(state.copyWith(favoriteArtists: updatedArtists));
    } catch (e) {
      emit(state.copyWith(
        error: 'Failed to remove artist from favorites: ${e.toString()}',
      ));
    }
  }

  Future<void> _onAddFavoriteAlbum(
    AddFavoriteAlbum event,
    Emitter<FavoritesState> emit,
  ) async {
    try {
      await _favoritesService.addFavoriteAlbum(event.album);
      final updatedAlbums = await _favoritesService.getFavoriteAlbums();
      emit(state.copyWith(favoriteAlbums: updatedAlbums));
    } catch (e) {
      emit(state.copyWith(
        error: 'Failed to add album to favorites: ${e.toString()}',
      ));
    }
  }

  Future<void> _onRemoveFavoriteAlbum(
    RemoveFavoriteAlbum event,
    Emitter<FavoritesState> emit,
  ) async {
    try {
      await _favoritesService.removeFavoriteAlbum(event.albumId);
      final updatedAlbums = await _favoritesService.getFavoriteAlbums();
      emit(state.copyWith(favoriteAlbums: updatedAlbums));
    } catch (e) {
      emit(state.copyWith(
        error: 'Failed to remove album from favorites: ${e.toString()}',
      ));
    }
  }
} 