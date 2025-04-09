import 'package:equatable/equatable.dart';

abstract class ArtistEvent extends Equatable {
  const ArtistEvent();

  @override
  List<Object> get props => [];
}

class FetchArtistEvent extends ArtistEvent {
  final String artistId;

  const FetchArtistEvent({required this.artistId});

  @override
  List<Object> get props => [artistId];
}

class FetchArtistAlbumsEvent extends ArtistEvent {
  final String artistId;

  const FetchArtistAlbumsEvent({required this.artistId});

  @override
  List<Object> get props => [artistId];
}

class FetchArtistTopTracksEvent extends ArtistEvent {
  final String artistId;

  const FetchArtistTopTracksEvent({required this.artistId});

  @override
  List<Object> get props => [artistId];
}

class RefreshArtistDataEvent extends ArtistEvent {
  final String artistId;

  const RefreshArtistDataEvent({required this.artistId});

  @override
  List<Object> get props => [artistId];
} 