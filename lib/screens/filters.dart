import 'package:flutter/material.dart';
// import 'package:meals_app/screens/tabs.dart';
// import 'package:meals_app/widgets/main_drawer.dart';

enum FilterOptions {
  glutenFree,
  vegetarian,
  vegan,
  lactoseFree,
}

class FiltersScreen extends StatefulWidget {
  const FiltersScreen({super.key, required this.currentFilters});

  final Map<FilterOptions, bool> currentFilters;

  @override
  State<FiltersScreen> createState() => _FiltersScreenState();
}

class _FiltersScreenState extends State<FiltersScreen> {
  var _glutenFree = false;
  var _vegetarian = false;
  var _vegan = false;
  var _lactoseFree = false;

  @override
  void initState() {
    _glutenFree = widget.currentFilters[FilterOptions.glutenFree]!;
    _vegetarian = widget.currentFilters[FilterOptions.vegetarian]!;
    _vegan = widget.currentFilters[FilterOptions.vegan]!;
    _lactoseFree = widget.currentFilters[FilterOptions.lactoseFree]!;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Your Filters', style: TextStyle(color: Colors.orange),
      )),
      // --- Drawer ---
      //
      // drawer: MainDrawer(onSelected: (identifier) {
      //   Navigator.of(context).pop();
      //   if (identifier == 'meals') {
      //     Navigator.of(context).push(MaterialPageRoute(builder: (ctx) => const TabsScreen()));
      //   }
      // },),
      body: PopScope(
        canPop: false,
        onPopInvoked: (bool didPop) {
          if(didPop) return;
          Navigator.of(context).pop({
            FilterOptions.glutenFree: _glutenFree,
            FilterOptions.vegetarian: _vegetarian,
            FilterOptions.vegan: _vegan,
            FilterOptions.lactoseFree: _lactoseFree,
          });
        },
        child: Column(children: [
          SwitchListTile(
            value: _glutenFree,
            onChanged: (isCheked) {
              setState(() {
                _glutenFree = isCheked;
              });
            },
            title: Text('Gluten free',
                style: Theme.of(context)
                    .textTheme
                    .titleLarge!
                    .copyWith(color: const Color.fromRGBO(255, 255, 255, 1))),
            subtitle: Text('Only include gluten-free meals.',
                style: Theme.of(context)
                    .textTheme
                    .labelMedium!
                    .copyWith(color:const  Color.fromRGBO(255, 255, 255, 1))),
                    activeColor: Colors.orange,
          ),
          SwitchListTile(
            value: _vegan,
            onChanged: (isCheked) {
              setState(() {
                _vegan = isCheked;
              });
            },
            title: Text('Vegan',
                style: Theme.of(context)
                    .textTheme
                    .titleLarge!
                    .copyWith(color: const Color.fromRGBO(255, 255, 255, 1))),
            subtitle: Text('Only include vegan meals.',
                style: Theme.of(context)
                    .textTheme
                    .labelMedium!
                    .copyWith(color:const  Color.fromRGBO(255, 255, 255, 1))),
                    activeColor: Colors.orange,
          ),
          SwitchListTile(
            value: _vegetarian,
            onChanged: (isCheked) {
              setState(() {
                _vegetarian = isCheked;
              });
            },
            title: Text('Vegetarian',
                style: Theme.of(context)
                    .textTheme
                    .titleLarge!
                    .copyWith(color: const Color.fromRGBO(255, 255, 255, 1))),
            subtitle: Text('Only include vegetarian meals.',
                style: Theme.of(context)
                    .textTheme
                    .labelMedium!
                    .copyWith(color:const  Color.fromRGBO(255, 255, 255, 1))),
                    activeColor: Colors.orange,
          ),
          SwitchListTile(
            value: _lactoseFree,
            onChanged: (isCheked) {
              setState(() {
                _lactoseFree = isCheked;
              });
            },
            title: Text('Lactose free',
                style: Theme.of(context)
                    .textTheme
                    .titleLarge!
                    .copyWith(color: const Color.fromRGBO(255, 255, 255, 1))),
            subtitle: Text('Only include lactose-free meals.',
                style: Theme.of(context)
                    .textTheme
                    .labelMedium!
                    .copyWith(color:const  Color.fromRGBO(255, 255, 255, 1))),
                    activeColor: Colors.orange,
          ),
        ]),
      ),
    );
  }
}
