import 'dart:async';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class BannerWidget extends StatefulWidget {
  const BannerWidget({super.key});

  @override
  State<BannerWidget> createState() => _BannerWidgetState();
}

class _BannerWidgetState extends State<BannerWidget> {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  final List<String> _bannerImage = [];
  PageController _pageController = PageController();
  Timer? _timer;
  int _currentPage = 0;

  getBanners() {
    return _firestore
        .collection("banners")
        .get()
        .then((QuerySnapshot querySnapshot) {
      querySnapshot.docs.forEach((element) {
        setState(() {
          _bannerImage.add(element['image']);
        });
      });

      // Start autoplay after fetching the banners
      startAutoPlay();
    });
  }

  @override
  void initState() {
    super.initState();
    getBanners();

    // Add listener to track page changes
    _pageController.addListener(() {
      setState(() {
        _currentPage = _pageController.page!.round();
      });
    });
  }

  void startAutoPlay() {
    _timer = Timer.periodic(const Duration(seconds: 3), (Timer timer) {
      if (_pageController.hasClients) {
        int nextPage = _pageController.page!.toInt() + 1;

        // Go back to the first page if we're on the last page
        if (nextPage >= _bannerImage.length) {
          nextPage = 0;
        }

        _pageController.animateToPage(
          nextPage,
          duration: const Duration(milliseconds: 600),
          curve: Curves.easeInOut,
        );
      }
    });
  }

  @override
  void dispose() {
    _pageController.dispose();
    _timer?.cancel(); // Cancel the timer when disposing
    super.dispose();
  }

  // Build the indicator bubbles
  Widget buildIndicator() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: _bannerImage.asMap().entries.map((entry) {
        return AnimatedContainer(
          duration: const Duration(milliseconds: 600),
          width: _currentPage == entry.key ? 12.0 : 8.0,
          height: 8.0,
          margin: const EdgeInsets.symmetric(horizontal: 4.0),
          decoration: BoxDecoration(
            shape: BoxShape.circle,
            color: _currentPage == entry.key
                ? Colors.black
                : Colors.grey, // Active bubble is black, others are grey
          ),
        );
      }).toList(),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Container(
          height: 140,
          width: double.infinity,
          decoration: BoxDecoration(
            color: const Color.fromARGB(255, 224, 223, 222),
            borderRadius:
                BorderRadius.circular(20), // Border radius for the container
          ),
          child: _bannerImage.isEmpty
              ? Center(child: Text("There is no banner here"))
              : PageView.builder(
                  controller: _pageController, // Link the PageController
                  itemCount: _bannerImage.length,
                  onPageChanged: (page) {
                    // Update _currentPage when user swipes manually
                    setState(() {
                      _currentPage = page;
                    });
                  },
                  itemBuilder: (context, index) {
                    return ClipRRect(
                      borderRadius: BorderRadius.circular(15),
                      child: Image.network(
                        _bannerImage[index],
                        fit: BoxFit.cover,
                      ),
                    );
                  },
                ),
        ),
        const SizedBox(height: 6),
        buildIndicator(), // Add the indicator row
      ],
    );
  }
}
