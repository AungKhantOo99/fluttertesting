

import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import 'package:secondtest/screen/ProviderPattern/draweritems/movies/MoviesDetailsScreen.dart';
import 'package:secondtest/screen/ProviderPattern/draweritems/series/SeriesDetailsScreen.dart';

import '../../../provider/GetAllMoviesDataProvider.dart';



class ActorDetailsScreen extends StatelessWidget {
  final int id;
  final bool isFromMovies;

  const ActorDetailsScreen({Key? key, required this.id , required this.isFromMovies})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    late String showinfo;
    Provider.of<GetAllMoviesDataProvider>(context, listen: false).fetchActorDetails(id);
    if(isFromMovies){
      showinfo="Famous Movies";
      Provider.of<GetAllMoviesDataProvider>(context, listen: false).fetchHisFamousMovies(id);
    }else{
      showinfo="Famous Series";
       Provider.of<GetAllMoviesDataProvider>(context, listen: false).fetchHisFamousSeries(id);
    }

    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: PreferredSize(
          preferredSize: const Size.fromHeight(kToolbarHeight),
          child: Consumer<GetAllMoviesDataProvider>(
            builder: (context, T, _) {
              return Text(T.actorDetails.name ?? "");
            },
          ),
        ),
      ),
        body: Consumer<GetAllMoviesDataProvider>(
        builder: (context, T, child) {
          if(isFromMovies){
            return ListView(
              children: [
                Container(
                  margin: const EdgeInsets.only(top: 20),
                  child: Row(
                    // crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      CachedNetworkImage(
                        width: 150,
                        height: 200,
                        fit: BoxFit.fitHeight,
                        imageUrl: "https://image.tmdb.org/t/p/w500${T.actorDetails.profilePath}",
                        errorWidget: (context, url, error) =>
                            Image.network("https://vermessung-go.de/wp-content/uploads/2016/03/Mr-Unknow-300x255.jpg"),
                      ),
                      Expanded(
                        child: SizedBox(
                          height: 200,
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                            children: [
                              Text("Name : ${T.actorDetails.name}",
                                style: GoogleFonts.roboto(
                                  fontSize: 18,
                                ),
                              ),
                              Text("Date of Birth : ${T.actorDetails.birthday}",
                                style: GoogleFonts.roboto(
                                  fontSize: 18,
                                ),
                              ),
                              Text("Place of Birth : ${T.actorDetails.placeOfBirth}",
                                style: GoogleFonts.roboto(
                                  fontSize: 18,
                                ),
                              ),
                              Text("Known Credits : ${T.actorDetails.knownForDepartment}",
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
                  child: Text("Biography",style: GoogleFonts.roboto(
                    fontSize: 18,
                    color: Colors.black,
                  ),),
                ),
                Container(
                  margin: const EdgeInsets.only(top: 20,left: 10),
                  child: Text(T.actorDetails.biography ?? "",style: GoogleFonts.roboto(
                    fontSize: 18,
                    color: Colors.black,
                  ),),
                ),
                Container(
                  margin: const EdgeInsets.only(top: 20,left: 10),
                  child: Text(showinfo,style: GoogleFonts.roboto(
                    fontSize: 18,
                    color: Colors.black,
                  ),),
                ),
                SizedBox(
                  height: 200,
                  child: T.hisFamousMovies.isEmpty
                      ? const Center(
                    child: CircularProgressIndicator(),)
                      : ListView.builder(
                      scrollDirection: Axis.horizontal,
                      itemCount: T.hisFamousMovies.length,
                      itemBuilder: (BuildContext context,index) {
                        return InkWell(
                          onTap: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) =>
                                    MoviesDetailsScreen(
                                        id: T.hisFamousMovies[index].id!),
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
                                  "https://image.tmdb.org/t/p/w500${T.hisFamousMovies[index].posterPath}",
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
                                          T.hisFamousMovies[index].title ?? "unKnown",
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
              ],
            );
          }else{
            return ListView(
              children: [
                Container(
                  margin: const EdgeInsets.only(top: 20),
                  child: Row(
                    // crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      CachedNetworkImage(
                        width: 150,
                        height: 200,
                        fit: BoxFit.fitHeight,
                        imageUrl: "https://image.tmdb.org/t/p/w500${T.actorDetails.profilePath}",
                        errorWidget: (context, url, error) =>
                            Image.network("https://vermessung-go.de/wp-content/uploads/2016/03/Mr-Unknow-300x255.jpg"),
                      ),
                      Expanded(
                        child: SizedBox(
                          height: 200,
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                            children: [
                              Text("Name : ${T.actorDetails.name}",
                                style: GoogleFonts.roboto(
                                  fontSize: 18,
                                ),
                              ),
                              Text("Date of Birth : ${T.actorDetails.birthday}",
                                style: GoogleFonts.roboto(
                                  fontSize: 18,
                                ),
                              ),
                              Text("Place of Birth : ${T.actorDetails.placeOfBirth}",
                                style: GoogleFonts.roboto(
                                  fontSize: 18,
                                ),
                              ),
                              Text("Known Credits : ${T.actorDetails.knownForDepartment}",
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
                  child: Text("Biography",style: GoogleFonts.roboto(
                    fontSize: 18,
                    color: Colors.black,
                  ),),
                ),
                Container(
                  margin: const EdgeInsets.only(top: 20,left: 10),
                  child: Text(T.actorDetails.biography ?? "",style: GoogleFonts.roboto(
                    fontSize: 18,
                    color: Colors.black,
                  ),),
                ),
                Container(
                  margin: const EdgeInsets.only(top: 20,left: 10),
                  child: Text(showinfo,style: GoogleFonts.roboto(
                    fontSize: 18,
                    color: Colors.black,
                  ),),
                ),
                SizedBox(
                  height: 200,
                  child: T.hisFamousSeries.isEmpty
                      ? const Center(
                    child: CircularProgressIndicator(),)
                      : ListView.builder(
                      scrollDirection: Axis.horizontal,
                      itemCount: T.hisFamousSeries.length,
                      itemBuilder: (BuildContext context,index) {
                        return InkWell(
                          onTap: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) =>
                                    SeriesDetailsScreen(
                                        id: T.hisFamousSeries[index].id!),
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
                                  "https://image.tmdb.org/t/p/w500${T.hisFamousSeries[index].posterPath}",
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
                                          T.hisFamousSeries[index].title ?? "unKnown",
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
              ],
            );
          }

     }
    )
    );
  }
}
