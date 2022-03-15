import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:wiki_movie/controller/genre_controller.dart';
import 'package:wiki_movie/controller/movie_controller.dart';
import 'package:wiki_movie/views/home_screen.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      title: 'MovieDb',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
          primarySwatch: Colors.red,
          scaffoldBackgroundColor: Colors.white,
          colorScheme: ColorScheme.light()),
      home: HomeScreen(),
      themeMode: ThemeMode.system,
      darkTheme: ThemeData(
          primarySwatch: Colors.red,
          scaffoldBackgroundColor: Colors.black,
          colorScheme: ColorScheme.dark()),
      initialBinding: BindingsBuilder(() {
        Get.lazyPut(() => MovieController());
        Get.lazyPut(() => GenreController());
      }),
    );
  }
}
