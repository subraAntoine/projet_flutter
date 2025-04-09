// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'track.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Track _$TrackFromJson(Map<String, dynamic> json) => Track(
      id: json['idTrend'] as String?,
      chartPlace: json['intChartPlace'] as String?,
      artistId: json['idArtist'] as String?,
      albumId: json['idAlbum'] as String?,
      trackId: json['idTrack'] as String?,
      artistMBID: json['strArtistMBID'] as String?,
      albumMBID: json['strAlbumMBID'] as String?,
      trackMBID: json['strTrackMBID'] as String?,
      artist: json['strArtist'] as String?,
      album: json['strAlbum'] as String?,
      title: json['strTrack'] as String?,
      artistThumb: json['strArtistThumb'] as String?,
      albumThumb: json['strAlbumThumb'] as String?,
      trackThumb: json['strTrackThumb'] as String?,
      country: json['strCountry'] as String?,
      type: json['strType'] as String?,
      week: json['intWeek'] as String?,
      dateAdded: json['dateAdded'] as String?,
    );

Map<String, dynamic> _$TrackToJson(Track instance) => <String, dynamic>{
      'idTrend': instance.id,
      'intChartPlace': instance.chartPlace,
      'idArtist': instance.artistId,
      'idAlbum': instance.albumId,
      'idTrack': instance.trackId,
      'strArtistMBID': instance.artistMBID,
      'strAlbumMBID': instance.albumMBID,
      'strTrackMBID': instance.trackMBID,
      'strArtist': instance.artist,
      'strAlbum': instance.album,
      'strTrack': instance.title,
      'strArtistThumb': instance.artistThumb,
      'strAlbumThumb': instance.albumThumb,
      'strTrackThumb': instance.trackThumb,
      'strCountry': instance.country,
      'strType': instance.type,
      'intWeek': instance.week,
      'dateAdded': instance.dateAdded,
    };
