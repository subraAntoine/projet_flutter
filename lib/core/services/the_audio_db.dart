import 'package:projet_flutter/core/models/artist.dart';
import 'package:projet_flutter/core/models/album.dart';
import 'package:projet_flutter/core/models/track.dart';
import 'dart:developer' as developer;
import 'the_audio_db_client.dart';

class AudioDbApi {
  final TheAudioDbClient _client;
  
  AudioDbApi({TheAudioDbClient? client}) : _client = client ?? TheAudioDbClient.create();

  Future<List<Album>> fetchTrendingAlbums({String country = 'us'}) async {
    try {
      final response = await _client.getTrendingAlbums(country: country);
      developer.log('Number of albums: ${response.trending.length}');
      return response.trending;
    } catch (e) {
      developer.log('Error fetching albums: $e');
      rethrow;
    }
  }

  Future<List<Track>> fetchTrendingSingles({String country = 'us'}) async {
    try {
      final response = await _client.getTrendingSingles(country: country);
      developer.log('Number of singles: ${response.trending.length}');
      return response.trending;
    } catch (e) {
      developer.log('Error fetching singles: $e');
      rethrow;
    }
  }

  Future<List<Artist>> fetchArtistData(String id) async {
    try {
      final response = await _client.getArtistData(id);
      developer.log('Found ${response.artists.length} artists in response');
      return response.artists;
    } catch (e) {
      developer.log('Error fetching artist data: $e');
      rethrow;
    }
  }

  Future<List<Album>> fetchArtistAlbums(String id) async {
    try {
      final response = await _client.getArtistAlbums(id);
      developer.log('Number of albums: ${response.album.length}');
      return response.album;
    } catch (e) {
      developer.log('Error fetching artist albums: $e');
      return [];
    }
  }

  Future<Album?> fetchAlbumById(String id) async {
    try {
      final response = await _client.getAlbumById(id);
      developer.log('Album details fetched with ID: $id');
      if (response.album.isNotEmpty) {
        return response.album.first;
      } else {
        developer.log('No album found with ID: $id');
        return null;
      }
    } catch (e) {
      developer.log('Error fetching album details: $e');
      return null;
    }
  }

  Future<List<Track>> fetchArtistTopTracks(String id) async {
    try {
      
      final artistData = await fetchArtistData(id);
      if (artistData.isEmpty) {
        developer.log('Artist data is empty, cannot fetch top tracks');
        return [];
      }
      
      final artistName = artistData.first.name;
      if (artistName == null || artistName.isEmpty) {
        developer.log('Artist name is null or empty, cannot fetch top tracks');
        return [];
      }
      
      developer.log('Fetching tracks using artist name: $artistName');
      
      
      try {
        final response = await _client.getArtistTopTracks(artistName);
        if (response.track == null) {
          developer.log('Response track list is null');
          return [];
        }
        developer.log('Response received, track count: ${response.track!.length}');
        return response.track!;
      } catch (e) {
        developer.log('Error from API call to getArtistTopTracks: $e');
        return [];
      }
    } catch (e) {
      developer.log('Error fetching artist top tracks: $e');
      return [];
    }
  }
}