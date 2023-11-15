import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:movie_db_app/repo/movies/movies_repo_impl.dart';

part 'trailer_state.dart';

class TrailerCubit extends Cubit<TrailerState> {
  final int movieId;
  final MoviesRepoImpl _moviesRepoImpl = MoviesRepoImpl();


  TrailerCubit({required this.movieId}) : super(TrailerInitial());

  getTrailer({required int movieId}){

  }
}
