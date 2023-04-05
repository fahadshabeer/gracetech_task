import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:gracetech_task/models/movies_model.dart';
import 'package:gracetech_task/utils/api_manager.dart';
import 'package:gracetech_task/views/screens/movies_player.dart';

class MovieCard extends StatelessWidget {
  final MoviesModel movies;
  final int index;

  const MovieCard({Key? key, required this.movies, required this.index})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        Navigator.push(
            context,
            MaterialPageRoute(
                builder: (context) => MoviesPlayer(
                      videoModel: movies.categories.first.videos,
                      currentIndex: index,
                    )));
      },
      child: Card(
        child: Column(
          children: [
            Expanded(
              flex: 3,
              child: ClipRRect(
                borderRadius: BorderRadius.circular(5.sp),
                child: CachedNetworkImage(
                  placeholder: (context, url) => const Center(
                    child: CircularProgressIndicator(),
                  ),
                  fit: BoxFit.fill,
                  imageUrl: ApiManager.imagesBaseUrl +
                      movies.categories.first.videos[index].thumb,
                ),
              ),
            ),
            Expanded(
              child: Padding(
                padding: EdgeInsets.all(5.sp),
                child: Align(
                  alignment: Alignment.centerLeft,
                  child: Text(
                    movies.categories.first.videos[index].title,
                    maxLines: 2,
                    overflow: TextOverflow.ellipsis,
                    style: TextStyle(fontSize: 14.sp),
                  ),
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
