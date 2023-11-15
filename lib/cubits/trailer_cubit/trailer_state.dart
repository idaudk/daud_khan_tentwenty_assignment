part of 'trailer_cubit.dart';

sealed class TrailerState extends Equatable {
  const TrailerState();

  @override
  List<Object> get props => [];
}

final class TrailerInitial extends TrailerState {}

final class TrailerLoading extends TrailerState {}

final class TrailerLoaded extends TrailerState {
  YoutubePlayerController youtubePlayerController;
  TrailerLoaded({required this.youtubePlayerController});
  // VideoPlayerController videoPlayerController;
  // TrailerLoaded({required this.videoPlayerController});
}
final class TrailerFailed extends TrailerState {}
// final class TrailerPlaying extends TrailerState {}
// final class TrailerFinished extends TrailerState {}
