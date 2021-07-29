import 'package:flutter/material.dart';
import 'package:fluttercrud/presentation/Opportunities/opportunities_page.dart';
import 'package:fluttercrud/presentation/auth/account_page.dart';
import 'package:fluttercrud/presentation/favorite/favorite_page.dart';
import 'package:fluttercrud/presentation/forum/questions_page.dart';
import 'package:fluttercrud/values/branding_color.dart';

class HomePage extends StatefulWidget {
  HomePage({Key key}) : super(key: key);

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  PageController _pageController = PageController();
  final List<Widget> _screens = [
    OpportunitiesPage(),
    QuestionsPage(),
    FavoritePage(),
    AccountPage()
  ];
  int _selectedIndex = 0;

  void _onItemTapped(int itemIndex) {
    _pageController.jumpToPage(itemIndex);
    setState(() {
      _selectedIndex = itemIndex;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: PageView(
        children: _screens,
        controller: _pageController,
        physics: NeverScrollableScrollPhysics(),
      ),
      bottomNavigationBar: BottomNavigationBar(
        type: BottomNavigationBarType.fixed,
        onTap: _onItemTapped,
        currentIndex: _selectedIndex,
        selectedIconTheme: IconThemeData(color: brandingColor, size: 25),
        items: [
          BottomNavigationBarItem(
            label: "Opportunities",
            icon: Icon(Icons.home),
          ),
          BottomNavigationBarItem(
            label: "Forum",
            icon: Icon(Icons.chat),
          ),
          BottomNavigationBarItem(
            label: "Favorites",
            icon: Icon(Icons.favorite),
          ),
          BottomNavigationBarItem(
            label: "Account",
            icon: Icon(Icons.person),
          ),
        ],
      ),
    );
  }
}
