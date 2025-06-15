import 'package:flutter/material.dart';
import 'package:google_nav_bar/google_nav_bar.dart';
class navBar extends StatefulWidget {



  @override
  State<navBar> createState() => _navBarState();
}

class _navBarState extends State<navBar> {

  int _currentIndex = 0;

  void _navigateBottomBar(int index){
    setState(() {

      _currentIndex = index;
    });
  }
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 20),
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
        padding: EdgeInsets.symmetric(horizontal: 20, vertical: 10),
        onTabChange: (index){
print(index);
        },
        tabs: [
          GButton(
            icon: Icons.home_outlined,
            text: 'Home',
          ),
          GButton(
            icon: Icons.search_outlined,
            text: 'Search',
          ),
          GButton(
            icon: Icons.map,
            text: 'Map',
          ),

          GButton(
            icon: Icons.person_outline,
            text: 'Profile',
          ),
        ],
      ),
    );
  }
}
