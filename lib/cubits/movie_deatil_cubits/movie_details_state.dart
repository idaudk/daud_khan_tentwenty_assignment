part of 'movie_details_cubit.dart';

sealed class MovieDetailsState extends Equatable {
  const MovieDetailsState();

  @override
  List<Object> get props => [];
}

final class MovieDetailsInitial extends MovieDetailsState {}
final class MovieDetailsLoading extends MovieDetailsState {}
final class MovieDetailsLoaded extends MovieDetailsState {
  MovieDetail movieDetail;
  MovieDetailsLoaded({required this.movieDetail});
}
final class MovieDetailsFailed extends MovieDetailsState {}
