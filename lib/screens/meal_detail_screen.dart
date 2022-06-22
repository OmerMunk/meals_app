import 'package:flutter/material.dart';
import '../dummy_data.dart';

class MealDetailScreen extends StatelessWidget {
  static const routeName = '/meal-detail';
  final Function toggleFavorite;
  final Function isFavorite;

  MealDetailScreen(this.toggleFavorite, this.isFavorite);

  Widget buildSectionTitle(
      BuildContext context, String text, MediaQueryData mediaQuery) {
    return Container(
      margin: EdgeInsets.symmetric(
          vertical: mediaQuery.orientation == Orientation.portrait ? 10 : 0),
      child: Text(
        text,
        style: Theme.of(context).textTheme.headline5,
      ),
    );
  }

  Widget buildListContainer(Widget child, MediaQueryData mediaQuery) {
    return Container(
        decoration: BoxDecoration(
          color: Colors.white,
          border: Border.all(color: Colors.grey),
          borderRadius: BorderRadius.circular(10),
        ),
        margin: const EdgeInsets.all(10),
        padding: const EdgeInsets.all(10),
        height: mediaQuery.orientation == Orientation.portrait
            ? mediaQuery.size.height * 0.3
            : mediaQuery.size.height * 0.3,
        width: mediaQuery.orientation == Orientation.portrait
            ? mediaQuery.size.width * 0.9
            : mediaQuery.size.width * 0.4,
        child: child);
  }

  @override
  Widget build(BuildContext context) {
    MediaQueryData mediaQuery = MediaQuery.of(context);
    final List arguments = ModalRoute.of(context)!.settings.arguments as List;
    final mealId = arguments[0] as String;
    final from = arguments[1];
    final selectedMeal = dummyMeals.firstWhere((meal) => meal.id == mealId);
    return Scaffold(
      appBar: AppBar(
        title: Text('${selectedMeal.title}',
            style: Theme.of(context)
                .textTheme
                .headline5
                ?.copyWith(color: Colors.white)),
      ),
      body: SingleChildScrollView(
        child: Flex(
          direction: mediaQuery.orientation == Orientation.portrait
              ? Axis.vertical
              : Axis.horizontal,
          mainAxisAlignment: mediaQuery.orientation == Orientation.portrait
              ? MainAxisAlignment.start
              : MainAxisAlignment.spaceAround,
          children: <Widget>[
            SizedBox(
              height: MediaQuery.of(context).size.height * 0.3,
              width: double.infinity,
              child: ClipRRect(
                borderRadius: BorderRadius.circular(
                    mediaQuery.orientation == Orientation.landscape ? 10 : 0),
                child: Image.network(
                  selectedMeal.imageUrl!,
                  fit: BoxFit.cover,
                ),
              ),
            ),
            Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                buildSectionTitle(context, 'Ingredients', mediaQuery),
                buildListContainer(
                    ListView.builder(
                      itemBuilder: (ctx, index) {
                        return Card(
                          color: Theme.of(context).colorScheme.secondary,
                          child: Padding(
                            padding: const EdgeInsets.symmetric(
                                vertical: 5, horizontal: 10),
                            child: Text(selectedMeal.ingredients![index]),
                          ),
                        );
                      },
                      itemCount: selectedMeal.ingredients!.length,
                    ),
                    mediaQuery),
                buildSectionTitle(context, 'Steps', mediaQuery),
                buildListContainer(
                    ListView.builder(
                      itemBuilder: (ctx, index) {
                        return Column(
                          children: <Widget>[
                            ListTile(
                              leading: CircleAvatar(
                                backgroundColor:
                                    Color.fromRGBO(3, 122, 42, 1.0),
                                child: Text(
                                  '# ${index + 1}',
                                  style: TextStyle(color: Colors.white),
                                ),
                              ),
                              title: Text(selectedMeal.steps![index]),
                            ),
                            const Divider(
                              thickness: 0.9,
                              color: Colors.black,
                            )
                          ],
                        );
                      },
                      itemCount: selectedMeal.steps!.length,
                    ),
                    mediaQuery)
              ],
            )
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        child: Icon(
          isFavorite(mealId) ? Icons.star : Icons.star_border,
        ),
        onPressed: () {
          // the next line is because ther former button was to delete it.
          // Navigator.of(context).pop(mealId);
          toggleFavorite(mealId);
          if (from == 'favorites') {
            Navigator.of(context).pop(mealId);
          }
        },
      ),
    );
  }
}
