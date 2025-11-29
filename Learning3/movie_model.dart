class Movie {
  final String title;
  final String overview;
  final String posterPath;

  Movie({
    required this.title,
    required this.overview,
    required this.posterPath,
  });

  // Factory constructor untuk parsing JSON
  factory Movie.fromJson(Map<String, dynamic> json) {
    return Movie(
      title: json['title'] ?? 'Tanpa Judul',
      overview: json['overview'] ?? 'Tidak ada deskripsi.',
      posterPath: json['poster_path'] ?? '',
    );
  }

  // URL lengkap untuk poster
  String get fullPosterUrl => 'https://image.tmdb.org/t/p/w500/$posterPath';
}
