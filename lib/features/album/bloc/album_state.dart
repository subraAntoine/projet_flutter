import 'package:equatable/equatable.dart';
import 'package:projet_flutter/core/models/album.dart';
import 'package:projet_flutter/core/models/track.dart';

abstract class AlbumState extends Equatable {
  const AlbumState();

  @override
  List<Object?> get props => [];
}

class AlbumInitial extends AlbumState {}

class AlbumLoading extends AlbumState {}

class AlbumLoaded extends AlbumState {
  final Album album;
  final List<Track> tracks;
  final bool isLoadingTracks;
  final double rating;
  final int voteCount;

  const AlbumLoaded({
    required this.album,
    this.tracks = const [],
    this.isLoadingTracks = false,
    this.rating = 0.0,
    this.voteCount = 0,
  });

  AlbumLoaded copyWith({
    Album? album,
    List<Track>? tracks,
    bool? isLoadingTracks,
    double? rating,
    int? voteCount,
  }) {
    return AlbumLoaded(
      album: album ?? this.album,
      tracks: tracks ?? this.tracks,
      isLoadingTracks: isLoadingTracks ?? this.isLoadingTracks,
      rating: rating ?? this.rating,
      voteCount: voteCount ?? this.voteCount,
    );
  }

  @override
  List<Object?> get props => [album, tracks, isLoadingTracks, rating, voteCount];
}

class AlbumError extends AlbumState {
  final String message;

  const AlbumError({required this.message});

  @override
  List<Object> get props => [message];
} 