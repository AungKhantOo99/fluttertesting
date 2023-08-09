import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import 'package:secondtest/screen/ProviderPattern/drawerItems/TabBarItems.dart';


import '../../../../provider/GetAllMoviesDataProvider.dart';



class MoviesScreen extends StatefulWidget {
  const MoviesScreen({Key? key}) : super(key: key);

  @override
  State<MoviesScreen> createState() => _MoviesScreen();
}

class _MoviesScreen extends State<MoviesScreen> {
  late GetAllMoviesDataProvider allListProvider;
  @override
  Widget build(BuildContext context) {
    allListProvider = Provider.of<GetAllMoviesDataProvider>(context);
    // allListProvider.allCategories.clear();
    allListProvider.fetchAllCategory(true);
    // print(allListProvider.allCategories.toString());
    return Scaffold(
      body: allListProvider.allMoviesCategories.isEmpty
          ? const Center(
        child: CircularProgressIndicator(),
      )
          : Container(
        color: Colors.brown,
        child: DefaultTabController(
          length: allListProvider.allMoviesCategories.length,
          child: Column(
            children: [
              Container(
                height: 30,
                margin: const EdgeInsets.only(top: 5),
                child: TabBar(
                  unselectedLabelColor: Colors.white,
                  labelColor: Colors.black,
                  indicatorSize: TabBarIndicatorSize.tab,
                  indicator: BoxDecoration(
                      gradient: const LinearGradient(colors: [
                        Colors.redAccent,
                        Colors.orangeAccent
                      ]),
                      borderRadius: BorderRadius.circular(10),
                      color: Colors.redAccent),
                  isScrollable: true,
                  tabs: List.generate(
                    allListProvider.allMoviesCategories.length,
                        (index) => Tab(
                        child: Container(
                          margin: const EdgeInsets.all(5),
                          child: Text(
                            allListProvider.allMoviesCategories[index].name!,
                            style: GoogleFonts.spaceMono(
                              fontWeight: FontWeight.w500,
                              fontSize: 12,
                            ),
                          ),
                        )),
                  ),
                ),
              ),
              Expanded(
                child: TabBarView(
                  children: allListProvider.allMoviesCategories.map((e) => TabBarItems(isMovies: true,id: e.id!,)).toList(),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

}