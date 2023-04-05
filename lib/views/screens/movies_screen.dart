import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:gracetech_task/controllers/cubits/fetch_video_cubit/fetch_videos_cubit.dart';
import 'package:gracetech_task/views/custom_widegts/movie_card.dart';

class MoviesScreen extends StatefulWidget {
  const MoviesScreen({Key? key}) : super(key: key);

  @override
  State<MoviesScreen> createState() => _MoviesScreenState();
}

class _MoviesScreenState extends State<MoviesScreen> {
  @override
  void initState() {
    //starts fetching the video links from url
    context.read<FetchVideosCubit>().fetchVideos();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Movies"),
      ),
      body: BlocBuilder<FetchVideosCubit, FetchVideosState>(
        builder: (context, state) {
          //show loading to user if the videos are in fetching state
          if (state is FetchVideosLoading) {
            return const Center(
              child: CircularProgressIndicator(),
            );
          }
          //show error and retry button to user
          // if due to some reason request failed to fetch the videos
          if (state is FetchVideosError) {
            return Center(
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  //Display error message here
                  Padding(
                    padding:  EdgeInsets.all(10.sp),
                    child: Text(state.err),
                  ),
                  SizedBox(
                    height: 5.h,
                  ),

                  //Retry Button
                  MaterialButton(
                    color: Colors.blue,
                    textColor: Colors.white,
                    onPressed: () {
                      context.read<FetchVideosCubit>().fetchVideos();
                    },
                    child: const Text("Retry"),
                  )
                ],
              ),
            );
          }
          if (state is FetchVideosLoaded) {
            return GridView.builder(
                itemCount: state.movies.categories.first.videos.length,
                gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 2,
                  childAspectRatio: 0.7,
                ),
                itemBuilder: (context, index) {
                  //Custom Widget to Display the movie name and thumbnail
                  return MovieCard(movies: state.movies, index: index);
                });
          } else {
            return const SizedBox.shrink();
          }
        },
      ),
    );
  }
}
