class Movie {
  final String backdrop_path;
  final String original_language;
  final String original_title;
  final String overview;
  final double popularity;
  final String poster_path;
  final String release_date;
  final bool video;
  final String title;
  final double vote_average;
  final int vote_count;
  Movie({
    required this.backdrop_path,
    required this.original_language,
    required this.original_title,
    required this.overview,
    required this.release_date,
    required this.video,
    required this.vote_average,
    required this.vote_count,
    required this.poster_path,
    required this.popularity,
    required this.title,
  });
  factory Movie.fromJson(dynamic json) {
    return Movie(
      backdrop_path: json['backdrop_path'],
      original_language: json['original_language'],
      original_title: json['original_title'],
      overview: json['overview'],
      release_date: json['release_date'],
      video: json['video'],
      vote_average: json['vote_average'].toDouble(),
      vote_count: json['vote_count'],
      poster_path: json['poster_path'],
      popularity: json['popularity'].toDouble(),
      title: json['title'],
    );
  }
}
