import 'package:json_annotation/json_annotation.dart';

part 'artist.g.dart';

@JsonSerializable()
class Artist {
  @JsonKey(name: 'idArtist')
  final String? id;
  
  @JsonKey(name: 'strArtist')
  final String? name;
  
  @JsonKey(name: 'strArtistAlternate')
  final String? alternativeName;
  
  @JsonKey(name: 'strLabel')
  final String? label;
  
  @JsonKey(name: 'idLabel')
  final String? labelId;
  
  @JsonKey(name: 'intFormedYear')
  final String? formedYear;
  
  @JsonKey(name: 'intBornYear')
  final String? bornYear;
  
  @JsonKey(name: 'intDiedYear')
  final String? diedYear;
  
  @JsonKey(name: 'strDisbanded')
  final String? disbanded;
  
  @JsonKey(name: 'strStyle')
  final String? style;
  
  @JsonKey(name: 'strGenre')
  final String? genre;
  
  @JsonKey(name: 'strMood')
  final String? mood;
  
  @JsonKey(name: 'strWebsite')
  final String? website;
  
  @JsonKey(name: 'strFacebook')
  final String? facebook;
  
  @JsonKey(name: 'strTwitter')
  final String? twitter;
  
  @JsonKey(name: 'strBiographyEN')
  final String? biography;
  
  @JsonKey(name: 'strGender')
  final String? gender;
  
  @JsonKey(name: 'intMembers')
  final String? members;
  
  @JsonKey(name: 'strCountry')
  final String? country;
  
  @JsonKey(name: 'strCountryCode')
  final String? countryCode;
  
  @JsonKey(name: 'strArtistThumb')
  final String? thumb;
  
  @JsonKey(name: 'strArtistLogo')
  final String? logo;
  
  @JsonKey(name: 'strArtistCutout')
  final String? cutout;
  
  @JsonKey(name: 'strArtistClearart')
  final String? clearart;
  
  @JsonKey(name: 'strArtistWideThumb')
  final String? wideThumb;
  
  @JsonKey(name: 'strArtistFanart')
  final String? fanart;
  
  @JsonKey(name: 'strArtistFanart2')
  final String? fanart2;
  
  @JsonKey(name: 'strArtistFanart3')
  final String? fanart3;
  
  @JsonKey(name: 'strArtistFanart4')
  final String? fanart4;
  
  @JsonKey(name: 'strArtistBanner')
  final String? banner;
  
  @JsonKey(name: 'strMusicBrainzID')
  final String? musicBrainzId;
  
  @JsonKey(name: 'strISNIcode')
  final String? isniCode;
  
  @JsonKey(name: 'strLastFMChart')
  final String? lastFmChart;
  
  @JsonKey(name: 'strLocked')
  final String? locked;

  Artist({
    this.id,
    this.name,
    this.alternativeName,
    this.label,
    this.labelId,
    this.formedYear,
    this.bornYear,
    this.diedYear,
    this.disbanded,
    this.style,
    this.genre,
    this.mood,
    this.website,
    this.facebook,
    this.twitter,
    this.biography,
    this.gender,
    this.members,
    this.country,
    this.countryCode,
    this.thumb,
    this.logo,
    this.cutout,
    this.clearart,
    this.wideThumb,
    this.fanart,
    this.fanart2,
    this.fanart3,
    this.fanart4,
    this.banner,
    this.musicBrainzId,
    this.isniCode,
    this.lastFmChart,
    this.locked,
  });

  factory Artist.fromJson(Map<String, dynamic> json) => _$ArtistFromJson(json);
  
  Map<String, dynamic> toJson() => _$ArtistToJson(this);
} 