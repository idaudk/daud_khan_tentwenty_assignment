part of 'home_cubit.dart';

sealed class HomeState extends Equatable {
  const HomeState();

  @override
  List<Object> get props => [];
}

final class HomeInitial extends HomeState {}
final class HomeLoading extends HomeState {}
final class HomeLoaded extends HomeState {
  List<Results> upcomingMovies;
  HomeLoaded({required this.upcomingMovies});
}
final class HomeFailed extends HomeState {}
