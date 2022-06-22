import 'package:flutter/material.dart';
import 'package:ionicons/ionicons.dart';
import 'package:tour/shared/global/global_var.dart';
import 'package:fluentui_icons/fluentui_icons.dart';

class Menu extends StatefulWidget {
  const Menu({Key? key}) : super(key: key);

  @override
  State<Menu> createState() => _MenuState();
}

class _MenuState extends State<Menu> {
  int _selectedIndex = 0;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: tourAppMenu.elementAt(_selectedIndex),
      bottomNavigationBar: ClipRRect(
        borderRadius: const BorderRadius.only(
          topLeft: Radius.circular(25),
          topRight: Radius.circular(25),
        ),
        child: NavigationBar(
          backgroundColor: const Color(0xff282D39),
          animationDuration: const Duration(seconds: 1),
          labelBehavior: NavigationDestinationLabelBehavior.onlyShowSelected,
          selectedIndex: _selectedIndex, //New
          onDestinationSelected: (index) {
            setState(() {
              _selectedIndex = index;
            });
          },
          destinations: [
            NavigationDestination(
              icon: Icon(
                _selectedIndex == 0
                    ? FluentSystemIcons.ic_fluent_home_filled
                    : FluentSystemIcons.ic_fluent_home_regular,
                // color: AppColors.primaryColor,
              ),
              label: 'Home',
            ),
            NavigationDestination(
              icon: Icon(
                _selectedIndex == 1
                    ? Ionicons.compass
                    : Ionicons.compass_outline,
              ),
              label: 'Explore',
            ),
            NavigationDestination(
              icon: Icon(
                _selectedIndex == 2 ? Ionicons.heart : Ionicons.heart_outline,
              ),
              label: 'Favourites',
            ),
            NavigationDestination(
              icon: Icon(
                _selectedIndex == 3 ? Ionicons.person : Ionicons.person_outline,
              ),
              label: 'Profile',
            ),
          ],
        ),
      ),
    );
  }
}
