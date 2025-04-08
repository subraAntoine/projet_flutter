import 'package:flutter/material.dart';
import 'package:projet_flutter/core/models/artist.dart';
import 'package:projet_flutter/core/services/the_audio_db.dart';
import 'package:projet_flutter/core/theme/app_colors.dart';
import 'package:projet_flutter/features/artists/widgets/artist_album_item.dart';
import 'package:projet_flutter/features/artists/widgets/artist_track_item.dart';
import 'dart:developer' as developer;

class ArtistScreen extends StatefulWidget {
  final String artistId;
  
  const ArtistScreen({
    Key? key, 
    required this.artistId,
  }) : super(key: key);

  @override
  State<ArtistScreen> createState() => _ArtistScreenState();
}

class _ArtistScreenState extends State<ArtistScreen> {
  final AudioDbApi _audioDbApi = AudioDbApi();
  Artist? _artist;
  bool _isLoading = true;
  String _errorMessage = '';

  @override
  void initState() {
    super.initState();
    _fetchArtistData();
  }

  Future<void> _fetchArtistData() async {
    setState(() => _isLoading = true);
    try {
      developer.log('Fetching artist data for ID: ${widget.artistId}');
      final artistList = await _audioDbApi.fetchArtistData(widget.artistId);
      if (artistList.isNotEmpty) {
        setState(() {
          _artist = artistList.first;
          _isLoading = false;
        });
        developer.log('Artist data fetched successfully: ${_artist!.name}');
      } else {
        setState(() {
          _isLoading = false;
          _errorMessage = 'Aucune information trouvée pour cet artiste';
        });
        developer.log('No artist data found');
      }
    } catch (e) {
      developer.log('Error fetching artist data: $e');
      setState(() {
        _isLoading = false;
        _errorMessage = 'Erreur lors du chargement des données: $e';
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: _isLoading 
        ? const Center(child: CircularProgressIndicator(color: AppColors.primary))
        : _artist == null 
          ? Center(child: Text(_errorMessage))
          : _buildArtistContent(),
    );
  }

  Widget _buildArtistContent() {
    return CustomScrollView(
      slivers: [
        _buildAppBar(),
        SliverToBoxAdapter(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              _buildArtistInfo(),
              const SizedBox(height: 20),
              _buildAlbumSection(),
              const SizedBox(height: 20),
              _buildTopTracksSection(),
            ],
          ),
        ),
      ],
    );
  }

  Widget _buildAppBar() {
    return SliverAppBar(
      expandedHeight: 344.0,
      pinned: true,
      leading: IconButton(
        icon: const Icon(Icons.arrow_back_ios, color: Colors.white),
        onPressed: () => Navigator.pop(context),
      ),
      actions: [
        Padding(
          padding: const EdgeInsets.only(top: 8.0, right: 8.0),
          child: CircleAvatar(
            backgroundColor: Colors.white,
            child: IconButton(
              icon: const Icon(Icons.favorite, color: AppColors.primary),
              onPressed: () {},
            ),
          ),
        ),
      ],
      flexibleSpace: FlexibleSpaceBar(
        titlePadding: const EdgeInsets.only(left: 16.0, bottom: 16.0),
        title: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              _artist!.name,
              style: const TextStyle(
                color: Colors.white,
                fontWeight: FontWeight.bold,
              ),
            ),
           if (_artist!.country != null && _artist!.country!.isNotEmpty)
              Text(
                "${_artist!.country} - ${_artist!.genre ?? 'R&B'}",
                style: TextStyle(
                  color: const Color.fromARGB(178, 255, 255, 255),
                  fontSize: 14,
                ),
            ),
          ],
        ),

        background: Stack(
          fit: StackFit.expand,
          children: [
            // Background image
            _artist!.fanart != null && _artist!.fanart!.isNotEmpty
              ? Image.network(
                  _artist!.fanart!,
                  fit: BoxFit.cover,
                  errorBuilder: (context, error, stackTrace) => Container(
                    color: Colors.grey[300],
                    child: const Icon(Icons.image_not_supported, size: 50),
                  ),
                )
              : Container(color: Colors.grey[300]),
            
            // Gradient overlay
            Container(
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  begin: Alignment.topCenter,
                  end: Alignment.bottomCenter,
                  colors: [
                    Colors.transparent,
                    Colors.black.withAlpha(178),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildArtistInfo() {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          
          const SizedBox(height: 16),
          
          // Bio
          if (_artist!.biography != null && _artist!.biography!.isNotEmpty)
            Text(
              _artist!.biography!,
              style: const TextStyle(
                fontSize: 16,
                height: 1.5,
                color: Color(0xFF8D8D8D),
              ),
              maxLines: 5,
              overflow: TextOverflow.ellipsis,
            ),
        ],
      ),
    );
  }

  Widget _buildAlbumSection() {
    // Sample data for mockup, would normally come from API
    final sampleAlbums = [
      {"title": "After Hours", "year": "2020", "image": _artist?.thumb},
      {"title": "Star boy", "year": "2016", "image": _artist?.thumb},
      {"title": "Beauty Behind the Madness", "year": "2015", "image": _artist?.thumb},
    ];

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Padding(
          padding: EdgeInsets.symmetric(horizontal: 16.0),
          child: Text(
            "Albums (12)",
            style: TextStyle(
              fontSize: 24,
              fontWeight: FontWeight.w800,
            ),
          ),
        ),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 10.0, vertical: 10.0),
          child: Container(
            height: 1,
            color: Colors.grey[300],
          ),
        ),
        const SizedBox(height: 12),
        ListView.builder(
          shrinkWrap: true,
          physics: const NeverScrollableScrollPhysics(),
          itemCount: sampleAlbums.length,
          padding: const EdgeInsets.symmetric(horizontal: 10.0),
          itemBuilder: (context, index) {
            final album = sampleAlbums[index];
            return Padding(
              padding: const EdgeInsets.only(bottom: 12.0),
              child: ArtistAlbumItem(
                title: album["title"]!,
                year: album["year"],
                imageUrl: album["image"],
                onTap: () {
                  // Navigate to album details page
                },
              ),
            );
          },
        ),
      ],
    );
  }

  Widget _buildTopTracksSection() {
    // Sample data for mockup, would normally come from API
    final sampleTracks = [
      "Walk on Water feat. Beyoncé",
      "Believe",
      "Chloraseptic feat. Phresher",
      "Untouchable",
      "River feat. Ed Sheeran",
      "Remind Me (Intro)",
      "Remind Me",
    ];

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Padding(
          padding: EdgeInsets.symmetric(horizontal: 16.0),
          child: Text(
            "Titres les plus appréciés",
            style: TextStyle(
              fontSize: 24,
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
         Padding(
          padding: const EdgeInsets.symmetric(horizontal: 10.0, vertical: 10.0),
          child: Container(
            height: 1,
            color: Colors.grey[300],
          ),
        ),
        ListView.builder(
          shrinkWrap: true,
          physics: const NeverScrollableScrollPhysics(),
          itemCount: sampleTracks.length,
          itemBuilder: (context, index) {
            return ArtistTrackItem(
              rank: index + 1,
              title: sampleTracks[index],
              onTap: () {
                // Handle track play action
              },
            );
          },
        ),
      ],
    );
  }
}
