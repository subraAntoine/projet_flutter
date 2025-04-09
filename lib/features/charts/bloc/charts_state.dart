import 'package:equatable/equatable.dart';
import 'package:projet_flutter/core/models/album.dart';
import 'package:projet_flutter/core/models/track.dart';

abstract class ChartsState extends Equatable {
  const ChartsState();
  
  @override
  List<Object> get props => [];
}

class ChartsInitial extends ChartsState {}

class ChartsLoading extends ChartsState {}

class ChartsLoaded extends ChartsState {
  final List<Track> tracks;
  final List<Album> albums;

  const ChartsLoaded({
    required this.tracks,
    required this.albums,
  });

  @override
  List<Object> get props => [tracks, albums];
}

class ChartsError extends ChartsState {
  final String message;

  const ChartsError({required this.message});

  @override
  List<Object> get props => [message];
} 