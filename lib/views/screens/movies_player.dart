import 'package:chewie/chewie.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:gracetech_task/models/movies_model.dart';
import 'package:video_player/video_player.dart';

class MoviesPlayer extends StatefulWidget {
  final List<Video> videoModel;
  int currentIndex;

  MoviesPlayer({Key? key, required this.videoModel, required this.currentIndex})
      : super(key: key);

  @override
  State<MoviesPlayer> createState() => _MoviesPlayerState();
}

class _MoviesPlayerState extends State<MoviesPlayer> {
  late VideoPlayerController videoPlayerController;
  late ChewieController chewieController;

  @override
  void initState() {
    super.initState();
  }

  @override
  void didChangeDependencies() async {
    //initialize video player
    playVideo(widget.videoModel[widget.currentIndex]);

    super.didChangeDependencies();
  }

  @override
  void dispose() {
    super.dispose();

    //Dispose the controller to release the resources
    videoPlayerController.dispose();
    chewieController.dispose();
  }

  //play the video
  playVideo(Video model) {
    videoPlayerController = VideoPlayerController.network(model.sources.first);
    chewieController = ChewieController(
      videoPlayerController: videoPlayerController,
      autoPlay: true,
      autoInitialize: true,
      aspectRatio: 16 / 9,
      looping: true,
    );
    setState(() {});
  }

  //play the next video in the list
  playNext() async {
    if (widget.currentIndex < widget.videoModel.length) {
      await chewieController.pause();
      playVideo(widget.videoModel[++widget.currentIndex]);
    }
  }

  //play the previous video in the list
  playPrev() async {
    if (widget.currentIndex > 0) {
      await chewieController.pause();
      playVideo(widget.videoModel[--widget.currentIndex]);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: Column(
        children: [
          //video Widget
          Container(
            height: 0.3.sh,
            width: 1.sw,
            color: Colors.black,
            child: Chewie(
              controller: chewieController,
            ),
          ),
          Expanded(
            child: ListView(
              physics: const BouncingScrollPhysics(),
              children: [
                //Video Title Widget
                Padding(
                  padding: EdgeInsets.all(20.sp),
                  child: Align(
                    alignment: Alignment.centerLeft,
                    child: Text(
                      widget.videoModel[widget.currentIndex].title,
                      style: TextStyle(
                          fontSize: 16.sp, fontWeight: FontWeight.bold),
                    ),
                  ),
                ),

                //Video Description Widget
                Padding(
                  padding: EdgeInsets.all(20.sp),
                  child: Align(
                    alignment: Alignment.centerLeft,
                    child: Text(
                      widget.videoModel[widget.currentIndex].description,
                      style: TextStyle(fontSize: 13.sp, color: Colors.grey),
                    ),
                  ),
                )
              ],
            ),
          )
        ],
      ),

      // Previous and Next Button in the Bottom Navigation
      bottomNavigationBar: SizedBox(
        height: 90.h,
        child: Padding(
          padding: EdgeInsets.all(10.sp),
          child: Row(
            children: [
              //Button to trigger the playPrev method
              Expanded(
                child: MaterialButton(
                  color: Colors.blue,
                  textColor: Colors.white,
                  onPressed: playPrev,
                  child: const Text("Previous"),
                ),
              ),
              SizedBox(
                width: 10.w,
              ),

              //button to play trigger the playNext method
              Expanded(
                child: MaterialButton(
                  color: Colors.blue,
                  textColor: Colors.white,
                  onPressed: playNext,
                  child: const Text("Next"),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
