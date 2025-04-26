import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:movie_app/screen/home/model/movie/movie_model.dart';
import 'package:movie_app/utils/constants.dart';

import '../../utils/app_methods.dart';
import '../../utils/cached_network_image.dart';

class DetailsScreen extends StatelessWidget {
  final MovieModel movieModel;

  const DetailsScreen({super.key, required this.movieModel});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      appBar: AppBar(
        title: Text(
          movieModel.title,
          style: TextStyle(
            color: Colors.white,
            fontWeight: FontWeight.bold,
            fontSize: 16,
          ),
        ),
        backgroundColor: Colors.black,
        titleSpacing: 0,
        leading: IconButton(
          onPressed: () => Navigator.pop(context),
          icon: Icon(CupertinoIcons.back, color: Colors.white),
        ),
      ),
      body: SafeArea(
        child: Stack(
          alignment: Alignment.bottomCenter,
          children: [
            Column(
              children: [
                AppCachedImage(
                  imageUrl: AppMethods.getImageUrl(movieModel.backdropPath),
                  fit: BoxFit.cover,
                  height: MediaQuery.sizeOf(context).height * 0.5,
                  width: double.infinity,
                  borderRadius: BorderRadius.circular(0),
                ),
                Expanded(
                  child: Transform.translate(
                    offset: Offset(0, -30),
                    child: Container(
                      padding: EdgeInsets.all(15),
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.only(
                          topLeft: Radius.circular(20),
                          topRight: Radius.circular(20),
                        ),
                        color: Colors.black,
                      ),
                      width: double.infinity,
                      child: SingleChildScrollView(
                        child: Column(
                          spacing: 10,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Row(
                              spacing: 10,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                AppCachedImage(
                                  imageUrl: AppMethods.getImageUrl(
                                    movieModel.posterPath,
                                  ),
                                  fit: BoxFit.cover,
                                  height: 120,
                                  width: 100,
                                  borderRadius: BorderRadius.circular(18),
                                ),
                                Expanded(
                                  child: Text(
                                    "Overview   :  ${movieModel.overview}",
                                    style: TextStyle(
                                      color: Colors.white,
                                      fontWeight: FontWeight.bold,
                                      fontSize: 16,
                                    ),
                                  ),
                                ),
                              ],
                            ),

                            Wrap(
                              spacing: 8,
                              runSpacing: 15,
                              children:
                                  movieModel.genreIds.map((genre) {
                                    return Container(
                                      padding: EdgeInsets.symmetric(
                                        vertical: 8,
                                        horizontal: 15,
                                      ),
                                      decoration: BoxDecoration(
                                        borderRadius: BorderRadius.circular(20),
                                        border: Border.all(color: Colors.amber),
                                      ),
                                      child: Text(
                                        Constants.genresList
                                            .where((e) => e.id == genre)
                                            .first
                                            .name,
                                        style: TextStyle(
                                          fontWeight: FontWeight.bold,
                                          color: Colors.amber,
                                        ),
                                        textAlign: TextAlign.center,
                                      ),
                                    );
                                  }).toList(),
                            ),

                            Row(
                              spacing: 10,
                              children: [
                                Icon(Icons.calendar_month, color: Colors.white),
                                Text(
                                  DateFormat(
                                    'MMMM d, y',
                                  ).format(movieModel.releaseDate),
                                  style: const TextStyle(
                                    color: Colors.white70,
                                    fontSize: 12,
                                  ),
                                ),
                              ],
                            ),

                            Row(
                              spacing: 10,
                              children: [
                                Text(
                                  "Average votes",
                                  style: const TextStyle(
                                    color: Colors.white70,
                                    fontSize: 12,
                                  ),
                                ),
                                Row(
                                  children: [
                                    const Icon(
                                      Icons.star,
                                      color: Colors.amber,
                                      size: 14,
                                    ),
                                    const SizedBox(width: 2),
                                    Text(
                                      movieModel.voteCount.toString(),
                                      style: const TextStyle(
                                        color: Colors.white70,
                                        fontSize: 12,
                                      ),
                                    ),
                                  ],
                                ),
                              ],
                            ),

                            SizedBox(height: 30),
                          ],
                        ),
                      ),
                    ),
                  ),
                ),
              ],
            ),
            Container(
              margin: EdgeInsets.only(bottom: 10),
              width:
                  MediaQuery.sizeOf(context).width -
                  40, // set your desired width
              child: ElevatedButton(
                style: ButtonStyle(
                  backgroundColor: WidgetStateProperty.all(Colors.amber),
                  shape: WidgetStateProperty.all(
                    RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(20),
                    ),
                  ),
                ),
                onPressed: () {},
                child: Text(
                  "Booking ticket",
                  style: TextStyle(
                    color: Colors.black,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
