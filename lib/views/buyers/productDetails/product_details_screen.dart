import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class ProductDetailsScreen extends StatefulWidget {
  final dynamic productData;
  ProductDetailsScreen({super.key, required this.productData});

  @override
  State<ProductDetailsScreen> createState() => _ProductDetailsScreenState();
}

class _ProductDetailsScreenState extends State<ProductDetailsScreen> {
  String formateData(String data) {
    final inputFormat = DateFormat('dd/MM/yyyy'); // Define the input format
    final outputFormat = DateFormat('dd/MM/yyyy'); // Define the output format
    final dateTime = inputFormat.parse(data); // Parse the input date string
    final outputData = outputFormat.format(dateTime); // Format to output format
    return outputData;
  }

  String? _selectedSize;
  int _imageIndex = 0;
  // late PhotoViewController _photoViewController;
  // @override
  // void initState() {
  //   super.initState();
  //   _photoViewController = PhotoViewController()
  //     ..outputStateStream.listen((state) {
  //       // Automatically zoom in when released
  //       if (state.scale! < 1.0) {
  //         _photoViewController.scale = 1.0; // Reset scale to fit
  //       }
  //     });
  // }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        title: Text(widget.productData['productName']),
      ),
      body: SingleChildScrollView(
        child: Column(
          // mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Stack(
              children: [
                Container(
                  height: 230,
                  width: double.infinity,
                  child: GestureDetector(
                    onTap: () {
                      showDialog(
                        context: context,
                        builder: (BuildContext context) {
                          return Dialog(
                            backgroundColor:
                                Colors.transparent, // Transparent background
                            child: Container(
                              height: MediaQuery.of(context).size.height *
                                  0.6, // Half of screen height
                              width: MediaQuery.of(context).size.width *
                                  1, // Half of screen width
                              child: InteractiveViewer(
                                panEnabled:
                                    true, // Enable panning inside the popup
                                minScale: 1.0,
                                maxScale: 6.0, // Set maximum zoom level
                                child: Image.network(
                                  widget.productData['imageUrlList']
                                      [_imageIndex],
                                  fit: BoxFit.contain,
                                ),
                              ),
                            ),
                          );
                        },
                      );
                    },
                    child: Image.network(
                      widget.productData['imageUrlList'][_imageIndex],
                      fit: BoxFit.cover,
                    ),
                  ),
                ),
                Positioned(
                  bottom: 0,
                  left: 0, // Align to the left to occupy full width
                  right: 0, // Align to the right to occupy full width
                  child: Container(
                    height: 50,
                    child: ListView.builder(
                      scrollDirection:
                          Axis.horizontal, // Make the list horizontal
                      itemCount: widget.productData['imageUrlList'].length,
                      itemBuilder: (context, index) {
                        return InkWell(
                          onTap: () {
                            setState(() {
                              _imageIndex = index;
                            });
                          },
                          child: Container(
                            height: 50,
                            width: 50,
                            margin: EdgeInsets.symmetric(
                                horizontal: 4), // Add margin for spacing
                            child: Image.network(
                              widget.productData['imageUrlList'][index],
                              fit:
                                  BoxFit.cover, // Ensure image covers the space
                            ),
                          ),
                        );
                      },
                    ),
                  ),
                )
              ],
            ),
            SizedBox(
              height: 15,
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 15),
              child: Text(
                widget.productData['productName'],
                style: TextStyle(
                    fontSize: 25,
                    color: const Color.fromARGB(255, 0, 0, 0),
                    fontWeight: FontWeight.bold),
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 15),
              child: Row(
                children: [
                  Text(
                    'Price   ',
                    style: TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                      color: const Color.fromARGB(255, 0, 0, 0),
                    ),
                  ),
                  Text(
                    '\₹${widget.productData['productPrice'].toString()}',
                    style: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.w600,
                      color: Colors.green,
                    ),
                  ),
                ],
              ),
            ),
            ExpansionTile(
              title: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    'Product Decription',
                    style: TextStyle(
                      fontSize: 15,
                      fontWeight: FontWeight.w600,
                      color: const Color.fromARGB(255, 0, 0, 0),
                    ),
                  ),
                  Text(
                    'View more',
                    style: TextStyle(
                      fontSize: 15,
                      fontWeight: FontWeight.w600,
                      color: const Color.fromARGB(255, 247, 205, 20),
                    ),
                  ),
                ],
              ),
              children: [
                Center(
                  child: Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 15),
                    child: Text(
                      widget.productData['description'],
                      style: TextStyle(
                        fontSize: 15,
                        fontWeight: FontWeight.w400,
                        color: const Color.fromARGB(255, 99, 98, 98),
                      ),
                      textAlign: TextAlign.justify,
                    ),
                  ),
                ),
              ],
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 15),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    'This Product Will be Shipping On',
                    style: TextStyle(
                      fontSize: 15,
                      fontWeight: FontWeight.w500,
                      color: const Color.fromARGB(255, 0, 0, 0),
                    ),
                  ),
                  Text(
                    formateData(
                      widget.productData['scheduleDate'],
                    ),
                    style: TextStyle(
                      fontSize: 15,
                      fontWeight: FontWeight.w500,
                      color: const Color.fromARGB(255, 56, 191, 253),
                    ),
                  )
                ],
              ),
            ),
            ExpansionTile(
              title: Text('Available Size'),
              initiallyExpanded: true,
              children: [
                Container(
                  height: 50,
                  alignment: Alignment.centerLeft,
                  child: ListView.builder(
                    shrinkWrap: true,
                    scrollDirection: Axis.horizontal,
                    itemCount: widget.productData['sizeList'].length,
                    itemBuilder: (context, index) {
                      return Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: OutlinedButton(
                          onPressed: () {
                            setState(() {
                              _selectedSize =
                                  widget.productData['sizeList'][index];
                            });
                            print("_selectedSize======${_selectedSize}");
                          },
                          child: Text(widget.productData['sizeList'][index]),
                        ),
                      );
                    },
                  ),
                ),
              ],
            )
          ],
        ),
      ),
      bottomSheet: Container(
        height: 50,
        width: MediaQuery.of(context).size.width,
        decoration: BoxDecoration(color: Colors.yellow.shade900),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Icon(
                CupertinoIcons.cart,
                size: 28,
                color: Colors.white,
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Text('ADD TO CART',
                  style: TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.w500,
                    color: const Color.fromARGB(255, 255, 255, 255),
                  )),
            ),
          ],
        ),
      ),
    );
  }
}
