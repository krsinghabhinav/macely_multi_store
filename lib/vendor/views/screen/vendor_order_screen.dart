import 'package:flutter/material.dart';

class VendorOrderScreen extends StatefulWidget {
  const VendorOrderScreen({super.key});

  @override
  State<VendorOrderScreen> createState() => _VendorOrderScreenState();
}

class _VendorOrderScreenState extends State<VendorOrderScreen> {
  @override
  Widget build(BuildContext context) {
    return Center(child: Text('Vendor Order Screen'));
  }
}
