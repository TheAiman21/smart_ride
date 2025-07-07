import 'package:flutter/material.dart';
import 'package:rentapp/presentation/pages/onboarding_page.dart';
import 'package:rentapp/presentation/pages/car_list_screen.dart';
import 'package:rentapp/presentation/pages/promos_page.dart';
import 'package:rentapp/presentation/pages/menu_page.dart';

class MainPage extends StatefulWidget {
  const MainPage({super.key});

  @override
  State<MainPage> createState() => _MainPageState();
}

class _MainPageState extends State<MainPage> {
  int _currentIndex = 0;

  final pages = const [
    OnboardingPage(),
    CarListScreen(),
    PromosPage(),
    MenuPage(),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(['Home', 'Booking', 'Promos', 'Menu'][_currentIndex]),
      ),
      body: IndexedStack(
        index: _currentIndex,
        children: pages,
      ),
      bottomNavigationBar: BottomNavigationBar(
  type: BottomNavigationBarType.fixed,
  backgroundColor: Colors.white, // set nav bar background
  currentIndex: _currentIndex,
  selectedItemColor: const Color.fromARGB(255, 0, 0, 0), // color when selected
  unselectedItemColor: Colors.grey[600], // darker grey for visibility
  selectedFontSize: 14,
  unselectedFontSize: 12,
  iconSize: 28,
  showUnselectedLabels: true, // <== always show labels even when not selected
  onTap: (index) {
    setState(() {
      _currentIndex = index;
    });
  },
  items: const [
    BottomNavigationBarItem(
      icon: Icon(Icons.home),
      label: 'Home',
    ),
    BottomNavigationBarItem(
      icon: Icon(Icons.book_online),
      label: 'Booking',
    ),
    BottomNavigationBarItem(
      icon: Icon(Icons.local_offer),
      label: 'Promos',
    ),
    BottomNavigationBarItem(
      icon: Icon(Icons.menu),
      label: 'Menu',
    ),
  ],
),
    );
  }
}