// import 'dart:convert';
//
// import 'package:http/http.dart' as http;
//
// import '../model/movie_model.dart';
//
//
// class ApiService {
//   // Base URL for the API
//   static const String _baseUrl = 'https://api.tvmaze.com';
//
//   // Private helper method to fetch movies with a specified query
//   static Future<List<Movie>> _fetchMovies(String endpoint,
//       {String? query}) async {
//     final url =
//     Uri.parse('$_baseUrl/$endpoint${query != null ? '?q=$query' : ''}');
//
//     final response = await http.get(url);
//
//     if (response.statusCode == 200) {
//       final List<dynamic> data = json.decode(response.body);
//       return data.map((item) => Movie.fromJson(item['show'])).toList();
//     } else {
//       throw Exception('Failed to load movies: ${response.reasonPhrase}');
//     }
//   }
//
//   // Fetch all movies (default query)
//   static Future<List<Movie>> fetchMovies() async {
//     return await _fetchMovies('search/shows', query: 'all');
//   }
//
//   // Fetch movies based on a custom query
//   static Future<List<Movie>> fetchMoviesWithQuery(String query) async {
//     return await _fetchMovies('search/shows', query: query);
//   }
//
//   // Fetch movies for the carousel with a predefined query
//   static Future<List<Movie>> fetchMoviesCrousel() async {
//     return await _fetchMovies('search/shows', query: 'popular');
//   }
// }


import 'dart:convert';
import 'package:http/http.dart' as http;
import '../model/movie_model.dart';

class ApiService {
  // Base URL for the API
  static const String _baseUrl = 'https://api.tvmaze.com';

  // Private helper method to fetch movies with a specified query
  static Future<List<Movie>> _fetchMovies(String endpoint,
      {String? query}) async {
    final url =
    Uri.parse('$_baseUrl/$endpoint${query != null ? '?q=$query' : ''}');

    final response = await http.get(url);

    if (response.statusCode == 200) {
      final List<dynamic> data = json.decode(response.body);
      // Map each item['show'] to the Movie model
      return data.map((item) => Movie.fromJson(item['show'])).toList();
    } else {
      throw Exception('Failed to load movies: ${response.reasonPhrase}');
    }
  }

  // Fetch all movies (default query)
  static Future<List<Movie>> fetchMovies() async {
    return await _fetchMovies('search/shows', query: 'all');
  }

  // Fetch movies based on a custom query
  static Future<List<Movie>> fetchMoviesWithQuery(String query) async {
    return await _fetchMovies('search/shows', query: query);
  }

  // Fetch movies for the carousel with a predefined query
  static Future<List<Movie>> fetchMoviesCrousel() async {
    return await _fetchMovies('search/shows', query: 'popular');
  }
}
