
import 'package:easy_splash_screen/easy_splash_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_native_splash/flutter_native_splash.dart';
import 'package:provider/provider.dart';
import 'package:secondtest/provider/GetAllMoviesDataProvider.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:secondtest/ulti/module.dart';
import 'package:secondtest/welcome_screen.dart';
import 'package:secondtest/simple_bloc_observer.dart';
import 'package:secondtest/ulti/sharePref.dart';
import 'bloc/all_movies/all_movies_bloc.dart';
import 'bloc/all_movies/all_movies_event.dart';


void main()  {
  inject();
  Bloc.observer = const SimpleBlocObserver();
  WidgetsBinding widgetsBinding = WidgetsFlutterBinding.ensureInitialized();
  FlutterNativeSplash.preserve(widgetsBinding: widgetsBinding);

  runApp(MultiProvider(providers: [
      BlocProvider(
      create: (BuildContext context) => AllMoviesBloc()..add(InitEvent())),
    // ListenableProvider<GetAllBookProvider>(create: (_) => GetAllBookProvider()),
    ListenableProvider<GetAllMoviesDataProvider>(create: (_) => GetAllMoviesDataProvider(getIt.call())),
  ],
    child:  const MyHomePage(),
  )
  );
}

class GetAllBookProvider {
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({Key? key}) : super(key: key);

  @override
  State<MyHomePage> createState() => _MyHomePageState();

  static void setLocal(BuildContext context,String lang){
    _MyHomePageState? state= context.findAncestorStateOfType<_MyHomePageState>();
    state?.setLocal(lang);
  }
}

class _MyHomePageState extends State<MyHomePage> with SingleTickerProviderStateMixin {
   String language='';

  @override
  void initState()  {
    super.initState();
      getLanguage().then((value) {
        setState(() {
            WidgetsFlutterBinding.ensureInitialized();
            FlutterNativeSplash.remove();
          language=value;
        });
      });
  }

  setLocal(String lang){
      setState(() {
        language=lang;
      });
  }

  @override
  Widget build(BuildContext context) {
    return language.isEmpty
        ?   MaterialApp(
         home: EasySplashScreen(
           logo: Image.network(
               'https://cdn4.iconfinder.com/data/icons/logos-brands-5/24/flutter-512.png'),
           title: const Text(
             "Welcome",
             style: TextStyle(
               fontSize: 18,
               fontWeight: FontWeight.bold,
             ),
           ),
           backgroundColor: Colors.grey.shade400,
           showLoader: true,
           loadingText: const Text("Loading..."),
         ),
      )
      : MaterialApp(
             debugShowCheckedModeBanner: false,
            localizationsDelegates: AppLocalizations.localizationsDelegates,
            supportedLocales: AppLocalizations.supportedLocales,
            locale: Locale(language, ''),
             home: const WelcomeWidget()
          );
        }
}