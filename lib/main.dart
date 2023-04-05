import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:gracetech_task/controllers/cubits/fetch_video_cubit/fetch_videos_cubit.dart';
import 'package:gracetech_task/views/screens/movies_screen.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return ScreenUtilInit(
        minTextAdapt: true,
        designSize: const Size(375, 812),
        builder: (context, child) {
          return MultiBlocProvider(
            providers: [
              BlocProvider(create: (context) => FetchVideosCubit()),
            ],
            child: const MaterialApp(
              home: MoviesScreen(),
            ),
          );
        });
  }
}
