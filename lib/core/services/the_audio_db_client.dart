import 'package:dio/dio.dart';
import 'package:retrofit/retrofit.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:json_annotation/json_annotation.dart';
import '../models/album.dart';
import '../models/artist.dart';
import '../models/track.dart';

part 'the_audio_db_client.g.dart';

@RestApi(baseUrl: "https://theaudiodb.com/api/v1/json/")
abstract class TheAudioDbClient {
  factory TheAudioDbClient(Dio dio, {String baseUrl}) = _TheAudioDbClient;

  static TheAudioDbClient create() {
    final dio = Dio();
    final apiKey = dotenv.env['THE_AUDIO_DB_API_KEY'] ?? '523532';
    return TheAudioDbClient(dio, baseUrl: "https://theaudiodb.com/api/v1/json/$apiKey/");
  }

  @GET("trending.php")
  Future<TrendingAlbumsResponse> getTrendingAlbums({
    @Query("country") String country = 'us',
    @Query("type") String type = 'itunes',
    @Query("format") String format = 'albums'
  });

  @GET("trending.php")
  Future<TrendingSinglesResponse> getTrendingSingles({
    @Query("country") String country = 'us',
    @Query("type") String type = 'itunes',
    @Query("format") String format = 'singles'
  });

  @GET("artist.php")
  Future<ArtistResponse> getArtistData(@Query("i") String id);

  @GET("album.php")
  Future<AlbumResponse> getArtistAlbums(@Query("i") String id);

  @GET("album.php")
  Future<AlbumResponse> getAlbumById(@Query("m") String id);

  @GET("track-top10.php")
  Future<TrackResponse> getArtistTopTracks(@Query("s") String artistName);

  @GET("track.php")
  Future<TrackResponse> getAlbumTracks(@Query("m") String albumId);

  @GET("search.php")
  Future<ArtistResponse> searchArtist(@Query("s") String artistName);

  @GET("searchalbum.php")
  Future<AlbumResponse> searchAlbum(@Query("s") String artistName);

}



@JsonSerializable()
class TrendingAlbumsResponse {
  @JsonKey(name: 'trending', defaultValue: [])
  final List<Album> trending;

  TrendingAlbumsResponse({required this.trending});

  factory TrendingAlbumsResponse.fromJson(Map<String, dynamic> json) => 
      _$TrendingAlbumsResponseFromJson(json);
  
  Map<String, dynamic> toJson() => _$TrendingAlbumsResponseToJson(this);
}

@JsonSerializable()
class TrendingSinglesResponse {
  @JsonKey(name: 'trending', defaultValue: [])
  final List<Track> trending;

  TrendingSinglesResponse({required this.trending});

  factory TrendingSinglesResponse.fromJson(Map<String, dynamic> json) => 
      _$TrendingSinglesResponseFromJson(json);
  
  Map<String, dynamic> toJson() => _$TrendingSinglesResponseToJson(this);
}

@JsonSerializable()
class ArtistResponse {
  @JsonKey(name: 'artists', defaultValue: [])
  final List<Artist> artists;

  ArtistResponse({required this.artists});

  factory ArtistResponse.fromJson(Map<String, dynamic> json) => 
      _$ArtistResponseFromJson(json);
  
  Map<String, dynamic> toJson() => _$ArtistResponseToJson(this);
}

@JsonSerializable()
class AlbumResponse {
  @JsonKey(name: 'album', defaultValue: [])
  final List<Album> album;

  AlbumResponse({required this.album});

  factory AlbumResponse.fromJson(Map<String, dynamic> json) => 
      _$AlbumResponseFromJson(json);
  
  Map<String, dynamic> toJson() => _$AlbumResponseToJson(this);
}

@JsonSerializable()
class TrackResponse {
  @JsonKey(name: 'track', defaultValue: null)
  final List<Track>? track;

  TrackResponse({this.track});

  factory TrackResponse.fromJson(Map<String, dynamic> json) => 
      _$TrackResponseFromJson(json);
  
  Map<String, dynamic> toJson() => _$TrackResponseToJson(this);
} 