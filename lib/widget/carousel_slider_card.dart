import 'package:flutter/material.dart';
import 'package:netflix/services/api_services.dart';
import 'package:netflix/model/movie_model.dart';
import '../screens/details_screen.dart';


class CarouselSliderCard extends StatefulWidget {
  const CarouselSliderCard({super.key});

  @override
  _CarouselSliderCardState createState() => _CarouselSliderCardState();
}

class _CarouselSliderCardState extends State<CarouselSliderCard> {
  late Future<List<Movie>> _movies; // To store fetched movie data
  int _currentIndex = 0; // To track current carousel index
  late PageController _pageController; // To control the page view

  @override
  void initState() {
    super.initState();
    _movies = ApiService.fetchMoviesCrousel(); // Fetch movies for the carousel
    _pageController = PageController(); // Initialize the page controller
  }

  // Navigate to the movie detail screen when tapped
  void navigateToDetailsView(BuildContext context, Movie movie) {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => DetailsScreen(movie: movie),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {

    return FutureBuilder<List<Movie>>(
      future: _movies,
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return _buildLoadingIndicator(); // Loading state
        }

        if (snapshot.hasError) {
          return _buildErrorWidget(snapshot.error.toString()); // Error state
        }

        if (snapshot.hasData) {
          List<Movie> movies = snapshot.data!;


          return Column(
            children: [
              SizedBox(
                height: 250, // Height of the carousel
                child: PageView.builder(
                  controller: _pageController,
                  itemCount: movies.length,
                  itemBuilder: (context, index) {
                    final movie = movies[index];
                    print('============================');
                    print(movie.url);
                    return GestureDetector(
                      onTap: () => navigateToDetailsView(context, movie),
                      child: Stack(
                        children: [
                          SliderCardImage(
                            imageUrl: movie.imageUrl,
                          ),

                          _buildCarouselOverlay(movie.name),
                        ],
                      ),
                    );
                  },
                  onPageChanged: (index) {
                    setState(() {
                      _currentIndex = index;
                    });
                  },
                ),
              ),
              _buildCarouselIndicators(movies.length),
            ],
          );
        }

        return _buildErrorWidget('No movies found'); // Empty state
      },
    );
  }

  // Method to build loading indicator
  Widget _buildLoadingIndicator() {
    return Center(
      child: CircularProgressIndicator(),
    );
  }

  // Method to build error state widget
  Widget _buildErrorWidget(String error) {
    return Center(
      child: Text('Error: $error'),
    );
  }

  Widget _buildCarouselOverlay(String title) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.end,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        // Container with gradient background behind the title
        Container(
          width: double
              .infinity, // Make the container span the full width of the screen
          padding: const EdgeInsets.all(8), // Padding around the title text
          decoration: BoxDecoration(
            gradient: LinearGradient(
              colors: [
                Colors.black.withOpacity(1), // Bold black at the bottom
                Colors.black.withOpacity(
                    0.1), // Faded black (100 opacity to 10) at the top
              ],
              begin: Alignment.bottomCenter,
              end: Alignment.topCenter,
            ),
          ),
          child: Text(
            title,
            maxLines: 2,
            overflow: TextOverflow
                .ellipsis, // Handles overflow if the title is too long
            style: Theme.of(context).textTheme.titleMedium?.copyWith(
                  color: Colors.white, // Text color remains white
                  fontWeight: FontWeight.bold, // Bold font for the title
                  fontSize: 18, // Adjust the font size as needed
                ),
          ),
        ),
      ],
    );
  }

  // Method to build the carousel page indicators
  Widget _buildCarouselIndicators(int length) {
    return Padding(
      padding: const EdgeInsets.only(top: 10),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: List.generate(length, (indexDot) {
          return Container(
            margin: const EdgeInsets.only(right: 5),
            width: indexDot == _currentIndex ? 30 : 6,
            height: 6,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(6),
              color: indexDot == _currentIndex ? Colors.red : Colors.grey,
            ),
          );
        }),
      ),
    );
  }
}

class SliderCardImage extends StatelessWidget {
  final String? imageUrl;

  const SliderCardImage({super.key, this.imageUrl});

  @override
  Widget build(BuildContext context) {
    return imageUrl == null ? _buildPlaceholder() : _buildImage();
  }

  // Builds a placeholder widget if image URL is null
  Widget _buildPlaceholder() {
    return Container(
      color: Colors.grey[300],
      child: Center(
        child: Icon(
          Icons.image,
          color: Colors.white,
          size: 50,
        ),
      ),
    );
  }

  // Builds the image with proper loading and error handling
  Widget _buildImage() {
    return Image.network(
      width: double.infinity,
      imageUrl!,
      fit: BoxFit.cover,
      loadingBuilder: (BuildContext context, Widget child,
          ImageChunkEvent? loadingProgress) {
        if (loadingProgress == null) {
          return child; // Image loaded successfully
        } else {
          return Center(
            child: CircularProgressIndicator(
              value: loadingProgress.expectedTotalBytes != null
                  ? loadingProgress.cumulativeBytesLoaded /
                      (loadingProgress.expectedTotalBytes ?? 1)
                  : null,
            ),
          );
        }
      },
      errorBuilder: (context, error, stackTrace) {
        return _buildPlaceholder(); // Show placeholder if image fails to load
      },
    );
  }
}
