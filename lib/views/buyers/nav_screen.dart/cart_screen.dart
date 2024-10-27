import 'dart:ffi';

import 'package:flutter/material.dart';

class CartScreen extends StatefulWidget {
  const CartScreen({super.key});

  @override
  State<CartScreen> createState() => _CartScreenState();
}

class _CartScreenState extends State<CartScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              "Your Shopping cart is Empty",
              style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 20),
            Container(
              height: 40,
              width: MediaQuery.of(context).size.width - 60,
              decoration: BoxDecoration(
                color: Colors.yellow.shade800,
                borderRadius: BorderRadius.circular(10),
              ),
              child: Center(
                  child: Text(
                "CONTINUE SHOPPING",
                style: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                    color: Colors.white),
              )),
            ),
          ],
        ),
      ),
    );
  }
}
