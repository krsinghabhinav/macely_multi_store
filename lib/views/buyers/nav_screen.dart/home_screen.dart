import 'package:bestproviderproject/views/buyers/nav_screen.dart/widgets/banner_widget.dart';
import 'package:flutter/material.dart';

import 'widgets/category_text.dart';
import 'widgets/search_input_widget.dart';
import 'widgets/welcome_text_widget.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 10),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            WelcomeText(),
            SizedBox(
              height: 15,
            ),
            SearchInputWidget(),
            SizedBox(
              height: 10,
            ),
            BannerWidget(),
            CategoryText(),
          ],
        ),
      ),
    );
  }
}
