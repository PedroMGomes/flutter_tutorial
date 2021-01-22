import 'package:flutter/material.dart';
import 'package:flutter_tutorial/widgets/infinite_list.dart' show InfiniteList;
import 'package:google_fonts/google_fonts.dart' show GoogleFonts;

void main() => runApp(MyApp());

/// [MyApp].
class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Infinite Scroll',
      theme: ThemeData(
        primarySwatch: Colors.blue,
        appBarTheme: AppBarTheme(
          elevation: 8.0,
          brightness: Brightness.dark,
          shadowColor: Colors.blueGrey,
        ),
        platform: TargetPlatform.android,
        fontFamily: GoogleFonts.workSans().fontFamily,
        visualDensity: VisualDensity.adaptivePlatformDensity,
      ),
      home: Scaffold(
        // appBar: AppBar(title: const Text('Infinite List')),
        body: SafeArea(child: Center(child: InfiniteList())),
      ),
    );
  }
}
