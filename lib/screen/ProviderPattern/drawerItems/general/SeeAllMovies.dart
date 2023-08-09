
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';


import '../../../../../widgets/AllMoviesItems.dart';
import '../../../../provider/GetAllMoviesDataProvider.dart';

class SeeAllMovies extends StatefulWidget {
  final bool isMovies;
  final String category;
  const SeeAllMovies({Key? key, required this.category, required this.isMovies}) : super(key: key);

  @override
  State<SeeAllMovies> createState() => _SeeAllMoviesState();
}

class _SeeAllMoviesState extends State<SeeAllMovies> {
  final ScrollController _scrollController = ScrollController();
  late int itemcount;

  @override
  void initState() {
    super.initState();
    final dataProvider = Provider.of<GetAllMoviesDataProvider>(context, listen: false);
     dataProvider.moviesData.clear();
    dataProvider.seriesData.clear();
    Future.delayed(Duration.zero, () {
      if(widget.isMovies){
        dataProvider.fetchMoviesMainPage(widget.category, false);
          // itemcount=dataProvider.moviesData.length;

      }else{
        dataProvider.fetchSeriesMainPage(widget.category, false);
        // itemcount=dataProvider.seriesData.length;
      }

    });
    // Listen for scroll events and fetch data when the user reaches the end of the list
    _scrollController.addListener(() {
      if (_scrollController.position.atEdge && _scrollController.position.pixels != 0) {
        if(widget.isMovies){
          dataProvider.fetchMoviesMainPage(widget.category, false);
        }else{
          dataProvider.fetchSeriesMainPage(widget.category, false);
        }
      }
    });
  }
  @override
  Widget build(BuildContext context) {
    final dataProvider = Provider.of<GetAllMoviesDataProvider>(context);

    return Scaffold(
      appBar: AppBar(title: Text(widget.category)),
      body: FutureBuilder(
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          } else {
            if(widget.isMovies){
              itemcount=dataProvider.moviesData.length;
            }else{
              itemcount=dataProvider.seriesData.length;
            }
            return ListView.builder(
              controller: _scrollController,
              itemCount:  itemcount,
              itemBuilder: (context, index) {
                if(widget.isMovies){
                  if (index < dataProvider.moviesData.length) {
                    return AllMoviesItems(
                      isMovies: true,
                      title: dataProvider.moviesData[index].title!,
                      id: dataProvider.moviesData[index].id!,
                      posterPath: dataProvider.moviesData[index].posterPath!,
                      voteAverage: dataProvider.moviesData[index].voteAverage.toString(),);
                  }
                  return null;
                }else{
                  if (index < dataProvider.seriesData.length) {
                    return AllMoviesItems(
                      isMovies: false,
                      title: dataProvider.seriesData[index].name!,
                      id: dataProvider.seriesData[index].id!,
                      posterPath: dataProvider.seriesData[index].posterPath!,
                      voteAverage: dataProvider.seriesData[index].voteAverage.toString(),);
                  }
                  return null;
                }

              },
            );
          }
        },
      ),
    );
  }
}

