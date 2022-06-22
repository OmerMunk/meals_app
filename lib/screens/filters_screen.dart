import 'package:flutter/material.dart';
import '../widgets/main_drawer.dart';

class FiltersScreen extends StatelessWidget {
  static const routeName = '/filters-screen';

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      drawer: MainDrawer(),
      body: Center(
        child: Text('filters!'),
      ),
    );
  }
}
