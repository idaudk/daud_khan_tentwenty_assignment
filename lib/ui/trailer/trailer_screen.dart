import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:movie_db_app/cubits/trailer_cubit/trailer_cubit.dart';
import 'package:movie_db_app/ui/resources/resources.dart';
import 'package:movie_db_app/ui/widgets/gap/gap.dart';
import 'package:video_player/video_player.dart';
import 'package:youtube_player_flutter/youtube_player_flutter.dart';

class TrailerScreen extends StatelessWidget {
  const TrailerScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: ColorManager.black,
      body: BlocListener<TrailerCubit, TrailerState>(
        listener: (context, state) {
          if (state is TrailerLoaded) {}
        },
        child: BlocBuilder<TrailerCubit, TrailerState>(
          builder: (context, state) {
            if (state is TrailerLoading) {
              return const Center(
                child: CircularProgressIndicator(),
              );
            } else if (state is TrailerFailed) {
              return const Center(
                  child: Icon(
                CupertinoIcons.xmark_octagon,
                color: ColorManager.error,
              ));
            } else if (state is TrailerLoaded) {
              return Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Center(
                      child: YoutubePlayer(
                          controller: state.youtubePlayerController)),
                  Padding(
                    padding: const EdgeInsets.all(24),
                    child: ElevatedButton(
                        onPressed: () {
                          Navigator.pop(context);
                        },
                        child: const Text('Done')),
                  )
                ],
              );
            } else {
              return SizedBox.shrink();
            }
          },
        ),
      ),
    );
  }
}
