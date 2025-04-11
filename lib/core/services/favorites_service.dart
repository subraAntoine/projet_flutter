import 'dart:convert';
import 'package:shared_preferences/shared_preferences.dart';
import '../models/artist.dart';
import '../models/album.dart';

class FavoritesService {
  static const String _favArtistsKey = 'favorite_artists';
  static const String _favAlbumsKey = 'favorite_albums';
  
  // Stockage en mémoire comme solution de secours
  static final List<Artist> _cachedArtists = [];
  static final List<Album> _cachedAlbums = [];
  
  // Indique si on utilise le stockage en mémoire (pour le debug)
  static bool _useInMemoryStorage = false;
  
  // Singleton pattern
  static final FavoritesService _instance = FavoritesService._internal();
  
  factory FavoritesService() {
    return _instance;
  }
  
  FavoritesService._internal();
  
  // Get favorite artists
  Future<List<Artist>> getFavoriteArtists() async {
    if (_useInMemoryStorage) {
      return _cachedArtists;
    }
    
    try {
      final prefs = await SharedPreferences.getInstance();
      final jsonList = prefs.getStringList(_favArtistsKey) ?? [];
      
      return jsonList.map((jsonString) {
        final Map<String, dynamic> json = jsonDecode(jsonString);
        return Artist.fromJson(json);
      }).toList();
    } catch (e) {
      print("Erreur SharedPreferences, utilisation du stockage en mémoire: $e");
      _useInMemoryStorage = true;
      return _cachedArtists;
    }
  }
  
  // Add artist to favorites
  Future<bool> addFavoriteArtist(Artist artist) async {
    if (_useInMemoryStorage) {
      // Vérifier si l'artiste existe déjà
      final exists = _cachedArtists.any((a) => a.id == artist.id);
      if (!exists) {
        _cachedArtists.add(artist);
      }
      return !exists;
    }
    
    try {
      final prefs = await SharedPreferences.getInstance();
      final currentList = prefs.getStringList(_favArtistsKey) ?? [];
      
      // Check if artist already exists in favorites
      final artistIds = currentList.map((jsonString) {
        final Map<String, dynamic> json = jsonDecode(jsonString);
        return json['idArtist'];
      }).toList();
      
      if (artistIds.contains(artist.id)) {
        return false; // Artist already in favorites
      }
      
      // Add new artist
      currentList.add(jsonEncode(artist.toJson()));
      return await prefs.setStringList(_favArtistsKey, currentList);
    } catch (e) {
      print("Erreur SharedPreferences, utilisation du stockage en mémoire: $e");
      _useInMemoryStorage = true;
      return addFavoriteArtist(artist);
    }
  }
  
  // Remove artist from favorites
  Future<bool> removeFavoriteArtist(String artistId) async {
    if (_useInMemoryStorage) {
      final initialLength = _cachedArtists.length;
      _cachedArtists.removeWhere((a) => a.id == artistId);
      return initialLength != _cachedArtists.length;
    }
    
    try {
      final prefs = await SharedPreferences.getInstance();
      final currentList = prefs.getStringList(_favArtistsKey) ?? [];
      
      final newList = currentList.where((jsonString) {
        final Map<String, dynamic> json = jsonDecode(jsonString);
        return json['idArtist'] != artistId;
      }).toList();
      
      return await prefs.setStringList(_favArtistsKey, newList);
    } catch (e) {
      print("Erreur SharedPreferences, utilisation du stockage en mémoire: $e");
      _useInMemoryStorage = true;
      return removeFavoriteArtist(artistId);
    }
  }
  
