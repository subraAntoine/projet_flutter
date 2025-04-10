import 'package:equatable/equatable.dart';

abstract class AlbumEvent extends Equatable {
  const AlbumEvent();

  @override
  List<Object> get props => [];
}

class FetchAlbumEvent extends AlbumEvent {
  final String albumId;

  const FetchAlbumEvent({required this.albumId});

  @override
  List<Object> get props => [albumId];
}

class FetchAlbumTracksEvent extends AlbumEvent {
  final String albumId;

  const FetchAlbumTracksEvent({required this.albumId});

  @override
  List<Object> get props => [albumId];
}

class RefreshAlbumEvent extends AlbumEvent {
  final String albumId;

  const RefreshAlbumEvent({required this.albumId});

  @override
  List<Object> get props => [albumId];
} 