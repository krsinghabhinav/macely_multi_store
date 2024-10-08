import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

class SearchInputWidget extends StatelessWidget {
  const SearchInputWidget({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return ClipRRect(
      borderRadius: BorderRadius.circular(40),
      child: Container(
          height: 45, // Set the height of the TextField

          child: TextField(
            decoration: InputDecoration(
              fillColor: const Color.fromARGB(255, 235, 233, 233),
              filled: true,
              hintText: "Search For Product",
              border: const OutlineInputBorder(borderSide: BorderSide.none),
              prefixIcon: Padding(
                padding: const EdgeInsets.all(12.0), // Adjust padding if needed
                child: SvgPicture.asset(
                  "assets/icons/search-svgrepo-com (1).svg",
                  color: Colors.black, // Set the icon color to black
                ),
              ),
            ),
          )),
    );
  }
}
