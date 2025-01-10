import 'package:flutter/material.dart';
import '../model/movie_model.dart';
import '../services/api_services.dart';
import '../widget/movie_card.dart';

class SearchScreen extends StatefulWidget {
  @override
  _SearchScreenState createState() => _SearchScreenState();
}

class _SearchScreenState extends State<SearchScreen> {
  List<Movie> searchResults = [];
  final TextEditingController _searchController = TextEditingController();

  void searchMovies() async {
    final query = _searchController.text;
    if (query.isNotEmpty) {
      searchResults = await ApiService.fetchMoviesWithQuery(query);
      _searchController.clear();
    } else {
      searchResults = [];
    }
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: CustomScrollView(
        slivers: [
          SliverAppBar(
            floating: true,
            pinned: true,
            snap: false,
            title: TextField(
              controller: _searchController,
              onSubmitted: (value) => searchMovies(),
              decoration: InputDecoration(
                hintText: 'Search for movies...',
                suffixIcon: IconButton(
                  icon: Icon(Icons.search),
                  onPressed: searchMovies,
                ),
                filled: true,
                contentPadding: EdgeInsets.all(10),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(25.0),
                  borderSide: BorderSide.none,
                ),
                enabledBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(30.0),
                  borderSide: BorderSide.none,
                ),
                focusedBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(30.0),
                ),
              ),
            ),
            // expandedHeight: 80.0,
            backgroundColor: Colors.black26,
          ),
          searchResults.isEmpty
              ? SliverFillRemaining(
            child: Center(
              child: Text(
                'No results found',
                style: TextStyle(color: Colors.white70, fontSize: 16),
              ),
            ),
          )
              : SliverPadding(
            padding: EdgeInsets.all(17.0),
            sliver: SliverGrid(
              gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 2, // Two columns per row
                mainAxisSpacing: 10.0,
                crossAxisSpacing: 10.0,
                childAspectRatio: 0.662, // Aspect ratio to fit card height
              ),
              delegate: SliverChildBuilderDelegate(
                    (context, index) {
                  return MovieCard(movie: searchResults[index]);
                },
                childCount: searchResults.length,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
