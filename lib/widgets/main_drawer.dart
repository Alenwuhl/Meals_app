import 'package:flutter/material.dart';

class MainDrawer extends StatelessWidget {
  const MainDrawer({super.key, required this.onSelected});

  final void Function(String identifier) onSelected;

  @override
  Widget build(BuildContext context) {
    return  Drawer(
      child: Column(children: [
        const DrawerHeader(
          padding: EdgeInsets.all(20),
          decoration: BoxDecoration(
            gradient:
                LinearGradient(colors: [Colors.orange, Colors.orangeAccent]),
          ),
          child: Row(
            children: [
              Icon(Icons.restaurant_menu, size: 48, color: Colors.white),
              Text('Cooking Up!',
                  style: TextStyle(fontSize: 24, color: Colors.white)),
            ],
          ),
        ),
                ListTile(
          leading: const Icon(Icons.filter_list_rounded, size: 24, color: Colors.orange),
          title: const Text('Filters',
              style: TextStyle(fontSize: 20, color: Colors.orange)),
          onTap: () {onSelected('filters');},
        ),
        ListTile(
          leading: const Icon(Icons.restaurant, size: 24, color: Colors.orange),
          title: const Text('Meals',
              style: TextStyle(fontSize: 20, color: Colors.orange)),
          onTap: () {
            onSelected('meals');
          },
        ),
      ]),
    );
  }
}
