import 'package:flutter/material.dart';
import 'package:flutter_tutorials/pages/counter_page.dart';
import 'package:flutter_tutorials/pages/home_page.dart';
import 'package:flutter_tutorials/pages/product_page.dart';
import 'package:flutter_tutorials/pages/profile_page.dart';
import 'package:flutter_tutorials/providers/page_provider.dart';
import 'package:provider/provider.dart';

class Skeleton extends StatelessWidget {
  const Skeleton({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: [
        const HomePage(),
        const CounterPage(),
        const ProductPage(),
        ProfilePage()
      ][context.watch<PageProvider>().currentPageIndex],
      bottomNavigationBar: NavigationBar(
        onDestinationSelected: (int index) =>
            context.read<PageProvider>().chnageCurrentPageIndex(index),
        selectedIndex: context.watch<PageProvider>().currentPageIndex,
        destinations: const <NavigationDestination>[
          NavigationDestination(
            selectedIcon: Icon(Icons.home),
            icon: Icon(Icons.home_outlined),
            label: 'Home',
          ),
          NavigationDestination(
            selectedIcon: Icon(Icons.swap_vert_circle),
            icon: Icon(Icons.swap_vert_circle_outlined),
            label: 'Counter',
          ),
          NavigationDestination(
            selectedIcon: Icon(Icons.category),
            icon: Icon(Icons.category_outlined),
            label: 'Products',
          ),
          NavigationDestination(
            selectedIcon: Icon(Icons.person),
            icon: Icon(Icons.person_outlined),
            label: 'Profile',
          ),
        ],
      ),
    );
  }
}
