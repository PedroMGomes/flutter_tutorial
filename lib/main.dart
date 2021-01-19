import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart' show GoogleFonts;
import 'package:infinite_scroll/models/post.dart' show Post;
import 'package:infinite_scroll/post_widget.dart' show PostWidget;
import 'dart:developer' as developer;

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
        appBar: AppBar(title: const Text('Infinite List')),
        body: SafeArea(child: Center(child: InfiniteList())),
      ),
    );
  }
}

/// [InfiniteList].
class InfiniteList extends StatefulWidget {
  InfiniteList({Key key}) : super(key: key);

  @override
  _InfiniteListState createState() => _InfiniteListState();
}

/// [_InfiniteListState].
class _InfiniteListState extends State<InfiniteList> {
  final List<Post> _postList = [];
  ScrollController _scrollController = ScrollController();

  /// Last List View Max Extent value.
  double _lastMaxExtent = 0.0;

  /// init.
  @override
  void initState() {
    super.initState();
    this._postList.addAll(
          List<Post>.generate(
            20,
            (index) => Post.fake(),
            growable: false,
          ),
        );
    this._scrollController = ScrollController()
      ..addListener(() {
        // N pixels to offset ListView children on the opposite direction.
        final currentPos = this._scrollController.position.pixels;
        // Maximum in-range value for pixels.
        final maxExtent = this._scrollController.position.maxScrollExtent;
        if (this._lastMaxExtent != maxExtent &&
            currentPos >= (maxExtent * 0.8)) {
          // Adding new elements to the List and updating this widget state.
          setState(() {
            this._lastMaxExtent = maxExtent;
            this._postList.addAll(
                  List<Post>.generate(
                    20,
                    (index) => Post.fake(),
                    growable: false,
                  ),
                );
            developer.log(this._postList.length.toString());
          });
        }
      });
  }

  /// dispose.
  @override
  void dispose() {
    this._scrollController.dispose();
    super.dispose();
  }

  /// build.
  @override
  Widget build(BuildContext context) {
    return Container(
      child: ListView.builder(
        controller: this._scrollController,
        itemCount: this._postList.length,
        itemBuilder: (context, index) => PostWidget(
          post: this._postList.elementAt(index),
        ),
      ),
    );
  }
}
