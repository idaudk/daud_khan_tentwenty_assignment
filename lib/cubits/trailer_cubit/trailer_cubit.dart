import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:movie_db_app/data/remote/base_api_service.dart';
import 'package:movie_db_app/repo/movies/movies_repo_impl.dart';
import 'package:video_player/video_player.dart';
import 'package:youtube_player_flutter/youtube_player_flutter.dart';

part 'trailer_state.dart';

class TrailerCubit extends Cubit<TrailerState> {
  final int movieId;
  // VideoPlayerController? videoController;
  YoutubePlayerController? youtubePlayerController;
  final MoviesRepoImpl _moviesRepoImpl = MoviesRepoImpl();

  TrailerCubit({required this.movieId}) : super(TrailerInitial()) {
    getTrailer(movieId: movieId);
  }

  @override
  Future<void> close() {
    youtubePlayerController!.dispose();
    return super.close();
  }

  getTrailer({required int movieId}) async {
    emit(TrailerLoading());
    final response = await _moviesRepoImpl.getMovieTrailer(movieId: movieId);
    response.fold((l) {
      emit(TrailerFailed());
    }, (r) async {
      print(BaseApiService.trailerBaseUrl + r.results![0].key.toString());
      // videoController = VideoPlayerController.networkUrl(
      //     Uri.parse('https://www.youtube.com/watch?v=PCDRFz9jhLc'));
      // print('Video Metadata: ${videoController!.value}');
      // await videoController!.initialize();
      // print('Video Metadata: ${videoController!.value}');

      youtubePlayerController = YoutubePlayerController(
          initialVideoId: r.results![0].key.toString(),
          flags: const YoutubePlayerFlags(autoPlay: true, mute: false));
      emit(TrailerLoaded(youtubePlayerController: youtubePlayerController!));
    });
  }
}
