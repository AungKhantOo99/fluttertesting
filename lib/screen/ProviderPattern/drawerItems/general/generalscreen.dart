import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import 'package:secondtest/screen/ProviderPattern/drawerItems/general/SeeAllMovies.dart';

import 'package:secondtest/widgets/HorizontalMoviesItems.dart';
import '../../../../../widgets/AllMoviesItems.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

import '../../../../network/model/MoviesModel.dart';
import '../../../../provider/GetAllMoviesDataProvider.dart';

class GeneralScreen extends StatefulWidget {
  const GeneralScreen({Key? key}) : super(key: key);
  @override
  State<GeneralScreen> createState() => _GeneralScreen();
}

class _GeneralScreen extends State<GeneralScreen> {
  final TextEditingController _searchController = TextEditingController();
  final ScrollController _scrollController = ScrollController();
  bool _isSearch = false;
  @override
  void initState() {
    super.initState();
    final dataProvider = Provider.of<GetAllMoviesDataProvider>(context, listen: false);
    dataProvider.moviesData.clear();
    dataProvider.fetchMoviesMainPage('popular',true);
    dataProvider.fetchMoviesMainPage('top_rated',true);
    dataProvider.fetchSeriesMainPage('popular', true);
    dataProvider.fetchSeriesMainPage('top_rated', true);
    _scrollController.addListener(() {
      if (_scrollController.position.atEdge && _scrollController.position.pixels != 0) {
        String searchTerm = _searchController.text.trim();
        dataProvider.fetchSearchMovies(searchTerm,false);
        FocusScope.of(context).unfocus();
      }
    });
  }
  void _performSearch(BuildContext context) {
    String searchTerm = _searchController.text.trim();
    Provider.of<GetAllMoviesDataProvider>(context, listen: false)
        .fetchSearchMovies(searchTerm,true);
    FocusScope.of(context).unfocus();
    setState(() {
      _isSearch=true;
    });
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: WillPopScope(
        onWillPop: () async {
          late bool results;
          if(_isSearch){
            setState(() {
              _isSearch=false;
              _searchController.text="";
              FocusScope.of(context).unfocus();
            });
            results=false;
          }else{
            setState(() {
              results=true;
            });
          }
          return results;
        },
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              margin: const EdgeInsets.only(top: 5, left: 5),
              child: Text(
                AppLocalizations.of(context)!.welcomeText,
                style: GoogleFonts.robotoCondensed(
                  fontSize: 20,
                ),
              ),
            ),
            Container(
              margin: const EdgeInsets.all(3),
              child: Container(
                width: double.infinity,
                alignment: Alignment.center,
                decoration: BoxDecoration(
                  border: Border.all(width: 1, color: Colors.grey),
                  borderRadius: BorderRadius.circular(10),
                ),
                child: TextFormField(
                  controller: _searchController,
                  onEditingComplete: () => _performSearch(context),
                  decoration:  InputDecoration(
                    hintText: AppLocalizations.of(context)!.hint,
                    suffixIcon: const Icon(Icons.search),
                    border: InputBorder.none,
                    contentPadding: const EdgeInsets.all(10),
                  ),
                ),
              ),
            ),
            Expanded(
              child: Consumer<GetAllMoviesDataProvider>(
                builder: (context, dataProvider, child) {
                   List<Results> data = dataProvider.moviesData;
                  if(!_isSearch){
                      return ListView(
                        children: [
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children:[
                              Text(AppLocalizations.of(context)!.popular,style: GoogleFonts.merriweather(
                                fontSize: 16,
                              )),
                              InkWell(
                                onTap: () {
                                  Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                      builder: (context) =>
                                          const SeeAllMovies(category: "popular",isMovies: true),
                                    ),
                                  );
                                },
                                child: Text(AppLocalizations.of(context)!.seeAll,style: GoogleFonts.roboto(
                                  fontSize: 14,
                                )),
                              ),
                                 ]
                          ),
                          SizedBox(
                            height: 200,
                            child: dataProvider.popularMoviesData.isEmpty
                                ? const Center(
                              child: CircularProgressIndicator(),)
                                : ListView.builder(
                                scrollDirection: Axis.horizontal,
                                itemCount: dataProvider.popularMoviesData.length,
                                itemBuilder: (BuildContext context,index) {
                                  return HorizontalMoviesItems(
                                      isMovies: true,
                                      id: dataProvider.popularMoviesData[index].id!,
                                      posterPath: dataProvider.popularMoviesData[index].posterPath!,
                                      title: dataProvider.popularMoviesData[index].title!,
                                      voteAverage: dataProvider.popularMoviesData[index].voteAverage.toString()
                                  );
                                }),
                          ),
                          Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children:[
                                Text(AppLocalizations.of(context)!.topRate,style: GoogleFonts.merriweather(
                                  fontSize: 16,
                                )),
                                InkWell(
                                  onTap: () {
                                    Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                        builder: (context) =>
                                        const SeeAllMovies(category: "top_rated",isMovies: true),
                                      ),
                                    );
                                  },
                                  child: Text(AppLocalizations.of(context)!.seeAll,style: GoogleFonts.roboto(
                                    fontSize: 14,
                                  )),
                                ),
                              ]
                          ),
                          SizedBox(
                            height: 200,
                            child: dataProvider.topRateMoviesData.isEmpty
                                ? const Center(
                              child: CircularProgressIndicator(),)
                                : ListView.builder(
                                scrollDirection: Axis.horizontal,
                                itemCount: dataProvider.topRateMoviesData.length,
                                itemBuilder: (BuildContext context,index) {
                                  return HorizontalMoviesItems(
                                      isMovies: true,
                                      id: dataProvider.topRateMoviesData[index].id!,
                                      posterPath: dataProvider.topRateMoviesData[index].posterPath!,
                                      title: dataProvider.topRateMoviesData[index].title!,
                                      voteAverage: dataProvider.topRateMoviesData[index].voteAverage.toString()
                                  );
                                }),
                          ),
                          Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children:[
                                Text(AppLocalizations.of(context)!.popularSeries,style: GoogleFonts.merriweather(
                                  fontSize: 16,
                                )),
                                InkWell(
                                  onTap: () {
                                    Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                        builder: (context) =>
                                        const SeeAllMovies(category: "popular",isMovies: false),
                                      ),
                                    );
                                  },
                                  child: Text(AppLocalizations.of(context)!.seeAll,style: GoogleFonts.roboto(
                                    fontSize: 14,
                                  )),
                                ),
                              ]
                          ),
                          SizedBox(
                            height: 200,
                            child: dataProvider.popularSeriesData.isEmpty
                                ? const Center(
                              child: CircularProgressIndicator(),)
                                : ListView.builder(
                                scrollDirection: Axis.horizontal,
                                itemCount: dataProvider.popularSeriesData.length,
                                itemBuilder: (BuildContext context,index) {
                                  return HorizontalMoviesItems(
                                      isMovies: false,
                                      id: dataProvider.popularSeriesData[index].id!,
                                      posterPath: dataProvider.popularSeriesData[index].posterPath!,
                                      title: dataProvider.popularSeriesData[index].name!,
                                      voteAverage: dataProvider.popularSeriesData[index].voteAverage.toString()
                                  );
                                }),
                          ),
                          Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children:[
                                Text(AppLocalizations.of(context)!.topRateSeries,style: GoogleFonts.merriweather(
                                  fontSize: 16,
                                )),
                                InkWell(
                                  onTap: () {
                                    Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                        builder: (context) =>
                                        const SeeAllMovies(category: "top_rated",isMovies: false),
                                      ),
                                    );
                                  },
                                  child: Text(AppLocalizations.of(context)!.seeAll,style: GoogleFonts.roboto(
                                    fontSize: 14,
                                  )),
                                ),
                              ]
                          ),
                          SizedBox(
                            height: 200,
                            child: dataProvider.topRateSeriesData.isEmpty
                                ? const Center(
                              child: CircularProgressIndicator(),)
                                : ListView.builder(
                                scrollDirection: Axis.horizontal,
                                itemCount: dataProvider.topRateSeriesData.length,
                                itemBuilder: (BuildContext context,index) {
                                  return HorizontalMoviesItems(
                                      isMovies: false,
                                      id: dataProvider.topRateSeriesData[index].id!,
                                      posterPath: dataProvider.topRateSeriesData[index].posterPath ?? "",
                                      title: dataProvider.topRateSeriesData[index].name!,
                                      voteAverage: dataProvider.topRateSeriesData[index].voteAverage.toString() ?? "0.0"
                                  );
                                }),
                          )
                        ],
                      );
                  }
                  else {
                    if(data.isEmpty){
                      return const Center(
                        child: CircularProgressIndicator()
                      );
                    }else{
                      return ListView.builder(
                        controller: _scrollController,
                        itemCount: data.length,
                        itemBuilder: (context, index) {
                          return AllMoviesItems(
                            isMovies: true,
                            title: data[index].title!,
                            id: data[index].id!,
                            posterPath: data[index].posterPath ?? "https://images.pexels.com/photos/1353126/pexels-photo-1353126.jpeg?auto=compress&cs=tinysrgb&w=600",
                            voteAverage: "${data[index].voteAverage}",);
                        }
                      );
                    }
                  }
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
