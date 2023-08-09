



import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import 'package:secondtest/screen/ProviderPattern/draweritems/series/EpisodesDetailsScreen.dart';


import '../../../../provider/GetAllMoviesDataProvider.dart';
import '../ActorDetailsScreen.dart';

class SeriesDetailsScreen extends StatelessWidget {
  final int id;

  const SeriesDetailsScreen({Key? key, required this.id})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    Provider.of<GetAllMoviesDataProvider>(context, listen: false).fetchSeriesDetails(id);
    Provider.of<GetAllMoviesDataProvider>(context, listen: false).fetchAllCastForSeries(id);
    return Scaffold(
        appBar: AppBar(
          centerTitle: true,
          title: PreferredSize(
            preferredSize: const Size.fromHeight(kToolbarHeight),
            child: Consumer<GetAllMoviesDataProvider>(
              builder: (context, T, _) {
                return Text(T.seriesDetails.name ?? "");
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
                            .seriesDetails.posterPath ?? ""}",
                        // placeholder: (context, url) => CircularProgressIndicator(),
                        errorWidget: (context, url, error) =>
                        const Icon(Icons.error),
                      ),
                      Expanded(
                        child: SizedBox(
                          height: 200,
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                            children: [
                              Text(T.seriesDetails.name ?? "",
                                style: GoogleFonts.roboto(
                                    fontSize: 18,
                                    fontWeight: FontWeight.bold
                                ),
                              ),
                              Text("Rating : ${T.seriesDetails.voteAverage ?? 0}/10",
                                style: GoogleFonts.roboto(
                                  fontSize: 18,
                                ),
                              ),
                              Text("Votes : ${T.seriesDetails.voteCount ?? 0}",
                                style: GoogleFonts.roboto(
                                  fontSize: 18,
                                ),
                              ),
                              Text("start_date : ${T.seriesDetails.firstAirDate ?? 0}",
                                style: GoogleFonts.roboto(
                                  fontSize: 18,
                                ),
                              ),
                              Text("end_date : ${T.seriesDetails.lastAirDate ?? 0}",
                                style: GoogleFonts.roboto(
                                  fontSize: 18,
                                ),
                              ),
                              Text("Language : ${T.seriesDetails.originalLanguage ?? 0}",
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
                  child: Text(T.seriesDetails.name ?? "",style: GoogleFonts.roboto(
                    fontSize: 18,
                    color: Colors.black,
                  ),),
                ),
                Container(
                  margin: const EdgeInsets.only(top: 20,left: 10),
                  child: Text(T.seriesDetails.overview ?? "",
                    style: GoogleFonts.roboto(fontSize: 16),),
                ),
                Container(
                  margin: const EdgeInsets.only(top: 15),
                  child:  Text("  All Season",style: GoogleFonts.roboto(
                    fontSize: 18,
                    color: Colors.black,
                  ),),
                ),
                Container(
                  child: T.seriesDetails.toString().isEmpty
                      ? const Center(
                    child: CircularProgressIndicator(),)
                      :  ListView.builder(
                      shrinkWrap: true,
                      physics: const NeverScrollableScrollPhysics(),
                      itemCount: T.seriesDetails.seasons?.length ?? 0,
                      itemBuilder: (BuildContext context, int index) {
                        return InkWell(
                          onTap: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) =>
                                  EpisodesDetailsScreen(seriesId: id,seasonId: T.seriesDetails.seasons?[index].seasonNumber! ?? 0),
                            ),
                          );
                        },
                          child: Container(
                            margin: const EdgeInsets.all(15),
                            child:  Row(
                              children: [
                                CachedNetworkImage(
                                  width: 70,
                                  height: 100,
                                  fit: BoxFit.fitHeight,
                                  imageUrl: "https://image.tmdb.org/t/p/w500${T.seriesDetails.seasons?[index].posterPath ?? ""}",
                                  // placeholder: (context, url) => CircularProgressIndicator(),
                                  errorWidget: (context, url, error) =>
                                  const Icon(Icons.error),
                                ),
                                Expanded(
                                    child: Column(
                                       crossAxisAlignment: CrossAxisAlignment.start,
                                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                                      children: [
                                        Container(
                                            margin : const EdgeInsets.only(left:30),
                                            child: Text(T.seriesDetails.seasons?[index].name ?? "",
                                                       style: GoogleFonts.roboto(
                                                         fontSize: 16,
                                                         fontWeight: FontWeight.bold
                                                       ),)
                                           ),
                                        Container(
                                            margin : const EdgeInsets.only(left:30,top: 5),
                                            child: Text("${T.seriesDetails.seasons?[index].airDate} * ${T.seriesDetails.seasons?[index].episodeCount}Episodes",
                                                    style: GoogleFonts.roboto(
                                                      fontSize: 13
                                                    ),
                                                       )
                                        ),
                                        Container(
                                            margin : const EdgeInsets.only(left:30,top: 5),
                                            height: 60,
                                            child: Text(
                                                T.seriesDetails.seasons?[index].overview ?? "",
                                              overflow: TextOverflow.ellipsis,
                                              style: GoogleFonts.roboto(
                                                fontSize: 13
                                              ),
                                              maxLines: 3,)),
                                      ],
                                    ))
                              ],
                            ),
                          ),
                        );
                    },
                  ),
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
                                        id: T.allCast[index].id!,isFromMovies: false),
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
