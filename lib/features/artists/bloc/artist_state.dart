import 'package:equatable/equatable.dart';
import 'package:projet_flutter/core/models/album.dart';
import 'package:projet_flutter/core/models/artist.dart';
import 'package:projet_flutter/core/models/track.dart';

abstract class ArtistState extends Equatable {
  const ArtistState();
  
  @override
  List<Object> get props => [];
}

class ArtistInitial extends ArtistState {}

class ArtistLoading extends ArtistState {}

class ArtistLoadingAlbums extends ArtistState {}

class ArtistLoadingTracks extends ArtistState {}

class ArtistLoaded extends ArtistState {
  final Artist? artist;
  final List<Album> albums;
  final List<Track> topTracks;
  final bool isLoadingAlbums;
  final bool isLoadingTracks;

  const ArtistLoaded({
    this.artist,
    this.albums = const [],
    this.topTracks = const [],
    this.isLoadingAlbums = false,
    this.isLoadingTracks = false,
  });

  ArtistLoaded copyWith({
    Artist? artist,
    List<Album>? albums,
    List<Track>? topTracks,
    bool? isLoadingAlbums,
    bool? isLoadingTracks,
  }) {
    return ArtistLoaded(
      artist: artist ?? this.artist,
      albums: albums ?? this.albums,
      topTracks: topTracks ?? this.topTracks,
      isLoadingAlbums: isLoadingAlbums ?? this.isLoadingAlbums,
      isLoadingTracks: isLoadingTracks ?? this.isLoadingTracks,
    );
  }

  @override
  List<Object> get props => [
    artist ?? 'null', 
    albums, 
    topTracks, 
    isLoadingAlbums, 
    isLoadingTracks
  ];
}

class ArtistError extends ArtistState {
  final String message;

  const ArtistError({required this.message});

  @override
  List<Object> get props => [message];
} 