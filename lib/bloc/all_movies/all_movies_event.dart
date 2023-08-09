
import 'package:equatable/equatable.dart';

abstract class AllMoviesEvent extends Equatable {
  const AllMoviesEvent();
}

class InitEvent extends AllMoviesEvent {
  @override
  List<Object?> get props => [];
}

class Reload extends AllMoviesEvent {
  const Reload(this.page);

  final int page;
  @override
  List<Object?> get props => [];
}