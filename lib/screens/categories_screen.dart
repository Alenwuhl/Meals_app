import 'package:flutter/material.dart';
import 'package:meals_app/data/dummy_data.dart';
import 'package:meals_app/models/category.dart';
import 'package:meals_app/models/meal.dart';
import 'package:meals_app/screens/meals_screen.dart';
import 'package:meals_app/widgets/category_grid_item.dart';

class CategoriesScreen extends StatelessWidget {
  const CategoriesScreen(
      {super.key,
      required this.onToggleFavorite,
      required this.availableMeals});

  final void Function(Meal meal) onToggleFavorite;
  final List<Meal> availableMeals;

  void _selectCategory(BuildContext context, Category category) {
    final filteredMeals = availableMeals
        .where((meal) => meal.categories.contains(category.id))
        .toList();

    Navigator.of(context).push(
      MaterialPageRoute(
        builder: (ctx) {
          return MealsScreen(
            title: category.title,
            meals: filteredMeals,
            onToggleFavorite: onToggleFavorite,
          );
        },
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    const categories = availableCategories;

    return GridView(
      padding: const EdgeInsets.all(20),
      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 2,
        childAspectRatio: 3 / 2,
        crossAxisSpacing: 20,
        mainAxisSpacing: 20,
      ),
      children: categories
          .map(
            (catData) => CategoryGridItem(
              title: catData.title,
              color: catData.color,
              onSelectCategory: () {
                _selectCategory(context, catData);
              }, mealCount: availableMeals
                  .where((meal) => meal.categories.contains(catData.id))
                  .length,
            ),
          )
          .toList(),
    );
  }
}
