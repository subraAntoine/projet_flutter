import 'package:equatable/equatable.dart';
import 'package:projet_flutter/core/models/album.dart';
import 'package:projet_flutter/core/models/artist.dart';

enum SearchStatus { initial, loading, success, failure }

class SearchState extends Equatable {
  final String searchTerm;
  final List<Artist> artists;
  final List<Album> albums;
  final SearchStatus status;
  final String? errorMessage;

  const SearchState({
    this.searchTerm = '',
    this.artists = const [],
    this.albums = const [],
    this.status = SearchStatus.initial,
    this.errorMessage,
  });

  SearchState copyWith({
    String? searchTerm,
    List<Artist>? artists,
    List<Album>? albums,
    SearchStatus? status,
    String? errorMessage,
  }) {
    return SearchState(
      searchTerm: searchTerm ?? this.searchTerm,
      artists: artists ?? this.artists,
      albums: albums ?? this.albums,
      status: status ?? this.status,
      errorMessage: errorMessage ?? this.errorMessage,
    );
  }

  @override
  List<Object?> get props => [searchTerm, artists, albums, status, errorMessage];
} 