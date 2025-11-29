import 'package:flutter/material.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;
import 'movie_model.dart';

class MoviePage extends StatefulWidget {
  const MoviePage({super.key});

  @override
  State<MoviePage> createState() => _MoviePageState();
}

class _MoviePageState extends State<MoviePage> {
  final TextEditingController _searchController = TextEditingController();
  Future<List<Movie>>? _futureMovies;

  final String apiKey = 'cf3d30804868074c3363550d6279a9e0'; // 🔑 Ganti dengan API Key TMDb kamu

  @override
  void initState() {
    super.initState();
    _futureMovies = _fetchNowPlaying();
  }

  // Fungsi untuk mengambil daftar film "Now Playing"
  Future<List<Movie>> _fetchNowPlaying() async {
    final url = Uri.parse(
        'https://api.themoviedb.org/3/movie/now_playing?api_key=$apiKey&language=id-ID');
    final response = await http.get(url);

    if (response.statusCode == 200) {
      final Map<String, dynamic> jsonData = jsonDecode(response.body);
      final List results = jsonData['results'];
      return results.map((movie) => Movie.fromJson(movie)).toList();
    } else {
      throw Exception("Gagal memuat data film");
    }
  }

  // Fungsi untuk mencari film berdasarkan judul
  Future<List<Movie>> _searchMovies(String query) async {
    final url = Uri.parse(
        'https://api.themoviedb.org/3/search/movie?api_key=$apiKey&query=$query&language=id-ID');
    final response = await http.get(url);

    if (response.statusCode == 200) {
      final Map<String, dynamic> jsonData = jsonDecode(response.body);
      final List results = jsonData['results'];
      return results.map((movie) => Movie.fromJson(movie)).toList();
    } else {
      throw Exception("Gagal mencari film");
    }
  }

  void _onSearch() {
    final query = _searchController.text.trim();
    if (query.isNotEmpty) {
      setState(() {
        _futureMovies = _searchMovies(query);
      });
    } else {
      setState(() {
        _futureMovies = _fetchNowPlaying();
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Daftar Film TMDb'),
        actions: [
          IconButton(
            icon: const Icon(Icons.refresh),
            onPressed: () {
              setState(() {
                _futureMovies = _fetchNowPlaying();
              });
            },
          )
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(12.0),
        child: Column(
          children: [
            // 🔍 TextField untuk mencari film
            TextField(
              controller: _searchController,
              decoration: InputDecoration(
                labelText: 'Cari Film...',
                suffixIcon: IconButton(
                  icon: const Icon(Icons.search),
                  onPressed: _onSearch,
                ),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(12),
                ),
              ),
            ),
            const SizedBox(height: 16),

            // 🔄 FutureBuilder untuk menampilkan data
            Expanded(
              child: FutureBuilder<List<Movie>>(
                future: _futureMovies,
                builder: (context, snapshot) {
                  if (snapshot.connectionState == ConnectionState.waiting) {
                    return const Center(child: CircularProgressIndicator());
                  } else if (snapshot.hasError) {
                    return Center(child: Text("Error: ${snapshot.error}"));
                  } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
                    return const Center(child: Text("Tidak ada data film."));
                  }

                  final movies = snapshot.data!;
                  return ListView.builder(
                    itemCount: movies.length,
                    itemBuilder: (context, index) {
                      final movie = movies[index];
                      return Card(
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(12),
                        ),
                        elevation: 3,
                        margin: const EdgeInsets.symmetric(vertical: 8),
                        child: ListTile(
                          leading: movie.posterPath.isNotEmpty
                              ? Image.network(
                                  movie.fullPosterUrl,
                                  width: 50,
                                  fit: BoxFit.cover,
                                )
                              : const Icon(Icons.image_not_supported),
                          title: Text(
                            movie.title,
                            style: const TextStyle(
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          subtitle: Text(
                            movie.overview,
                            maxLines: 3,
                            overflow: TextOverflow.ellipsis,
                          ),
                        ),
                      );
                    },
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
