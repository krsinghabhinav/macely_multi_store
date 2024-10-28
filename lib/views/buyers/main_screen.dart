import 'package:bestproviderproject/views/buyers/nav_screen.dart/account_Screen.dart';
import 'package:bestproviderproject/views/buyers/nav_screen.dart/cart_screen.dart';
import 'package:bestproviderproject/views/buyers/nav_screen.dart/categories_screen.dart';
import 'package:bestproviderproject/views/buyers/nav_screen.dart/home_screen.dart';
import 'package:bestproviderproject/views/buyers/nav_screen.dart/search_screen.dart';
import 'package:bestproviderproject/views/buyers/nav_screen.dart/store_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class MainScreen extends StatefulWidget {
  const MainScreen({super.key});

  @override
  State<MainScreen> createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen> {
  int _selectedIndex = 0;
  final List<Widget> _pages = [
    HomeScreen(),
    CategoriesScreen(),
    StoreScreen(),
    CartScreen(),
    SearchScreen(),
    AccountScreen()
  ];

  Future<bool> _onWillPop() async {
    // Agar home page pe ho, toh back button press karne par exit nahi hoga
    if (_selectedIndex == 0) {
      return true; // App band ho jayegi
    } else {
      setState(() {
        _selectedIndex = 0; // Home page pe navigate karein
      });
      return false; // Back button ka default action nahi chalega
    }
  }

  @override
  Widget build(BuildContext context) {
    // ignore: deprecated_member_use
    return WillPopScope(
      onWillPop: _onWillPop,
      child: Scaffold(
        bottomNavigationBar: BottomNavigationBar(
          type: BottomNavigationBarType.fixed,
          currentIndex: _selectedIndex,
          onTap: (value) {
            setState(() {
              _selectedIndex = value;
            });
          },
          unselectedItemColor: Colors.black,
          selectedItemColor: Colors.yellow.shade900,
          showUnselectedLabels: true, // Ensure unselected labels are shown
          showSelectedLabels: true, // Ensure selected labels are shown
          items: [
            BottomNavigationBarItem(
              icon: Icon(Icons.home),
              label: 'HOME',
            ),
            BottomNavigationBarItem(
              icon: SvgPicture.asset("assets/icons/explore.svg"),
              label: 'CATEGORIES',
            ),
            BottomNavigationBarItem(
              icon: SvgPicture.asset(
                  "assets/icons/shop-minimalistic-svgrepo-com.svg"),
              label: 'STORE',
            ),
            BottomNavigationBarItem(
              icon: SvgPicture.asset(
                  "assets/icons/cart-shopping-svgrepo-com.svg"),
              label: 'CART',
            ),
            BottomNavigationBarItem(
              icon: SvgPicture.asset("assets/icons/search-svgrepo-com (1).svg"),
              label: 'SEARCH',
            ),
            BottomNavigationBarItem(
              icon: SvgPicture.asset(
                  "assets/icons/account-circle-svgrepo-com.svg"),
              label: 'ACCOUNT',
            ),
          ],
          selectedLabelStyle: TextStyle(
            fontSize: 10, // Size for selected label
          ),
          unselectedLabelStyle: TextStyle(
            fontSize: 8, // Size for unselected label
          ),
        ),
        body: _pages[_selectedIndex],
      ),
    );
  }
}
