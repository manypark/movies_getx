import 'package:flutter/material.dart';
import 'package:get/route_manager.dart';

import 'src/pages/detail_pages.dart';
import 'src/pages/home_pages.dart';

void main() => runApp(const MyApp());

class MyApp extends StatelessWidget {

  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {

    return GetMaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Movies App',
      routes: {
        'details' : (_) => const DetailPages(),
      },
      theme: ThemeData.light().copyWith(
        appBarTheme: const AppBarTheme(
          color: Colors.white12
        ),
      ),
      home: const HomePages()
    );
  }
}