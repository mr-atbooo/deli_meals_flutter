import '../models/meal.dart';
import 'package:flutter/material.dart';
import 'categories_screen.dart';
import 'favorites_screen.dart';
import '../widgets/main_drawer.dart';

class TabsScreen extends StatefulWidget {
  final List<Meal> favoriteMeals;
  final Function _emptyFavorite;
  TabsScreen(this.favoriteMeals, this._emptyFavorite);

  @override
  _TabsScreenState createState() => _TabsScreenState();
}

class _TabsScreenState extends State<TabsScreen> {
  int _selectedIndex = 0;

  List<Map<String, Object>> _widgetOptions;

  @override
  void initState() {
    _widgetOptions = [
      {'page': CategoriesScreen(), 'title': "Categories", 'isaction': false},
      {
        'page': FavoritesScreen(widget.favoriteMeals),
        'title': "Favorites",
        'isaction': true,
        'actions': widget._emptyFavorite
      },
    ];
    super.initState();
  }

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(_widgetOptions[_selectedIndex]['title']),
        actions: [
          _widgetOptions[_selectedIndex]['isaction']
              ? IconButton(
                  icon: Icon(
                    Icons.delete,
                    color: Colors.white,
                  ),
                  onPressed: () {
                    widget._emptyFavorite();
                    print(_widgetOptions[_selectedIndex]['actions']);
                  },
                )
              : SizedBox()
        ],
      ),
      drawer: MainDrawer(),
      body: _widgetOptions[_selectedIndex]['page'],
      bottomNavigationBar: BottomNavigationBar(
        items: [
          BottomNavigationBarItem(
            icon: Icon(Icons.category),
            label: "Categories",
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.favorite),
            label: "Favorites",
          ),
        ],
        currentIndex: _selectedIndex,
        selectedItemColor: Theme.of(context).accentColor,
        unselectedItemColor: Colors.white,
        onTap: _onItemTapped,
        backgroundColor: Theme.of(context).primaryColor,
      ),
    );
  }
}
