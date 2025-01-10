import 'package:flutter/material.dart';
import '../model/movie_model.dart';
import '../services/api_services.dart';
import 'mov_card.dart';

class MovieList extends StatefulWidget {
  const MovieList({super.key});

  @override
  State<MovieList> createState() => _MovieListState();
}

class _MovieListState extends State<MovieList> {
  late Future<List<Movie>> movies;

  @override
  void initState() {
    super.initState();
    movies = ApiService.fetchMovies();
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<List<Movie>>(
      future: movies,
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return Center(child: CircularProgressIndicator());
        } else if (snapshot.hasError) {
          return Center(child: Text("Error: ${snapshot.error}"));
        } else if (snapshot.hasData) {
          return GridView.builder(
            shrinkWrap: true,
            physics: NeverScrollableScrollPhysics(),
            gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 2,
              crossAxisSpacing: 8.0,
              mainAxisSpacing: 8.0,
              childAspectRatio:
                  0.7, // Adjust aspect ratio to better fit the image and text
            ),
            itemCount: snapshot.data?.length ?? 0,
            itemBuilder: (context, index) {
              final movie = snapshot.data![index];
              return MovCard(
                title: movie.title,
                imagePath: movie.imageUrl ?? '',
                movie: movie,
              );
            },
          );
        }
        return Center(child: Text("No data available"));
      },
    );
  }
}
