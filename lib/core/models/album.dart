import 'package:json_annotation/json_annotation.dart';

part 'album.g.dart';

@JsonSerializable()
class Album {
  @JsonKey(name: 'idAlbum')
  final String? idAlbum;
  
  @JsonKey(name: 'idArtist')
  final String? idArtist;
  
  @JsonKey(name: 'idLabel')
  final String? idLabel;
  
  @JsonKey(name: 'strAlbum')
  final String? strAlbum;
  
  @JsonKey(name: 'strAlbumStripped')
  final String? strAlbumStripped;
  
  @JsonKey(name: 'strArtist')
  final String? strArtist;
  
  @JsonKey(name: 'strArtistStripped')
  final String? strArtistStripped;
  
  @JsonKey(name: 'intYearReleased')
  final String? intYearReleased;
  
  @JsonKey(name: 'strStyle')
  final String? strStyle;
  
  @JsonKey(name: 'strGenre')
  final String? strGenre;
  
  @JsonKey(name: 'strLabel')
  final String? strLabel;
  
  @JsonKey(name: 'strReleaseFormat')
  final String? strReleaseFormat;
  
  @JsonKey(name: 'intSales')
  final String? intSales;
  
  @JsonKey(name: 'strAlbumThumb')
  final String? strAlbumThumb;
  
  @JsonKey(name: 'strAlbumThumbHQ')
  final String? strAlbumThumbHQ;
  
  @JsonKey(name: 'strAlbumBack')
  final String? strAlbumBack;
  
  @JsonKey(name: 'strAlbumCDart')
  final String? strAlbumCDart;
  
  @JsonKey(name: 'strAlbumSpine')
  final String? strAlbumSpine;
  
  @JsonKey(name: 'strAlbum3DCase')
  final String? strAlbum3DCase;
  
  @JsonKey(name: 'strAlbum3DFlat')
  final String? strAlbum3DFlat;
  
  @JsonKey(name: 'strAlbum3DFace')
  final String? strAlbum3DFace;
  
  @JsonKey(name: 'strAlbum3DThumb')
  final String? strAlbum3DThumb;
  
  @JsonKey(name: 'strDescriptionEN')
  final String? strDescriptionEN;
  
  @JsonKey(name: 'strMusicBrainzID')
  final String? strMusicBrainzID;
  
  @JsonKey(name: 'strMusicBrainzArtistID')
  final String? strMusicBrainzArtistID;
  
  @JsonKey(name: 'strLocked')
  final String? strLocked;

  Album({
    this.idAlbum,
    this.idArtist,
    this.idLabel,
    this.strAlbum,
    this.strAlbumStripped,
    this.strArtist,
    this.strArtistStripped,
    this.intYearReleased,
    this.strStyle,
    this.strGenre,
    this.strLabel,
    this.strReleaseFormat,
    this.intSales,
    this.strAlbumThumb,
    this.strAlbumThumbHQ,
    this.strAlbumBack,
    this.strAlbumCDart,
    this.strAlbumSpine,
    this.strAlbum3DCase,
    this.strAlbum3DFlat,
    this.strAlbum3DFace,
    this.strAlbum3DThumb,
    this.strDescriptionEN,
    this.strMusicBrainzID,
    this.strMusicBrainzArtistID,
    this.strLocked,
  });

  factory Album.fromJson(Map<String, dynamic> json) => _$AlbumFromJson(json);
  
  Map<String, dynamic> toJson() => _$AlbumToJson(this);
} 