
import 'package:get_it/get_it.dart';
import 'package:secondtest/network/APiServices/api_services.dart';
import 'package:secondtest/provider/GetAllMoviesDataProvider.dart';

final getIt = GetIt.instance;
void inject(){
    ApiService apiService=ApiService();
    getIt.registerLazySingleton(() => apiService);

    GetAllMoviesDataProvider getAllMoviesDataProvider=GetAllMoviesDataProvider(getIt.call());
    getIt.registerLazySingleton(() => getAllMoviesDataProvider);
}
