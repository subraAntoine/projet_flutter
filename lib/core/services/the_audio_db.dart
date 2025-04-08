import 'package:projet_flutter/core/models/artist.dart';

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

  Future<List<Artist>> fetchArtistData(String id) async {
    try {
      final data = await _client.get('artist.php?i=$id');
      developer.log('Artist API Response: $data');
      final List<dynamic> artistData = data['artists'] ?? [];
      developer.log('Found ${artistData.length} artists in response');
      return artistData.map((artistData) => Artist.fromJson(artistData)).toList();
    } catch (e) {
      developer.log('Error fetching artist data: $e');
      rethrow;
    }
  }

  Future<List<Album>> fetchArtistAlbums(String id) async {
    try {
      final data = await _client.get('artist.php?i=$id&format=albums');
      developer.log('Artist albums API Response: $data');
      final List<dynamic> albumsData = data['albums'] ?? [];
      developer.log('Number of albums: ${albumsData.length}');
      return albumsData.map((albumData) => Album.fromJson(albumData)).toList();
    } catch (e) {
      developer.log('Error fetching artist albums: $e');
      rethrow;
    }
  }

  Future<List<Track>> fetchArtistTopTracks(String id) async {
    try {
      final data = await _client.get('artist.php?i=$id&format=tracks');
      developer.log('Artist top tracks API Response: $data');
      final List<dynamic> tracksData = data['tracks'] ?? [];
      developer.log('Number of tracks: ${tracksData.length}');
      return tracksData.map((trackData) => Track.fromJson(trackData)).toList();
    } catch (e) {
      developer.log('Error fetching artist top tracks: $e');
      rethrow;
    }
  }
}