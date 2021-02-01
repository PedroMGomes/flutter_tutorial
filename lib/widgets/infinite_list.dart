import 'dart:async';
import 'package:flutter/material.dart';
import 'package:flutter_tutorial/models/post.dart' show Post;
import 'package:flutter_tutorial/server/post_server.dart' show PostServer;
import 'package:flutter_tutorial/widgets/post_widget.dart' show PostWidget;

/// [InfiniteList].
class InfiniteList extends StatefulWidget {
  InfiniteList({Key key}) : super(key: key);

  @override
  _InfiniteListState createState() => _InfiniteListState();
}

/// [_InfiniteListState].
class _InfiniteListState extends State<InfiniteList> {
  List<Post> _postList;

  /// Last List View Max Extent value.
  double _lastMaxExtent = 0.0;
  final ScrollController _scrollController = ScrollController();

  static const Duration _duration = Duration(seconds: 1);
  Timer _timer = Timer(_duration, () {});
  final TextEditingController _textController = TextEditingController();
  String _lastSearchTerm = '';

  /// Apply Search.
  void _search() {
    if (this._timer.isActive) this._timer.cancel();
    this._timer = Timer(_duration, () {
      // Only fetch new data if input has changed from last request.
      if (this._lastSearchTerm != this._textController.text) {
        setState(() {
          this._scrollController.jumpTo(0);
          this._lastSearchTerm = this._textController.text;
          this._postList = PostServer.get(
            offset: 0,
            limit: 20,
            keywordFilter: this._textController.text,
          );
        });
      }
    });
  }

  /// Reset List.
  void _clearSearch() {
    this._timer.cancel();
    this._textController.clear();
    // Unfocus Text Field and dismisses keyboard.
    FocusScope.of(context).unfocus();
    if (this._lastSearchTerm.isNotEmpty) {
      setState(() {
        // Jumps to initial scroll position.
        this._scrollController.jumpTo(0);
        this._lastSearchTerm = '';
        this._postList = PostServer.get(offset: 0, limit: 20);
      });
    }
  }

  /// init.
  @override
  void initState() {
    super.initState();
    this._postList = PostServer.get(offset: 0, limit: 20);
    this._scrollController
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
            this._postList.addAll(PostServer.get(
                  offset: this._postList.length,
                  limit: 20,
                  keywordFilter: this._textController.text,
                ));
          });
        }
      });
  }

  /// dispose.
  @override
  void dispose() {
    this._timer.cancel();
    this._textController.dispose();
    this._scrollController.dispose();
    super.dispose();
  }

  /// build.
  @override
  Widget build(BuildContext context) {
    return Container(
      child: Stack(
        alignment: Alignment.topCenter,
        children: [
          ListView.builder(
            keyboardDismissBehavior: ScrollViewKeyboardDismissBehavior.onDrag,
            controller: this._scrollController,
            itemCount: this._postList.length + 1,
            itemBuilder: (context, index) => (index == 0)
                ? const SizedBox(height: 64.0)
                : PostWidget(
                    post: this._postList.elementAt(index),
                  ),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 8.0, horizontal: 8.0),
            child: Card(
              elevation: 8.0,
              child: TextField(
                maxLines: 1,
                autocorrect: false,
                controller: this._textController,
                keyboardType: TextInputType.text,
                textInputAction: TextInputAction.search,
                textAlignVertical: TextAlignVertical.center,
                decoration: InputDecoration(
                  hintText: 'Search color',
                  prefixIcon: Icon(Icons.search, color: Colors.blue),
                  suffixIcon: IconButton(
                    onPressed: () => this._clearSearch(),
                    icon: Icon(Icons.clear, color: Colors.blue),
                  ),
                  border: InputBorder.none,
                ),
                onChanged: (_) => this._search(),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
