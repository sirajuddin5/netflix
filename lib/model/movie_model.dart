


class Movie {
  final int id;
  final String name;
  final String url;
  final String language;
  final List<String> genres;
  final String status;
  final int runtime;
  final String premiered;
  final String? ended;
  final String officialSite;
  final String imageUrl;
  final String summary;
  final String imdbId;

  // Constructor
  Movie({
    required this.id,
    required this.name,
    required this.url,
    required this.language,
    required this.genres,
    required this.status,
    required this.runtime,
    required this.premiered,
    this.ended,
    required this.officialSite,
    required this.imageUrl,
    required this.summary,
    required this.imdbId,
  });

  // Factory method to create a Movie from JSON
  factory Movie.fromJson(Map<String, dynamic> json) {
    return Movie(
      id: json['id'],
      name: json['name'] ?? 'No title',
      url: json['url'] ??'',
      language: json['language'],
      genres: List<String>.from(json['genres'] ?? []),
      status: json['status'] ?? 'Unknown',
      runtime: json['runtime'] ?? 0,
      premiered: json['premiered'] ?? '',
      ended: json['ended'],
      officialSite: json['officialSite'] ?? '',
      imageUrl: json['image']?['medium'] ?? '',
      summary: json['summary'] ?? 'No description available',
      imdbId: json['externals']?['imdb'] ?? '',
    );
  }
}
