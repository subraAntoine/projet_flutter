class Artist {
  final String id;
  final String name;
  final String? alternativeName;
  final String? label;
  final String? labelId;
  final String? formedYear;
  final String? bornYear;
  final String? diedYear;
  final String? disbanded;
  final String? style;
  final String? genre;
  final String? mood;
  final String? website;
  final String? facebook;
  final String? twitter;
  final String? biography;
  final String? gender;
  final String? members;
  final String? country;
  final String? countryCode;
  final String? thumb;
  final String? logo;
  final String? cutout;
  final String? clearart;
  final String? wideThumb;
  final String? fanart;
  final String? fanart2;
  final String? fanart3;
  final String? fanart4;
  final String? banner;
  final String? musicBrainzId;
  final String? isniCode;
  final String? lastFmChart;
  final String? locked;

  Artist({
    required this.id,
    required this.name,
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

  factory Artist.fromJson(Map<String, dynamic> json) {
    return Artist(
      id: json['idArtist'] ?? '',
      name: json['strArtist'] ?? '',
      alternativeName: json['strArtistAlternate'],
      label: json['strLabel'],
      labelId: json['idLabel'],
      formedYear: json['intFormedYear'],
      bornYear: json['intBornYear'],
      diedYear: json['intDiedYear'],
      disbanded: json['strDisbanded'],
      style: json['strStyle'],
      genre: json['strGenre'],
      mood: json['strMood'],
      website: json['strWebsite'],
      facebook: json['strFacebook'],
      twitter: json['strTwitter'],
      biography: json['strBiographyEN'],
      gender: json['strGender'],
      members: json['intMembers'],
      country: json['strCountry'],
      countryCode: json['strCountryCode'],
      thumb: json['strArtistThumb'],
      logo: json['strArtistLogo'],
      cutout: json['strArtistCutout'],
      clearart: json['strArtistClearart'],
      wideThumb: json['strArtistWideThumb'],
      fanart: json['strArtistFanart'],
      fanart2: json['strArtistFanart2'],
      fanart3: json['strArtistFanart3'],
      fanart4: json['strArtistFanart4'],
      banner: json['strArtistBanner'],
      musicBrainzId: json['strMusicBrainzID'],
      isniCode: json['strISNIcode'],
      lastFmChart: json['strLastFMChart'],
      locked: json['strLocked'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'idArtist': id,
      'strArtist': name,
      'strArtistAlternate': alternativeName,
      'strLabel': label,
      'idLabel': labelId,
      'intFormedYear': formedYear,
      'intBornYear': bornYear,
      'intDiedYear': diedYear,
      'strDisbanded': disbanded,
      'strStyle': style,
      'strGenre': genre,
      'strMood': mood,
      'strWebsite': website,
      'strFacebook': facebook,
      'strTwitter': twitter,
      'strBiographyEN': biography,
      'strGender': gender,
      'intMembers': members,
      'strCountry': country,
      'strCountryCode': countryCode,
      'strArtistThumb': thumb,
      'strArtistLogo': logo,
      'strArtistCutout': cutout,
      'strArtistClearart': clearart,
      'strArtistWideThumb': wideThumb,
      'strArtistFanart': fanart,
      'strArtistFanart2': fanart2,
      'strArtistFanart3': fanart3,
      'strArtistFanart4': fanart4,
      'strArtistBanner': banner,
      'strMusicBrainzID': musicBrainzId,
      'strISNIcode': isniCode,
      'strLastFMChart': lastFmChart,
      'strLocked': locked,
    };
  }
} 