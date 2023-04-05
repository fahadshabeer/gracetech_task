import 'dart:io';

import 'package:bloc/bloc.dart';
import 'package:gracetech_task/controllers/data_controllers/fetch_videos_controller.dart';
import 'package:gracetech_task/models/movies_model.dart';
import 'package:gracetech_task/utils/repositories/fetch_videos_repositories.dart';
import 'package:http/http.dart';

part 'fetch_videos_state.dart';

class FetchVideosCubit extends Cubit<FetchVideosState> {
  FetchVideosCubit() : super(FetchVideosInitial());

  fetchVideos() async {
    try {
      emit(FetchVideosLoading());
      var res = await FetchVideosRepo.fetchVideos();
      emit(FetchVideosLoaded(movies: FetchVideosController.controller!));
    } catch (e) {
      if (e is ClientException) {
        emit(FetchVideosError(err: e.message));
      }
      if (e is SocketException) {
        emit(FetchVideosError(err: "No internet"));
      } else {
        emit(FetchVideosError(err: e.toString()));
      }
    }
  }
}
