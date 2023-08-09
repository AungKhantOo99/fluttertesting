

import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import 'package:secondtest/screen/ProviderPattern/draweritems/ActorDetailsScreen.dart';

import '../../../../provider/GetAllMoviesDataProvider.dart';


class MoviesDetailsScreen extends StatelessWidget {
  final int id;

  const MoviesDetailsScreen({Key? key, required this.id})
      : super(key: key);
  @override
  Widget build(BuildContext context) {
    if (kDebugMode) {
      print("Received id is $id");
    }
    Provider.of<GetAllMoviesDataProvider>(context, listen: false).fetchMoviesDetails(id);
    Provider.of<GetAllMoviesDataProvider>(context, listen: false).fetchAllCastForMovies(id);

    return Scaffold(
        appBar: AppBar(
          centerTitle: true,
          title: PreferredSize(
            preferredSize: const Size.fromHeight(kToolbarHeight),
            child: Consumer<GetAllMoviesDataProvider>(
              builder: (context, T, _) {
                return Text(T.moviesDetails.title ?? "");
              },
            ),
          ),
        ),
        body: Consumer<GetAllMoviesDataProvider>(
          builder: (context, T, child) {
            return ListView(
                children: [
                  Container(
                    margin: const EdgeInsets.only(top: 20),
                    child: Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        CachedNetworkImage(
                          width: 150,
                          height: 200,
                          fit: BoxFit.fitHeight,
                          imageUrl: "https://image.tmdb.org/t/p/w500${T
                              .moviesDetails.posterPath ?? ""}",
                          // placeholder: (context, url) => CircularProgressIndicator(),
                          errorWidget: (context, url, error) =>
                          const Icon(Icons.error),
                        ),
                        Expanded(
                          child: Container(
                            height: 200,
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                              children: [
                                Text(T.moviesDetails.title ?? "",
                                  style: GoogleFonts.roboto(
                                    fontSize: 18,
                                    fontWeight: FontWeight.bold
                                  ),
                                ),
                                Text("Rating : ${T.moviesDetails.voteAverage ?? 0}/10",
                                  style: GoogleFonts.roboto(
                                    fontSize: 18,
                                  ),
                                ),
                                Text("Votes : ${T.moviesDetails.voteCount ?? 0}",
                                  style: GoogleFonts.roboto(
                                    fontSize: 18,
                                  ),
                                ),
                                Text("release_date : ${T.moviesDetails.releaseDate ?? 0}",
                                  style: GoogleFonts.roboto(
                                    fontSize: 18,
                                  ),
                                ),
                                Text("Language : ${T.moviesDetails.originalLanguage ?? 0}",
                                  style: GoogleFonts.roboto(
                                    fontSize: 18,
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                      ],
                    ),),
                  Container(
                    margin: const EdgeInsets.only(top: 20,left: 10),
                    child: Text(T.moviesDetails.title ?? "",style: GoogleFonts.roboto(
                      fontSize: 18,
                      color: Colors.black,
                    ),),
                  ),
                  Container(
                    margin: const EdgeInsets.only(top: 20,left: 10),
                    child: Text(T.moviesDetails.overview ?? "",
                      style: GoogleFonts.roboto(fontSize: 16),),
                  ),
                  Container(
                    margin: const EdgeInsets.only(top: 15),
                    child:  Text("  Casts",style: GoogleFonts.roboto(
                         fontSize: 18,
                         color: Colors.black,
                         ),),
                  ),
                  SizedBox(
                    height: 200,
                    child: T.allCast.isEmpty
                        ? const Center(
                      child: CircularProgressIndicator(),)
                        : ListView.builder(
                        scrollDirection: Axis.horizontal,
                        itemCount: T.allCast.length,
                        itemBuilder: (BuildContext context,index) {
                          return  InkWell(
                            onTap: () {
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (context) =>
                                      ActorDetailsScreen(
                                          id: T.allCast[index].id!,isFromMovies: true),
                                ),
                              );
                            },
                            child: Column(
                              children: [
                                Container(
                                  height: 130,
                                  width: 100,
                                  color: Colors.black,
                                  margin: const EdgeInsets.all(5),
                                  child: CachedNetworkImage(
                                    fit:  BoxFit.fitWidth,
                                    imageUrl:
                                    "https://image.tmdb.org/t/p/w500${T.allCast[index].profilePath}",
                                    errorWidget: (context, url, error) =>
                                        Image.network("https://vermessung-go.de/wp-content/uploads/2016/03/Mr-Unknow-300x255.jpg"),
                                   ),
                                   ),
                                SizedBox(
                                  width: 90,
                                  height: 20,
                                  child: Center(
                                    child: Wrap(
                                      children: [
                                        Center(
                                          child: Text(
                                              T.allCast[index].originalName ?? "unKnown",
                                            style: GoogleFonts.roboto(fontSize: 16),
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                )
                              ],
                            ),
                          );
                        }),
                  ),
                ]
                ,
              );
          },
        )
    );
  }

}

