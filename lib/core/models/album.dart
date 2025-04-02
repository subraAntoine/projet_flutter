class Album {
  final String id;
  final String chartPlace;
  final String artistId;
  final String albumId;
  final String artistMBID;
  final String albumMBID;
  final String artist;
  final String title;
  final String artistThumb;
  final String albumThumb;
  final String country;
  final String type;
  final String week;
  final String dateAdded;

  Album({
    required this.id,
    required this.chartPlace,
    required this.artistId,
    required this.albumId,
    required this.artistMBID,
    required this.albumMBID,
    required this.artist,
    required this.title,
    required this.artistThumb,
    required this.albumThumb,
    required this.country,
    required this.type,
    required this.week,
    required this.dateAdded,
  });

  factory Album.fromJson(Map<String, dynamic> json) {
    return Album(
      id: json['idTrend'] ?? '',
      chartPlace: json['intChartPlace'] ?? '',
      artistId: json['idArtist'] ?? '',
      albumId: json['idAlbum'] ?? '',
      artistMBID: json['strArtistMBID'] ?? '',
      albumMBID: json['strAlbumMBID'] ?? '',
      artist: json['strArtist'] ?? '',
      title: json['strAlbum'] ?? '',
      artistThumb: json['strArtistThumb'] ?? '',
      albumThumb: json['strAlbumThumb'] ?? '',
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
      'strArtistMBID': artistMBID,
      'strAlbumMBID': albumMBID,
      'strArtist': artist,
      'strAlbum': title,
      'strArtistThumb': artistThumb,
      'strAlbumThumb': albumThumb,
      'strCountry': country,
      'strType': type,
      'intWeek': week,
      'dateAdded': dateAdded,
    };
  }
} 