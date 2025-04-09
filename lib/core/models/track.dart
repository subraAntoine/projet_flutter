import 'package:json_annotation/json_annotation.dart';

part 'track.g.dart';

@JsonSerializable()
class Track {
  @JsonKey(name: 'idTrend')
  final String? id;
  
  @JsonKey(name: 'intChartPlace')
  final String? chartPlace;
  
  @JsonKey(name: 'idArtist')
  final String? artistId;
  
  @JsonKey(name: 'idAlbum')
  final String? albumId;
  
  @JsonKey(name: 'idTrack')
  final String? trackId;
  
  @JsonKey(name: 'strArtistMBID')
  final String? artistMBID;
  
  @JsonKey(name: 'strAlbumMBID')
  final String? albumMBID;
  
  @JsonKey(name: 'strTrackMBID')
  final String? trackMBID;
  
  @JsonKey(name: 'strArtist')
  final String? artist;
  
  @JsonKey(name: 'strAlbum')
  final String? album;
  
  @JsonKey(name: 'strTrack')
  final String? title;
  
  @JsonKey(name: 'strArtistThumb')
  final String? artistThumb;
  
  @JsonKey(name: 'strAlbumThumb')
  final String? albumThumb;
  
  @JsonKey(name: 'strTrackThumb')
  final String? trackThumb;
  
  @JsonKey(name: 'strCountry')
  final String? country;
  
  @JsonKey(name: 'strType')
  final String? type;
  
  @JsonKey(name: 'intWeek')
  final String? week;
  
  @JsonKey(name: 'dateAdded')
  final String? dateAdded;

  Track({
    this.id,
    this.chartPlace,
    this.artistId,
    this.albumId,
    this.trackId,
    this.artistMBID,
    this.albumMBID,
    this.trackMBID,
    this.artist,
    this.album,
    this.title,
    this.artistThumb,
    this.albumThumb,
    this.trackThumb,
    this.country,
    this.type,
    this.week,
    this.dateAdded,
  });

  factory Track.fromJson(Map<String, dynamic> json) => _$TrackFromJson(json);
  
  Map<String, dynamic> toJson() => _$TrackToJson(this);
} 