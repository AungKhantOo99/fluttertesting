


import 'package:flutter/material.dart';
import 'package:secondtest/main.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:secondtest/screen/ProviderPattern/drawerItems/general/generalscreen.dart';
import 'package:secondtest/screen/ProviderPattern/drawerItems/movies/moviesscreen.dart';
import 'package:secondtest/screen/ProviderPattern/drawerItems/series/seriescreen.dart';
import 'package:secondtest/ulti/sharePref.dart';

class MoviesMainScreen extends StatefulWidget {
  const MoviesMainScreen({Key? key}) : super(key: key);

  @override
  State<MoviesMainScreen> createState() => _MoviesMainScreenState();
}

class _MoviesMainScreenState extends State<MoviesMainScreen> {
  String _currentScreen = 'Home';

  void _changeScreen(String screen) {
    setState(() {
      _currentScreen = screen;
    });
    Navigator.pop(context); // Close the drawer after selecting a screen
  }

  @override
  Widget build(BuildContext context) {
    String title='';
    Widget mainContent;
    if (_currentScreen == 'Home') {
      mainContent =   const GeneralScreen();
      title=AppLocalizations.of(context)!.home;
    } else if (_currentScreen == 'Movies') {
      mainContent = const MoviesScreen();
      title=AppLocalizations.of(context)!.movies;
    } else if (_currentScreen == 'Series') {
      mainContent = const SeriesScreen();
      title=AppLocalizations.of(context)!.series;
    }  else {
      mainContent = const Center(child: Text('Invalid Screen'));
    }
    return Scaffold(
      appBar: AppBar(
        title:  Text(title.toString()),
        centerTitle: true,
        actions: [
          IconButton(
            icon: const Icon(Icons.language),
            onPressed: () {
              getLanguage().then((value) {
                print("From click $value");
                if(value=='en'){
                   MyHomePage.setLocal(context,"my");
                  saveLanguage('my');
                }else{
                   MyHomePage.setLocal(context,"en");
                  saveLanguage('en');
                }
              }
              );

            },
          ),
        ],
      ),
      drawer: Drawer(
        child: ListView(
          padding: EdgeInsets.zero,
          children: <Widget>[
             DrawerHeader(
              decoration: const BoxDecoration(
                color: Colors.blue,
              ),
              child: Text(
                  AppLocalizations.of(context)!.drawerTitle,
                 style: const TextStyle(color: Colors.white, fontSize: 18),
              ),
            ),
            ListTile(
              leading: const Icon(Icons.home),
              title:  Text(AppLocalizations.of(context)!.home),
              onTap: () {
                _changeScreen('Home');
              },
            ),
            ListTile(
              leading: const Icon(Icons.movie_creation),
              title:  Text(AppLocalizations.of(context)!.movies),
              onTap: () {
                _changeScreen('Movies');
              },
            ),
            ListTile(
              leading: const Icon(Icons.video_collection_outlined),
              title:  Text(AppLocalizations.of(context)!.series),
              onTap: () {
                _changeScreen('Series');
              },
            ),
            // Add more ListTile widgets for additional menu items
          ],
        ),
      ),
      body: mainContent,
    );
  }
}



