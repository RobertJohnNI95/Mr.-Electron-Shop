import 'package:flutter/material.dart';
import 'package:flutter_course_ecommerce_project/screens/tabs/cart_screen.dart';
import 'package:flutter_course_ecommerce_project/screens/tabs/home_screen.dart';
import 'package:flutter_course_ecommerce_project/screens/tabs/profile_screen.dart';

class MainScreen extends StatefulWidget {
  const MainScreen({super.key});
  static const String routeName = '/main';

  @override
  State<MainScreen> createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen> {
  int currentTab = 0;

  @override
  Widget build(BuildContext context) {
    // Tabs
    final List<Widget> tabs = [
      const Center(child: HomeScreen()),
      const Center(child: CartScreen()),
      Center(child: ProfileScreen()),
    ];

    return Scaffold(
      backgroundColor: Colors.transparent,
      appBar: AppBar(
        backgroundColor: Colors.blue,
        centerTitle: true,
        title: const Text(
          "Mr. Electron Shop",
          style: TextStyle(
            color: Colors.white,
            fontWeight: FontWeight.bold,
            fontSize: 20,
          ),
        ),
      ),
      body: tabs[currentTab],
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: currentTab,
        onTap: (tab) {
          setState(() {
            currentTab = tab;
          });
        },
        items: const [
          BottomNavigationBarItem(icon: Icon(Icons.home), label: "Home"),
          BottomNavigationBarItem(
            icon: Icon(Icons.shopping_cart),
            label: "Cart",
          ),
          BottomNavigationBarItem(icon: Icon(Icons.person), label: "Profile"),
        ],
      ),
    );
  }
}
