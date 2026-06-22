import 'package:flutter/material.dart';
import 'package:htlink/core/theme/app_styles.dart';
import 'package:htlink/features/navigation/data/navbar_notifier.dart';

class Navbar extends StatelessWidget {
  const Navbar({super.key});

  @override
  Widget build(BuildContext context) {
    return ValueListenableBuilder(
      valueListenable: selectedIndexNotifier,
      builder: (context, selectedIndex, child) {
        return NavigationBar(
          selectedIndex: selectedIndex,
          destinations: const [
            NavigationDestination(icon: Icon(Icons.feed), label: 'Feed'),
            NavigationDestination(icon: Icon(Icons.search), label: 'Search'),
            NavigationDestination(icon: Icon(Icons.work), label: 'My Projects'),
            NavigationDestination(icon: Icon(Icons.menu), label: 'Menu'),
          ],
          backgroundColor: navbarBackground,
          onDestinationSelected: (value) {
            selectedIndexNotifier.value = value;
          },
        );
      },
    );
  }
}
