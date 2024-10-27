import 'package:bestproviderproject/vendor/views/screen/earning_screen.dart';
import 'package:bestproviderproject/vendor/views/screen/edit_product_screen.dart';
import 'package:bestproviderproject/vendor/views/screen/upload_screen.dart';
import 'package:bestproviderproject/vendor/views/screen/vendor_logout_screen.dart';
import 'package:bestproviderproject/vendor/views/screen/vendor_order_screen.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class MainVenderScreen extends StatefulWidget {
  const MainVenderScreen({super.key});

  @override
  State<MainVenderScreen> createState() => _MainVenderScreenState();
}

class _MainVenderScreenState extends State<MainVenderScreen> {
  int _pageIndex = 0;

  List<Widget> _tabsPages = [
    EarningScreen(),
    UploadScreen(),
    EditProductScreen(),
    VendorOrderScreen(),
    VendorLogoutScreen()
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: _pageIndex,
        onTap: (value) {
          setState(() {
            _pageIndex = value;
          });
        },
        type: BottomNavigationBarType.fixed,
        unselectedItemColor: Colors.black,
        selectedItemColor: Colors.yellow.shade900,
        items: [
          BottomNavigationBarItem(
              icon: Icon(CupertinoIcons.money_dollar), label: 'EARNINGS'),
          BottomNavigationBarItem(icon: Icon(Icons.upload), label: 'UPLOAD'),
          BottomNavigationBarItem(icon: Icon(Icons.edit), label: 'EDIT'),
          BottomNavigationBarItem(
              icon: Icon(CupertinoIcons.shopping_cart), label: 'ORDERS'),
          BottomNavigationBarItem(icon: Icon(Icons.logout), label: 'LOGOUT'),
        ],
      ),
      body: _tabsPages[_pageIndex],
    );
  }
}
