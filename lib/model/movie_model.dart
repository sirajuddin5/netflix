class Movie {
  final String title;
  final String? imageUrl;
  final String description;

  Movie({
    required this.title,
    this.imageUrl,
    required this.description,
  });

  factory Movie.fromJson(Map<String, dynamic> json) {
    return Movie(
      title: json['name'] ?? 'No title',
      imageUrl: json['image'] != null ? json['image']['medium'] : null,
      description: json['summary'] ?? 'No description available',
    );
  }
}
