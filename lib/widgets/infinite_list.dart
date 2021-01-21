import 'dart:async';
import 'package:flutter/material.dart';
import 'package:flutter_tutorial/models/post.dart' show Post;
import 'package:flutter_tutorial/widgets/post_widget.dart' show PostWidget;
import 'dart:developer' as developer;

List<Post> postBackend =
    List.generate(100, (index) => Post.fake(), growable: false);

/// [InfiniteList].
class InfiniteList extends StatefulWidget {
  InfiniteList({
    Key key,
    this.duration = const Duration(milliseconds: 256),
  }) : super(key: key);

  final Duration duration;

  @override
  _InfiniteListState createState() => _InfiniteListState();
}

/// [_InfiniteListState].
class _InfiniteListState extends State<InfiniteList> {
  static const pageLimit = 20;
  List<Post> _postList;

  /// Last List View Max Extent value.
  double _lastMaxExtent = 0.0;
  final ScrollController _scrollController = ScrollController();

  Timer _timer;
  final TextEditingController _textController = TextEditingController();

  /// Apply Search.
  void _applySearch() {
    if (this._timer.isActive) this._timer.cancel();
    this._timer =
        Timer(this.widget.duration, () => setState(() => this._updateList()));
  }

  /// Reset List.
  void _clearSearch() {
    this._timer.cancel();
    this._textController.clear();
    // Remove keyboard (Text Field focus).
    FocusScope.of(context).unfocus();
    // Reset List.
    setState(
        () => this._postList = postBackend.getRange(0, pageLimit).toList());
  }

  /// Update List.
  void _updateList() {
    final tempList = (this._textController.text.isEmpty)
        ? postBackend
        : postBackend
            .where((post) => post.keyword
                .contains(this._textController.text.trim().toLowerCase()))
            .toList();
    final end = ((tempList.length - this._postList.length) > pageLimit)
        ? pageLimit
        : tempList.length - this._postList.length;
    this._postList.addAll(
        tempList.getRange(this._postList.length, this._postList.length + end));
    developer.log(this._postList.length.toString());
  }

  /// init.
  @override
  void initState() {
    super.initState();
    this._timer = Timer(this.widget.duration, () {});
    this._postList = postBackend.getRange(0, pageLimit).toList();
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
            this._updateList();
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
      child: Column(
        children: [
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 4.0),
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
                  prefixIcon: Icon(Icons.search, color: Colors.blueGrey),
                  suffixIcon: IconButton(
                    onPressed: () => this._clearSearch(),
                    icon: Icon(Icons.clear, color: Colors.blueGrey),
                  ),
                  border: InputBorder.none,
                ),
                onChanged: (_) => this._applySearch(),
              ),
            ),
          ),
          Expanded(
            child: ListView.builder(
              controller: this._scrollController,
              itemCount: this._postList.length,
              itemBuilder: (context, index) => PostWidget(
                post: this._postList.elementAt(index),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
