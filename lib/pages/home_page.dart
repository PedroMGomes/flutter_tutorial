import 'package:flutter/material.dart';
import 'package:flutter_tutorial/widgets/drawer_widget.dart' show DrawerWidget;
import 'package:flutter_tutorial/widgets/infinite_list.dart' show InfiniteList;

/// [HomePage].
class HomePage extends StatelessWidget {
  const HomePage({Key key}) : super(key: key);

  /// build.
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: DrawerWidget(),
      body: SafeArea(
        child: InfiniteList(),
      ),
    );
  }
}
