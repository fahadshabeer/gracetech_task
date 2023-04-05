part of 'fetch_videos_cubit.dart';

abstract class FetchVideosState {}

class FetchVideosInitial extends FetchVideosState {}

class FetchVideosLoading extends FetchVideosState {}

class FetchVideosLoaded extends FetchVideosState {
  MoviesModel movies;

  FetchVideosLoaded({required this.movies});
}

class FetchVideosError extends FetchVideosState {
  String err;

  FetchVideosError({required this.err});
}
