import 'package:flutter/material.dart';
import 'package:meals_app/data/dummy_data.dart';
import 'package:meals_app/models/meal.dart';
import 'package:meals_app/screens/categories_screen.dart';
import 'package:meals_app/screens/meals_screen.dart';
import 'package:meals_app/screens/filters.dart';
import 'package:meals_app/widgets/main_drawer.dart';

const kInitialFilters = {
  FilterOptions.glutenFree: false,
  FilterOptions.vegetarian: false,
  FilterOptions.vegan: false,
  FilterOptions.lactoseFree: false,
};

class TabsScreen extends StatefulWidget {
  const TabsScreen({super.key});

  @override
  State<TabsScreen> createState() => _TabsScreenState();
}

class _TabsScreenState extends State<TabsScreen> {
  int _selectedPageIndex = 0;
  final List<Meal> _favoriteMeals = [];
  Map<FilterOptions, bool> _filters = kInitialFilters;

  void _showInfoMessage(String message) {
    ScaffoldMessenger.of(context).clearSnackBars();
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(message),
        duration: const Duration(seconds: 2),
      ),
    );
  }

  void _setScreen(String identifier) async {
    Navigator.of(context).pop();
    if (identifier == 'filters') {
      final result = await Navigator.of(context).push<Map<FilterOptions, bool>>(
          MaterialPageRoute(builder: (ctx) => FiltersScreen(currentFilters: _filters,)));
      setState(() {
        _filters = result ?? kInitialFilters;
      });
    }
  }

  void _toggleFavorite(Meal meal) {
    final existingIndex = _favoriteMeals.indexWhere((m) => m.id == meal.id);

    if (existingIndex >= 0) {
      setState(() {
        _favoriteMeals.removeAt(existingIndex);
      });
      _showInfoMessage('Removed from favorites!');
    } else {
      setState(() {
        _favoriteMeals.add(meal);
      });
      _showInfoMessage('Added to favorites!');
    }
  }

  bool _isMealFavorite(Meal meal) {
    return _favoriteMeals.any((m) => m.id == meal.id);
  }

  void _selectPage(int index) {
    setState(() {
      _selectedPageIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    final availableMealsOptions = availableMeals.where((meal) {
      if (_filters[FilterOptions.glutenFree]! && !meal.isGlutenFree) {
        return false;
      }
      if (_filters[FilterOptions.vegetarian]! && !meal.isVegetarian) {
        return false;
      }
      if (_filters[FilterOptions.vegan]! && !meal.isVegan) {
        return false;
      }
      if (_filters[FilterOptions.lactoseFree]! && !meal.isLactoseFree) {
        return false;
      }
      return true;
    }).toList();


    Widget activeScreen = CategoriesScreen(onToggleFavorite: _toggleFavorite, availableMeals: availableMealsOptions);
    var activePageTitle = 'Categories';

    if (_selectedPageIndex == 1) {
      activeScreen =
          MealsScreen(meals: _favoriteMeals, onToggleFavorite: _toggleFavorite);
      activePageTitle = 'Your favorites';
    }

    return Scaffold(
      appBar: AppBar(
        title: Text(activePageTitle),
      ),
      drawer: MainDrawer(onSelected: _setScreen),
      body: activeScreen,
      bottomNavigationBar: BottomNavigationBar(
        onTap: _selectPage,
        currentIndex: _selectedPageIndex,
        items: const [
          BottomNavigationBarItem(
            icon: Icon(Icons.category),
            label: 'Categories',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.star),
            label: 'Favorites',
          ),
        ],
      ),
    );
  }
}
