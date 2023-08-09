

import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:secondtest/screen/ProviderPattern/draweritems/series/SeriesDetailsScreen.dart';

import '../screen/ProviderPattern/draweritems/movies/MoviesDetailsScreen.dart';

class HorizontalMoviesItems extends StatelessWidget {

  final bool isMovies;
  final int id;
  final String posterPath;
  final String title;
  final String voteAverage;
  const HorizontalMoviesItems({Key? key,
    required this.isMovies,
    required this.id,
    required this.posterPath,
    required this.title,
    required this.voteAverage})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 200,
      width: 150,
      child: InkWell(
        onTap: () {
          print("Send id is $id");
          if(isMovies){
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) =>
                    MoviesDetailsScreen(
                        id: id),
              ),
            );
          }else{
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) =>
                    SeriesDetailsScreen(
                        id: id),
              ),
            );
          }

        },
        child: Container(
          margin: const EdgeInsets.only(bottom: 5),
          child: Column(
            children: [
              ClipRRect(
                borderRadius: BorderRadius.circular(8),
                child: CachedNetworkImage(
                  height: 160,
                  fit:  BoxFit.fitHeight,
                  imageUrl:
                  "https://image.tmdb.org/t/p/w500$posterPath",
                  errorWidget: (context, url, error) =>
                      Image.network("https://images.pexels.com/photos/1353126/pexels-photo-1353126.jpeg?auto=compress&cs=tinysrgb&w=600"),
                ),
              ),
              Expanded(
                child: Text(
                  title ,
                  style: GoogleFonts.roboto(
                    color: Colors.black,
                    fontSize: 14,
                  ),
                ),
              ),
              Wrap(
                children: [
                  Text(
                    "Rating ",
                    style: GoogleFonts.roboto(fontSize: 14),
                  ),
                  Text(
                    "$voteAverage" ,
                    style: GoogleFonts.roboto(
                      color: Colors.red,
                      fontSize: 14,
                    ),
                  )
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
