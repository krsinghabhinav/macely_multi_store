import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class WelcomeText extends StatelessWidget {
  const WelcomeText({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(left: 10, right: 10),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            "Howdy, What Are You\n Looking For 👀 ",
            style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
          ),
          Container(
            child: SvgPicture.asset("assets/icons/cart.svg"),
          )
        ],
      ),
    );
  }
}
