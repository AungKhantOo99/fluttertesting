
import 'package:equatable/equatable.dart';

import '../../network/model/MoviesModel.dart';
abstract class AllMoviesState extends Equatable {
  const AllMoviesState();

  @override
  List<Object> get props => [];
}

 class AllMoviesLoading extends AllMoviesState {}

 class AllMoviesLoaded extends AllMoviesState {
  const AllMoviesLoaded(this.data);

  final List<Results> data;


  @override
  List<Object> get props => [data];
}

 class AllMoviesError extends AllMoviesState {
   const AllMoviesError(this.wrong);

   final String wrong;

   //
   // @override
   // List<Object> get props => [wrong];
 }
