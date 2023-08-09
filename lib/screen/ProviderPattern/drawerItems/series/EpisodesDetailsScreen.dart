

// ignore_for_file: unnecessary_null_comparison

import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import '../../../../provider/GetAllMoviesDataProvider.dart';



class EpisodesDetailsScreen extends StatelessWidget {
  final int seriesId;
  final int seasonId;

  const EpisodesDetailsScreen({Key? key, required this.seriesId,required this.seasonId})
      : super(key: key);


  @override
  Widget build(BuildContext context) {
   final provider= Provider.of<GetAllMoviesDataProvider>(context, listen: false);
   provider.fetchAllEpisodes(seriesId,seasonId);
    return Scaffold(
      appBar: AppBar(title: const Text("All Episodes"),centerTitle: true),
      body: Consumer<GetAllMoviesDataProvider>(
        builder: (context, T, child) {
          if(T.seasonDetails == null){
            return Center(child: CircularProgressIndicator());
          }else{
            return ListView(
              children: [
                CachedNetworkImage(
                  width: 150,
                  height: 200,
                  fit: BoxFit.fitHeight,
                  imageUrl: "https://image.tmdb.org/t/p/w500${T.seasonDetails.posterPath?? ""}",
                  // placeholder: (context, url) => CircularProgressIndicator(),
                  errorWidget: (context, url, error) =>
                  const Icon(Icons.error),
                ),
                Container(
                  margin: const EdgeInsets.only(top: 5),
                  child:  Text(T.seasonDetails.name ?? "",style: GoogleFonts.roboto(
                    fontSize: 18,
                    color: Colors.black,
                  ),textAlign: TextAlign.center),
                ),
                Container(
                  margin: const EdgeInsets.only(top: 5),
                  child:  Text(T.seasonDetails.overview ?? "",style: GoogleFonts.roboto(),),
                ),
                Container(
                  margin: const EdgeInsets.only(top: 15),
                  child:  Text("All Episodes",style: GoogleFonts.roboto(
                    fontSize: 18,
                    color: Colors.black,
                  ),),
                ),
                Container(
                  child: T.seasonDetails.toString().isEmpty
                      ? const Center(
                    child: CircularProgressIndicator(),)
                      :  ListView.builder(
                    shrinkWrap: true,
                    physics: const NeverScrollableScrollPhysics(),
                    itemCount: T.seasonDetails.episodes?.length ?? 0,
                    itemBuilder: (BuildContext context, int index) {
                      return InkWell(
                        child: Container(
                          margin: const EdgeInsets.all(15),
                          child:  Row(
                            children: [
                              CachedNetworkImage(
                                width: 70,
                                height: 100,
                                fit: BoxFit.fitHeight,
                                imageUrl: "https://image.tmdb.org/t/p/w500${T.seasonDetails.episodes?[index].stillPath ?? ""}",
                                // placeholder: (context, url) => CircularProgressIndicator(),
                                errorWidget: (context, url, error) =>
                                const Icon(Icons.error),
                              ),
                              Expanded(
                                  child: Column(
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    mainAxisAlignment: MainAxisAlignment.start,
                                    children: [
                                      Container(
                                          margin : const EdgeInsets.only(left:30),
                                          child: Text("${T.seasonDetails.episodes?[index].episodeNumber} ${T.seasonDetails.episodes?[index].name}",
                                            style: GoogleFonts.roboto(
                                                fontSize: 15,fontWeight: FontWeight.bold
                                            ),
                                          )
                                      ),
                                      Container(
                                          margin : const EdgeInsets.only(left:30,top: 5),
                                          height: 60,
                                          child: Text(
                                            T.seasonDetails.episodes?[index].overview ?? "",
                                            overflow: TextOverflow.ellipsis,
                                            style: GoogleFonts.roboto(
                                                fontSize: 13
                                            ),
                                            maxLines: 5,)),
                                    ],
                                  ))
                            ],
                          ),
                        ),
                      );
                    },
                  ),
                ),
              ],
            );
          }

    })
    );
  }
}
