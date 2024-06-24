import 'package:flutter/material.dart';
import 'package:meals_app/data/dummy_data.dart';
import 'package:meals_app/widgets/categories_widget.dart';


class CategoriesScreen extends StatelessWidget {
  const CategoriesScreen({super.key});

  @override
  Widget build(BuildContext context) {
    const categories = availableCategories;

    return Scaffold(
      appBar: AppBar(
        title: const Text('Pick your category!'),
      ),
      body: GridView(
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
                onTap: () {
                  print('${catData.title} clicked!');
                },
              ),
            )
            .toList(),
      ),
    );
  }
}
