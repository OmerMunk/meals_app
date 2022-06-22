import 'package:flutter/material.dart';
import '../widgets/main_drawer.dart';

class FiltersScreen extends StatefulWidget {
  static const routeName = '/filters-screen';
  final Function? saveFilters;
  final Map<String, bool>? currentFilters;

  const FiltersScreen(this.saveFilters, this.currentFilters);

  @override
  State<FiltersScreen> createState() => _FiltersScreenState();
}

class _FiltersScreenState extends State<FiltersScreen> {
  late bool glutenFree;
  late bool vegetarian;
  late bool vegan;
  late bool lactoseFree;

  @override
  void initState() {
    glutenFree = widget.currentFilters!['gluten'] as bool;
    vegetarian = widget.currentFilters!['vegetarian'] as bool;
    vegan = widget.currentFilters!['vegan'] as bool;
    lactoseFree = widget.currentFilters!['lactose'] as bool;
    super.initState();
  }

  Widget _buildSwitchListTile(String title, String description,
      bool currentValue, Function(bool)? updateValue) {
    return SwitchListTile.adaptive(
      title: Text(title),
      subtitle: Text(description),
      value: currentValue,
      onChanged: updateValue,
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Your Filters'),
        actions: <Widget>[
          IconButton(
              onPressed: () {
                Map<String, bool> newFilters = {
                  'gluten': glutenFree,
                  'lactose': lactoseFree,
                  'vegan': vegan,
                  'vegetarian': vegetarian,
                };

                widget.saveFilters!(newFilters);
              },
              icon: const Icon(Icons.save))
        ],
      ),
      drawer: const MainDrawer(),
      body: Column(
        children: <Widget>[
          Container(
            padding: const EdgeInsets.all(20),
            child: Text(
              'Adjust your meal selection',
              style: Theme.of(context).textTheme.headline5,
            ),
          ),
          Expanded(
            child: ListView(
              children: <Widget>[
                _buildSwitchListTile(
                  'Gluten-free',
                  'Only include gluten-free meals',
                  glutenFree,
                  (newValue) => setState(
                    () {
                      glutenFree = newValue;
                    },
                  ),
                ),
                _buildSwitchListTile(
                  'Lactose-free',
                  'Only include lactose-free meals',
                  lactoseFree,
                  (newValue) => setState(
                    () {
                      lactoseFree = newValue;
                    },
                  ),
                ),
                _buildSwitchListTile(
                  'Vegetarian',
                  'Only include vegetarian meals',
                  vegetarian,
                  (newValue) => setState(
                    () {
                      vegetarian = newValue;
                    },
                  ),
                ),
                _buildSwitchListTile(
                  'Vegan',
                  'Only include vegan meals',
                  vegan,
                  (newValue) => setState(
                    () {
                      vegan = newValue;
                    },
                  ),
                ),
              ],
            ),
          )
        ],
      ),
    );
  }
}
