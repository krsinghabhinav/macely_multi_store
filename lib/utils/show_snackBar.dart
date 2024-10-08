import 'package:flutter/material.dart';

void showSnack(BuildContext context, String title,
    {Color color = Colors.black}) {
  ScaffoldMessenger.of(context).showSnackBar(
    SnackBar(
      backgroundColor: color, // Use the passed or default color
      content: Text(
        title,
        style: TextStyle(
            color: Colors.white), // White text to contrast dark colors
      ),
    ),
  );
}
