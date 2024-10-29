import 'package:bestproviderproject/provider/product_provider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class ShippingScreen extends StatefulWidget {
  const ShippingScreen({super.key});

  @override
  State<ShippingScreen> createState() => _ShippingScreenState();
}

class _ShippingScreenState extends State<ShippingScreen>
    with AutomaticKeepAliveClientMixin {
  @override
  bool get wantKeepAlive => true;
  bool _chargeShipping = false; // Changed to non-nullable bool

  @override
  Widget build(BuildContext context) {
    super.build(context);
    final ProductProvider _productProvider =
        Provider.of<ProductProvider>(context);

    return Column(
      children: [
        CheckboxListTile(
          title: Text(
            'Charge Shipping',
            style: TextStyle(
                fontSize: 18, fontWeight: FontWeight.w500, letterSpacing: 2),
          ),
          value: _chargeShipping,
          onChanged: (value) {
            // Ensure value is not null
            setState(() {
              _chargeShipping =
                  value ?? false; // Use `?? false` to ensure a default
              _productProvider.getFormData(chargeShipping: _chargeShipping);
              print("chargeshipping value ===========$_chargeShipping");
              print(
                  "chargeshipping value ===========${_productProvider.productData['chargeShipping']}");
            });
          },
        ),
        if (_chargeShipping) // No need for `== true`
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 15),
            child: TextFormField(
              onChanged: (value) {
                if (value.isNotEmpty) {
                  _productProvider.getFormData(
                    shipingCharge: int.parse(value),
                  );
                }
              },
              keyboardType: TextInputType.number,
              decoration: InputDecoration(labelText: 'Shipping Charge'),
              validator: (value) {
                if (value!.isEmpty) {
                  return 'Please Enter Shipping Charge';
                }
                return null;
              },
            ),
          ),
      ],
    );
  }
}
