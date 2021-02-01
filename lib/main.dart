import 'package:flutter/material.dart';
import 'package:flutter_tutorial/pages/home_page.dart' show HomePage;
import 'package:flutter_tutorial/providers/posts_provider.dart'
    show PostsProvider;
import 'package:google_fonts/google_fonts.dart' show GoogleFonts;
import 'package:provider/provider.dart';

void main() => runApp(MyApp());

/// [MyApp].
class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final fontFamily = GoogleFonts.workSans().fontFamily;
    return Provider(
      // Instance is accessible by all descendants in the widget tree.
      create: (_) => PostsProvider(),
      child: MaterialApp(
        title: 'Flutter Tutorial',
        theme: ThemeData(
          fontFamily: fontFamily,
          primarySwatch: Colors.blue,
          appBarTheme: AppBarTheme(
            elevation: 8.0,
            brightness: Brightness.dark,
            shadowColor: Colors.blueGrey,
          ),
          snackBarTheme: SnackBarThemeData(
              contentTextStyle: TextStyle(fontFamily: fontFamily)),
          platform: TargetPlatform.android,
          visualDensity: VisualDensity.adaptivePlatformDensity,
        ),
        home: HomePage(),
      ),
    );
  }
}
