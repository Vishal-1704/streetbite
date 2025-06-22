import 'package:flutter/material.dart';
import 'package:google_nav_bar/google_nav_bar.dart';

import 'home_screen.dart';
import 'map_screen.dart';
import 'profile_screen.dart';
import 'search_screen.dart';

class HomePage extends StatefulWidget {
  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  int _currentIndex = 0;
  List<Widget> pages = [
    HomeScreen(),
    SearchScreen(),
    MapScreen(),
    ProfilePage(),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: IndexedStack(index: _currentIndex, children: pages),
      bottomNavigationBar: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 8.0, vertical: 8),
        child: GNav(
          backgroundColor: Colors.white,
          rippleColor: Colors.purple.withOpacity(0.2), // smooth ripple

          haptic: true,
          tabBorderRadius: 16,
          tabActiveBorder: Border.all(color: Colors.black, width: 1),
          curve: Curves.easeInCirc,
          duration: Duration(milliseconds: 200),
          gap: 6,
          color: Colors.grey.shade600, // unselected
          activeColor: Colors.black,
          iconSize: 26,
          tabBackgroundColor: Colors.white,
          padding: EdgeInsets.symmetric(horizontal: 15, vertical: 10),
          onTabChange: (index) {
            setState(() {
              _currentIndex = index;
            });
          },
          tabs: [
            GButton(icon: Icons.home_outlined, text: 'Home'),
            GButton(icon: Icons.search_outlined, text: 'Search'),
            GButton(icon: Icons.map_rounded, text: 'Map'),
            GButton(icon: Icons.person_outline, text: 'Profile'),
          ],
        ),
      ),
    );
  }
}
