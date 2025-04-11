import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../core/models/artist.dart';
import '../../../core/models/album.dart';
import '../bloc/favorites_bloc.dart';
import '../../../core/services/favorites_service.dart';

enum FavoriteType {
  artist,
  album,
}

class FavoriteButton extends StatefulWidget {
  final FavoriteType type;
  final String id;
  final dynamic item; // Artist ou Album

  const FavoriteButton({
    super.key,
    required this.type,
    required this.id,
    required this.item,
  });

  @override
  State<FavoriteButton> createState() => _FavoriteButtonState();
}

class _FavoriteButtonState extends State<FavoriteButton> {
  final FavoritesService _favoritesService = FavoritesService();
  bool _isFavorite = false;
  bool _isLoading = true;

  @override
  void initState() {
    super.initState();
    _checkIfFavorite();
  }

  Future<void> _checkIfFavorite() async {
    setState(() {
      _isLoading = true;
    });

    bool isFavorite = false;
    if (widget.type == FavoriteType.artist) {
      isFavorite = await _favoritesService.isArtistFavorite(widget.id);
    } else {
      isFavorite = await _favoritesService.isAlbumFavorite(widget.id);
    }

    if (mounted) {
      setState(() {
        _isFavorite = isFavorite;
        _isLoading = false;
      });
    }
  }

  void _toggleFavorite() {
    if (_isFavorite) {
      // Supprimer des favoris
      if (widget.type == FavoriteType.artist) {
        context.read<FavoritesBloc>().add(RemoveFavoriteArtist(widget.id));
      } else {
        context.read<FavoritesBloc>().add(RemoveFavoriteAlbum(widget.id));
      }
    } else {
      // Ajouter aux favoris
      if (widget.type == FavoriteType.artist) {
        context.read<FavoritesBloc>().add(AddFavoriteArtist(widget.item as Artist));
      } else {
        context.read<FavoritesBloc>().add(AddFavoriteAlbum(widget.item as Album));
      }
    }

    // Mettre à jour l'état local pour une réponse immédiate de l'UI
    setState(() {
      _isFavorite = !_isFavorite;
    });
  }

  @override
  Widget build(BuildContext context) {
    if (_isLoading) {
      return const SizedBox(
        width: 24,
        height: 24,
        child: CircularProgressIndicator(
          strokeWidth: 2,
        ),
      );
    }

    return IconButton(
      icon: Icon(
        _isFavorite ? Icons.favorite : Icons.favorite_border,
        color: _isFavorite ? Colors.red : null,
      ),
      onPressed: _toggleFavorite,
      tooltip: _isFavorite ? 'Remove from favorites' : 'Add to favorites',
    );
  }
} 