part of 'trailer_cubit.dart';

sealed class TrailerState extends Equatable {
  const TrailerState();

  @override
  List<Object> get props => [];
}

final class TrailerInitial extends TrailerState {}
final class TrailerLoading extends TrailerState {}
final class TrailerLoaded extends TrailerState {
  String url;
  TrailerLoaded({required this.url});
}
final class TrailerFailed extends TrailerState {}
