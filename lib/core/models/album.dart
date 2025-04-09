class Album {
  final String idAlbum;
  final String idArtist;
  final String? idLabel;
  final String strAlbum;
  final String strAlbumStripped;
  final String strArtist;
  final String strArtistStripped;
  final String intYearReleased;
  final String? strStyle;
  final String? strGenre;
  final String? strLabel;
  final String strReleaseFormat;
  final String intSales;
  final String strAlbumThumb;
  final String? strAlbumThumbHQ;
  final String? strAlbumBack;
  final String? strAlbumCDart;
  final String? strAlbumSpine;
  final String? strAlbum3DCase;
  final String? strAlbum3DFlat;
  final String? strAlbum3DFace;
  final String? strAlbum3DThumb;
  final String? strDescription;
  final String strMusicBrainzID;
  final String strMusicBrainzArtistID;
  final String strLocked;

  Album({
    required this.idAlbum,
    required this.idArtist,
    this.idLabel,
    required this.strAlbum,
    required this.strAlbumStripped,
    required this.strArtist,
    required this.strArtistStripped,
    required this.intYearReleased,
    this.strStyle,
    this.strGenre,
    this.strLabel,
    required this.strReleaseFormat,
    required this.intSales,
    required this.strAlbumThumb,
    this.strAlbumThumbHQ,
    this.strAlbumBack,
    this.strAlbumCDart,
    this.strAlbumSpine,
    this.strAlbum3DCase,
    this.strAlbum3DFlat,
    this.strAlbum3DFace,
    this.strAlbum3DThumb,
    this.strDescription,
    required this.strMusicBrainzID,
    required this.strMusicBrainzArtistID,
    required this.strLocked,
  });

  factory Album.fromJson(Map<String, dynamic> json) {
    return Album(
      idAlbum: json['idAlbum'] ?? '',
      idArtist: json['idArtist'] ?? '',
      idLabel: json['idLabel'],
      strAlbum: json['strAlbum'] ?? '',
      strAlbumStripped: json['strAlbumStripped'] ?? '',
      strArtist: json['strArtist'] ?? '',
      strArtistStripped: json['strArtistStripped'] ?? '',
      intYearReleased: json['intYearReleased'] ?? '',
      strStyle: json['strStyle'],
      strGenre: json['strGenre'],
      strLabel: json['strLabel'],
      strReleaseFormat: json['strReleaseFormat'] ?? '',
      intSales: json['intSales'] ?? '',
      strAlbumThumb: json['strAlbumThumb'] ?? '',
      strAlbumThumbHQ: json['strAlbumThumbHQ'],
      strAlbumBack: json['strAlbumBack'],
      strAlbumCDart: json['strAlbumCDart'],
      strAlbumSpine: json['strAlbumSpine'],
      strAlbum3DCase: json['strAlbum3DCase'],
      strAlbum3DFlat: json['strAlbum3DFlat'],
      strAlbum3DFace: json['strAlbum3DFace'],
      strAlbum3DThumb: json['strAlbum3DThumb'],
      strDescription: json['strDescription'],
      strMusicBrainzID: json['strMusicBrainzID'] ?? '',
      strMusicBrainzArtistID: json['strMusicBrainzArtistID'] ?? '',
      strLocked: json['strLocked'] ?? '',
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'idAlbum': idAlbum,
      'idArtist': idArtist,
      'idLabel': idLabel,
      'strAlbum': strAlbum,
      'strAlbumStripped': strAlbumStripped,
      'strArtist': strArtist,
      'strArtistStripped': strArtistStripped,
      'intYearReleased': intYearReleased,
      'strStyle': strStyle,
      'strGenre': strGenre,
      'strLabel': strLabel,
      'strReleaseFormat': strReleaseFormat,
      'intSales': intSales,
      'strAlbumThumb': strAlbumThumb,
      'strAlbumThumbHQ': strAlbumThumbHQ,
      'strAlbumBack': strAlbumBack,
      'strAlbumCDart': strAlbumCDart,
      'strAlbumSpine': strAlbumSpine,
      'strAlbum3DCase': strAlbum3DCase,
      'strAlbum3DFlat': strAlbum3DFlat,
      'strAlbum3DFace': strAlbum3DFace,
      'strAlbum3DThumb': strAlbum3DThumb,
      'strDescription': strDescription,
      'strMusicBrainzID': strMusicBrainzID,
      'strMusicBrainzArtistID': strMusicBrainzArtistID,
      'strLocked': strLocked,
    };
  }
} 