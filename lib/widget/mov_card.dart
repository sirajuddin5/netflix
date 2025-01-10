import 'package:flutter/material.dart';
import 'package:netflix/model/movie_model.dart';

import '../screens/details_screen.dart';

class MovCard extends StatelessWidget {
  final String title;
  final String imagePath;
  final Movie movie;

  const MovCard({
    required this.title,
    required this.imagePath,
    required this.movie,
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => DetailsScreen(movie: movie)),
        );
      },
      child: Container(
        margin: const EdgeInsets.all(8.0),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(16),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.3),
              blurRadius: 10,
              offset: Offset(0, 6),
            ),
          ],
        ),
        child: ClipRRect(
          borderRadius: BorderRadius.circular(16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              // Image Section
              Expanded(
                child: Stack(
                  children: [
                    imagePath.isNotEmpty
                        ? Image.network(
                            imagePath,
                            fit: BoxFit.cover,
                            width: double.infinity,
                            errorBuilder: (context, error, stackTrace) =>
                                Center(
                              child: Icon(
                                Icons.download,
                                size: 50,
                                color: Colors.grey,
                              ),
                            ),
                          )
                        : Center(
                            child: Icon(
                              Icons.cloud_download_rounded,
                              size: 50,
                              color: Colors.grey,
                            ),
                          ),
                  ],
                ),
              ),
              // Title Section
              Container(
                color: Colors.black87, // Background for text section
                padding: const EdgeInsets.all(8.0),
                child: Text(
                  title,
                  style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.w600,
                    color: Colors.white,
                  ),
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
