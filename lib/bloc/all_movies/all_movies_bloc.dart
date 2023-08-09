
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:secondtest/network/model/MoviesModel.dart';
import '../../screen/BlocPattern/data/MoviesRepo.dart';
import 'all_movies_event.dart';
import 'all_movies_state.dart';

class AllMoviesBloc extends Bloc<AllMoviesEvent, AllMoviesState> {

   List<Results> allData=[];

  AllMoviesBloc() : super(AllMoviesLoading()) {
    on<InitEvent>(start);
    on<Reload>(reload);
  }

  Future<void> start(
      InitEvent event,
      Emitter<AllMoviesState> emit,
      ) async {
    emit(AllMoviesLoading());
    try {
      await MoviesRepo().fetchMoviesMainPage(1).then((value) {
        allData.addAll(value);
        emit(AllMoviesLoaded(allData));
      }).catchError((e) {
        emit(AllMoviesError(e.toString()));
      });
    } catch (e) {
        emit(AllMoviesError(e.toString()));
    }
  }

  Future<void> reload(
      Reload event,
      Emitter<AllMoviesState> emit,
      ) async {
    emit(AllMoviesLoading());
    try {
     await MoviesRepo().fetchMoviesMainPage(event.page).then((value) {
          allData.addAll(value);
          emit(AllMoviesLoaded(allData));
      }).catchError((e) {
        emit(AllMoviesError(e.toString()));
      });
    } catch (e) {
       emit(AllMoviesError(e.toString()));
    }
  }
}
