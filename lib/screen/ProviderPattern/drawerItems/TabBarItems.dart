import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:secondtest/provider/GetAllMoviesDataProvider.dart';
import 'package:secondtest/widgets/AllMoviesItems.dart';

class TabBarItems extends StatefulWidget {
  final int id;
  final bool isMovies;
  const TabBarItems({Key? key, required this.id, required this.isMovies})
      : super(key: key);
  @override
  State<TabBarItems> createState() => _TabBarItemsState();
}

class _TabBarItemsState extends State<TabBarItems> {
  final ScrollController _scrollController = ScrollController();

  @override
  void initState() {
    super.initState();
    final dataProvider =
        Provider.of<GetAllMoviesDataProvider>(context, listen: false);

    Future.delayed(Duration.zero, () {
      if (widget.isMovies) {
        dataProvider.fetchMoviesDependOnCategory(widget.id);
      } else {
        dataProvider.fetchSeriesDependOnCategory(widget.id);
      }

      // print(dataProvider.moviesData.toString());
    });
    // Listen for scroll events and fetch data when the user reaches the end of the list
    _scrollController.addListener(() {
      if (_scrollController.position.atEdge &&
          _scrollController.position.pixels != 0) {
        if (widget.isMovies) {
          dataProvider.fetchMoviesDependOnCategory(widget.id);
        } else {
          dataProvider.fetchSeriesDependOnCategory(widget.id);
        }
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    final dataProvider = Provider.of<GetAllMoviesDataProvider>(context);

    return Scaffold(
      body: FutureBuilder(
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          } else {
            if (widget.isMovies) {
              return ListView.builder(
                  controller: _scrollController,
                  itemCount: dataProvider.moviesData.length,
                  itemBuilder: (context, index) {
                    if (index < dataProvider.moviesData.length) {
                      return AllMoviesItems(
                        isMovies: true,
                        title: dataProvider.moviesData[index].title!,
                        id: dataProvider.moviesData[index].id!,
                        posterPath: dataProvider.moviesData[index].posterPath!,
                        voteAverage: dataProvider.moviesData[index].voteAverage
                            .toString(),
                      );
                    }
                  });
            } else {
              return ListView.builder(
                  controller: _scrollController,
                  itemCount: dataProvider.seriesData.length,
                  itemBuilder: (context, index) {
                    if (index < dataProvider.seriesData.length) {
                      return AllMoviesItems(
                        isMovies: false,
                        title: dataProvider.seriesData[index].name!,
                        id: dataProvider.seriesData[index].id!,
                        posterPath: dataProvider.seriesData[index].posterPath!,
                        voteAverage: dataProvider.seriesData[index].voteAverage
                            .toString(),
                      );
                    }
                  });
            }
          }
        },
      ),
    );
  }
}
