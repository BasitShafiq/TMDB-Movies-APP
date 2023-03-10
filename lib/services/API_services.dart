import 'dart:convert';
import '../models/movies.dart';
import 'package:http/http.dart' as http;
import 'package:tmdb_api/tmdb_api.dart';

final apiKey = "api_key";
final readAccessToken =
    "Token";

class APIServices {
  static Future<List<Movie>> getTopRated() async {
    final tmdbWithCustomLogs = TMDB(
      ApiKeys(apiKey, readAccessToken),
      logConfig: const ConfigLogger(
        showLogs: true,
        showErrorLogs: true,
      ),
    );
    final moviesReturn = await tmdbWithCustomLogs.v3.movies.getTopRated();
    final movies = moviesReturn["results"] as List;
    List<Movie> movie = movies.map((e) => Movie.fromJson(e)).toList();
    for (var i = 0; i < movie.length; i++) {
      print(movie[i].title);
    }
    return movie;
  }

  static Future<List<Movie>> getPopular() async {
    final tmdbWithCustomLogs = TMDB(
      ApiKeys(apiKey, readAccessToken),
      logConfig: const ConfigLogger(
        showLogs: true,
        showErrorLogs: true,
      ),
    );
    final moviesReturn = await tmdbWithCustomLogs.v3.movies.getPopular();
    final movies = moviesReturn["results"] as List;
    List<Movie> movie = movies.map((e) => Movie.fromJson(e)).toList();
    for (var i = 0; i < movie.length; i++) {
      print(movie[i].title);
    }
    return movie;
  }

  static Future<List<Movie>> getNowPlaying() async {
    final tmdbWithCustomLogs = TMDB(
      ApiKeys(apiKey, readAccessToken),
      logConfig: const ConfigLogger(
        showLogs: true,
        showErrorLogs: true,
      ),
    );
    final moviesReturn = await tmdbWithCustomLogs.v3.movies.getNowPlaying();
    final movies = moviesReturn["results"] as List;
    List<Movie> movie = movies.map((e) => Movie.fromJson(e)).toList();
    for (var i = 0; i < movie.length; i++) {
      print(movie[i].title);
    }
    return movie;
  }

  static Future<List<Movie>> getTopRatedTVShows() async {
    final tmdbWithCustomLogs = TMDB(
      ApiKeys(apiKey, readAccessToken),
      logConfig: const ConfigLogger(
        showLogs: true,
        showErrorLogs: true,
      ),
    );
    print("object for TV shows");
    final moviesReturn = await tmdbWithCustomLogs.v3.movies.getUpcoming();
    final movies = moviesReturn["results"] as List;
    List<Movie> movie = movies.map((e) => Movie.fromJson(e)).toList();
    for (var i = 0; i < movie.length; i++) {
      print(movie[i].title);
    }
    return movie;
  }
  static Future<List<Movie>> getNowPlayingTVShows() async {
    final tmdbWithCustomLogs = TMDB(
      ApiKeys(apiKey, readAccessToken),
      logConfig: const ConfigLogger(
        showLogs: true,
        showErrorLogs: true,
      ),
    );
    final moviesReturn = await tmdbWithCustomLogs.v3.trending.getTrending();
    final movies = moviesReturn["results"] as List;
    List<Movie> movie = movies.map((e) => Movie.fromJson(e)).toList();
    for (var i = 0; i < movie.length; i++) {
      print(movie[i].title);
    }
    return movie;
  }

  static Future<String> getYoutubeId(int id) async {
    try {
      final String apiKey = 'api_key=61daee876b572535242a24438978b707';
      final response = await http.get(
          Uri.parse('https://api.themoviedb.org/3/movie/$id/videos?$apiKey'));
      final jsonResponse = jsonDecode(response.body);

      var youtubeId = jsonResponse['results'][0]['key'];
      return youtubeId;
    } catch (error, stacktrace) {
      throw Exception(
          'Exception accoured: $error with stacktrace: $stacktrace');
    }
  }

  static Future<List<Movie>> getModelsAPI() async {
    try {
      final url = "https://api.themoviedb.org/3";
      final res = await http.get(
        Uri.parse("${url}//movie/now_playing?${apiKey}"),
      );

      final jsonResponse = jsonDecode(res.body);
      if (jsonResponse["error"] != null) {
        throw http.ClientException(jsonResponse["error"]["message"]);
      }
      final movies = jsonResponse["results"] as List;
      List<Movie> movie = movies.map((e) => Movie.fromJson(e)).toList();
      print(movie);
      return movie;
    } catch (error) {
      print(error);
      rethrow;
    }
  }
}
