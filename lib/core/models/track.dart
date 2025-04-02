class Track {
  final String id;
  final String chartPlace;
  final String artistId;
  final String albumId;
  final String trackId;
  final String artistMBID;
  final String albumMBID;
  final String trackMBID;
  final String artist;
  final String album;
  final String title;
  final String? artistThumb;
  final String? albumThumb;
  final String? trackThumb;
  final String country;
  final String type;
  final String week;
  final String dateAdded;

  Track({
    required this.id,
    required this.chartPlace,
    required this.artistId,
    required this.albumId,
    required this.trackId,
    required this.artistMBID,
    required this.albumMBID,
    required this.trackMBID,
    required this.artist,
    required this.album,
    required this.title,
    this.artistThumb,
    this.albumThumb,
    this.trackThumb,
    required this.country,
    required this.type,
    required this.week,
    required this.dateAdded,
  });

  factory Track.fromJson(Map<String, dynamic> json) {
    return Track(
      id: json['idTrend'] ?? '',
      chartPlace: json['intChartPlace'] ?? '',
      artistId: json['idArtist'] ?? '',
      albumId: json['idAlbum'] ?? '',
      trackId: json['idTrack'] ?? '',
      artistMBID: json['strArtistMBID'] ?? '',
      albumMBID: json['strAlbumMBID'] ?? '',
      trackMBID: json['strTrackMBID'] ?? '',
      artist: json['strArtist'] ?? '',
      album: json['strAlbum'] ?? '',
      title: json['strTrack'] ?? '',
      artistThumb: json['strArtistThumb'],
      albumThumb: json['strAlbumThumb'],
      trackThumb: json['strTrackThumb'],
      country: json['strCountry'] ?? '',
      type: json['strType'] ?? '',
      week: json['intWeek'] ?? '',
      dateAdded: json['dateAdded'] ?? '',
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'idTrend': id,
      'intChartPlace': chartPlace,
      'idArtist': artistId,
      'idAlbum': albumId,
      'idTrack': trackId,
      'strArtistMBID': artistMBID,
      'strAlbumMBID': albumMBID,
      'strTrackMBID': trackMBID,
      'strArtist': artist,
      'strAlbum': album,
      'strTrack': title,
      'strArtistThumb': artistThumb,
      'strAlbumThumb': albumThumb,
      'strTrackThumb': trackThumb,
      'strCountry': country,
      'strType': type,
      'intWeek': week,
      'dateAdded': dateAdded,
    };
  }
} 