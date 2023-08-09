import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:secondtest/screen/ProviderPattern/draweritems/series/SeriesDetailsScreen.dart';

import '../screen/ProviderPattern/draweritems/movies/MoviesDetailsScreen.dart';

class AllMoviesItems extends StatelessWidget {
  // final List<Results> data;
  // final int index;
  final bool isMovies;
  final int id;
  final String posterPath;
  final String title;
  final String voteAverage;
  const AllMoviesItems({Key? key,
    required this.isMovies,
    required this.id,
    required this.posterPath,
    required this.title,
    required this.voteAverage})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
      return  InkWell(
          onTap: () {
            print("Send id is ${id}");
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
                    fit:  BoxFit.fitHeight,
                    imageUrl:
                    "https://image.tmdb.org/t/p/w500$posterPath",
                    errorWidget: (context, url, error) =>
                        Image.network(posterPath),
                  ),
                ),
                Text(
                  title ,
                  style: GoogleFonts.roboto(
                    color: Colors.black,
                    fontSize: 18,
                  ),
                ),
                Wrap(
                  children: [
                    Text(
                      "Rating ",
                      style: GoogleFonts.roboto(fontSize: 18),
                    ),
                    Text(
                      "$voteAverage" ,
                      style: GoogleFonts.roboto(
                        color: Colors.red,
                        fontSize: 18,
                      ),
                    )
                  ],
                ),
              ],
            ),
          ),
        );
  }
}
