import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import 'package:flutter_gen/gen_l10n/app_localizations.dart';

import '../bloc/all_movies/all_movies_view.dart';
import 'screen/ProviderPattern/moviesmain.dart';



class WelcomeWidget extends StatelessWidget {

  const WelcomeWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Column(
          children: [
            Expanded(
              child: Center(
                child: Image.asset(
                  'assets/welcome.jpg',
                  fit: BoxFit.cover,
                ),
              ),
            ),
            Expanded(
              child: Center(
                child: Column(
                  // mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Container(
                      margin: const EdgeInsets.only(top: 10),
                      child: Text(AppLocalizations.of(context)!.startTitle,style: GoogleFonts.adamina(
                        fontSize: 20,
                        fontWeight: FontWeight.bold
                      ),),
                    ),
                    Container(
                        margin: const EdgeInsets.only(top: 15),
                        child:  Center(
                          child: Text(AppLocalizations.of(context)!.startContent,
                            style: GoogleFonts.chivoMono(),
                            textAlign: TextAlign.center),
                        )
                    )
                  ],
                ),
              ),
            ),
            Expanded(
              child: Center(
                child: Column(
                  // mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Container(
                      width: double.infinity,
                      height: 42,
                      margin: const EdgeInsets.all(15),
                      child: ElevatedButton(
                          onPressed: (){
                            Navigator.push(
                              context,
                              MaterialPageRoute(builder: (context) => const AllMoviesPage()),
                            );
                          },
                          style: ElevatedButton.styleFrom(
                            backgroundColor: Colors.blue, // Background color
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(20), // Border radius
                            ),
                          ),
                          child:Text(AppLocalizations.of(context)!.forBook,style: GoogleFonts.arbutusSlab(
                              color: Colors.black,
                              fontWeight: FontWeight.w600,
                            fontSize: 13
                          )),
                          )
                    ),
                    Container(
                        width: double.infinity,
                        height: 42,
                        margin: const EdgeInsets.all(15),
                        child: ElevatedButton(
                          onPressed: (){
                            // MyHomePage.setLocal(context, Locale('my',''));
                            Navigator.push(
                              context,
                              MaterialPageRoute(builder: (context) =>  const MoviesMainScreen()),
                            );
                          },
                          style: ElevatedButton.styleFrom(
                            backgroundColor: Colors.white, // Transparent background
                            // Black border color
                            side: const BorderSide(color: Colors.black, width: 1),
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(20), // Border radius
                            ),
                          ),
                          child: Text(AppLocalizations.of(context)!.forMovies,style: GoogleFonts.arbutusSlab(
                            color: Colors.black,
                            fontWeight: FontWeight.w600,
                            fontSize: 13
                          )),
                        )
                    )
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

