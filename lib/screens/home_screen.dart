import 'package:flutter/material.dart';
import '../model/movie_model.dart';
import '../services/api_services.dart';
import '../widget/carousel_slider_card.dart';
import '../widget/mov_list.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  List<Movie> movies = [];

  @override
  void initState() {
    super.initState();
    fetchMovies();
  }

  void fetchMovies() async {
    movies = await ApiService.fetchMovies();
    setState(() {});
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: CustomScrollView(
        slivers: [
          // SliverAppBar for a collapsible and scrollable header
          SliverAppBar(
            title: Text(
              'NETFLIX',
              style: TextStyle(
                  color: Colors.red, fontWeight: FontWeight.bold, fontSize: 40),
            ),

            backgroundColor: Colors.transparent,
            // Height when expanded
            floating: true, // Keeps app bar visible when scrolled up
            pinned: false,
            actions: [
              Padding(
                padding: const EdgeInsets.only(
                    right: 10.0), // Right padding for alignment
                child: GestureDetector(
                  onTap: () {
                    // Handle account tap, e.g., open profile page
                  },
                  child: Icon(
                    Icons.account_circle,
                    color: Colors.white,
                    size: 40, // Icon size inside the circle
                  ),
                ),
              ),
            ], // Keeps app bar visible when scrolled down
          ),
          SliverToBoxAdapter(
            child: Padding(
              padding: EdgeInsets.symmetric(horizontal: 10),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,

                children: [
                  SizedBox(height: 10),

                  CarouselSliderCard(),
                  SizedBox(height: 40),
                  Text(
                    "Popular Movies",
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 30,
                      fontWeight: FontWeight.w700,
                    ),
                  ),
                  // SizedBox(height: 20),
                  MovieList(),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