  // Check if artist is favorite
  Future<bool> isArtistFavorite(String artistId) async {
    if (_useInMemoryStorage) {
      return _cachedArtists.any((a) => a.id == artistId);
    }
    
    try {
      final prefs = await SharedPreferences.getInstance();
      final currentList = prefs.getStringList(_favArtistsKey) ?? [];
      
      for (var jsonString in currentList) {
        final Map<String, dynamic> json = jsonDecode(jsonString);
        if (json['idArtist'] == artistId) {
          return true;
        }
      }
      
      return false;
    } catch (e) {
      print("Erreur SharedPreferences, utilisation du stockage en mémoire: $e");
      _useInMemoryStorage = true;
      return isArtistFavorite(artistId);
    }
  }
  
  // Get favorite albums
  Future<List<Album>> getFavoriteAlbums() async {
    if (_useInMemoryStorage) {
      return _cachedAlbums;
    }
    
    try {
      final prefs = await SharedPreferences.getInstance();
      final jsonList = prefs.getStringList(_favAlbumsKey) ?? [];
      
      return jsonList.map((jsonString) {
        final Map<String, dynamic> json = jsonDecode(jsonString);
        return Album.fromJson(json);
      }).toList();
    } catch (e) {
      print("Erreur SharedPreferences, utilisation du stockage en mémoire: $e");
      _useInMemoryStorage = true;
      return _cachedAlbums;
    }
  }
  
  // Add album to favorites
  Future<bool> addFavoriteAlbum(Album album) async {
    if (_useInMemoryStorage) {
      // Vérifier si l'album existe déjà
      final exists = _cachedAlbums.any((a) => a.idAlbum == album.idAlbum);
      if (!exists) {
        _cachedAlbums.add(album);
      }
      return !exists;
    }
    
    try {
      final prefs = await SharedPreferences.getInstance();
      final currentList = prefs.getStringList(_favAlbumsKey) ?? [];
      
      // Check if album already exists in favorites
      final albumIds = currentList.map((jsonString) {
        final Map<String, dynamic> json = jsonDecode(jsonString);
        return json['idAlbum'];
      }).toList();
      
      if (albumIds.contains(album.idAlbum)) {
        return false; // Album already in favorites
      }
      
      // Add new album
      currentList.add(jsonEncode(album.toJson()));
      return await prefs.setStringList(_favAlbumsKey, currentList);
    } catch (e) {
      print("Erreur SharedPreferences, utilisation du stockage en mémoire: $e");
      _useInMemoryStorage = true;
      return addFavoriteAlbum(album);
    }
  }
  
  // Remove album from favorites
  Future<bool> removeFavoriteAlbum(String albumId) async {
    if (_useInMemoryStorage) {
      final initialLength = _cachedAlbums.length;
      _cachedAlbums.removeWhere((a) => a.idAlbum == albumId);
      return initialLength != _cachedAlbums.length;
    }
    
    try {
      final prefs = await SharedPreferences.getInstance();
      final currentList = prefs.getStringList(_favAlbumsKey) ?? [];
      
      final newList = currentList.where((jsonString) {
        final Map<String, dynamic> json = jsonDecode(jsonString);
        return json['idAlbum'] != albumId;
      }).toList();
      
      return await prefs.setStringList(_favAlbumsKey, newList);
    } catch (e) {
      print("Erreur SharedPreferences, utilisation du stockage en mémoire: $e");
      _useInMemoryStorage = true;
      return removeFavoriteAlbum(albumId);
    }
  }
  
  // Check if album is favorite
  Future<bool> isAlbumFavorite(String albumId) async {
    if (_useInMemoryStorage) {
      return _cachedAlbums.any((a) => a.idAlbum == albumId);
    }
    
    try {
      final prefs = await SharedPreferences.getInstance();
      final currentList = prefs.getStringList(_favAlbumsKey) ?? [];
      
      for (var jsonString in currentList) {
        final Map<String, dynamic> json = jsonDecode(jsonString);
        if (json['idAlbum'] == albumId) {
          return true;
        }
      }
      
      return false;
    } catch (e) {
      print("Erreur SharedPreferences, utilisation du stockage en mémoire: $e");
      _useInMemoryStorage = true;
      return isAlbumFavorite(albumId);
    }
  }
} 