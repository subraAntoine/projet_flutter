import 'api_client.dart';
import '../models/album.dart';
import '../models/track.dart';
import 'dart:developer' as developer;

class AudioDbApi {
  final ApiClient _client = ApiClient();

  Future<List<Album>> fetchTrendingAlbums({String country = 'us'}) async {
    try {
      final data = await _client.get('trending.php?country=$country&type=itunes&format=albums');
      developer.log('Albums API Response: $data');
      final List<dynamic> trendingData = data['trending'] ?? [];
      developer.log('Number of albums: ${trendingData.length}');
      return trendingData.map((albumData) => Album.fromJson(albumData)).toList();
    } catch (e) {
      developer.log('Error fetching albums: $e');
      rethrow;
    }
  }

  Future<List<Track>> fetchTrendingSingles({String country = 'us'}) async {
    try {
      final data = await _client.get('trending.php?country=$country&type=itunes&format=singles');
      developer.log('Singles API Response: $data');
      final List<dynamic> trendingData = data['trending'] ?? [];
      developer.log('Number of singles: ${trendingData.length}');
      return trendingData.map((trackData) => Track.fromJson(trackData)).toList();
    } catch (e) {
      developer.log('Error fetching singles: $e');
      rethrow;
    }
  }
}