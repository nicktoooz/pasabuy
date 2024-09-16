import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class RootMounter extends StatefulWidget {
  const RootMounter({super.key, required this.navigationShell});

  final StatefulNavigationShell navigationShell;

  @override
  State<RootMounter> createState() => _RootMounterState();
}

class _RootMounterState extends State<RootMounter> {
  int _currentIndex = 0;

  void goToBranch(int index) {
    widget.navigationShell
        .goBranch(index, initialLocation: index == widget.navigationShell.currentIndex);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(child: widget.navigationShell),
      bottomNavigationBar: Container(
        padding: const EdgeInsets.symmetric(horizontal: 40.0),
        child: BottomNavigationBar(
          backgroundColor: Colors.transparent,
          showSelectedLabels: false,
          showUnselectedLabels: false,
          currentIndex: _currentIndex,
          onTap: (index) {
            setState(() {
              _currentIndex = index;
            });
            goToBranch(_currentIndex);
          },
          iconSize: 28,
          type: BottomNavigationBarType.fixed,
          elevation: 0,
          items: const [
            BottomNavigationBarItem(
              backgroundColor: Colors.transparent,
              activeIcon: Icon(
                Icons.home,
              ),
              icon: Icon(
                Icons.home_outlined,
              ),
              label: 'Home',
            ),
            BottomNavigationBarItem(
              backgroundColor: Colors.transparent,
              activeIcon: Icon(
                Icons.shopping_bag,
              ),
              icon: Icon(
                Icons.shopping_bag_outlined,
              ),
              label: 'Home',
            ),
            BottomNavigationBarItem(
              backgroundColor: Colors.transparent,
              activeIcon: Badge(
                child: Icon(
                  Icons.notifications,
                ),
              ),
              icon: Badge(
                label: Text('3'),
                child: Icon(
                  Icons.notifications_outlined,
                ),
              ),
              label: 'Notifications',
            ),
            BottomNavigationBarItem(
              backgroundColor: Colors.transparent,
              icon: Icon(
                Icons.person,
              ),
              activeIcon: Icon(
                Icons.person,
              ),
              label: 'Profile',
            ),
          ],
        ),
      ),
    );
  }
}
