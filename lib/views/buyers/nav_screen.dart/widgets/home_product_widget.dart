import 'package:bestproviderproject/views/buyers/productDetails/product_details_screen.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class HomeProductWidget extends StatefulWidget {
  final String categoryName;
  const HomeProductWidget({super.key, required this.categoryName});

  @override
  State<HomeProductWidget> createState() => _HomeProductWidgetState();
}

class _HomeProductWidgetState extends State<HomeProductWidget> {
  late Stream<QuerySnapshot> _productStream;

  @override
  void initState() {
    super.initState();
    _updateProductStream(widget.categoryName);
  }

  void _updateProductStream(String categoryName) {
    setState(() {
      _productStream = FirebaseFirestore.instance
          .collection('products')
          .where('category', isEqualTo: categoryName)
          .snapshots();
    });
  }

  @override
  void didUpdateWidget(covariant HomeProductWidget oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (oldWidget.categoryName != widget.categoryName) {
      _updateProductStream(widget.categoryName);
    }
  }

  @override
  Widget build(BuildContext context) {
    return StreamBuilder<QuerySnapshot>(
      stream: _productStream,
      builder: (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
        if (snapshot.hasError) {
          return const Center(child: Text('Something went wrong'));
        }

        if (snapshot.connectionState == ConnectionState.waiting) {
          return const Center(child: CircularProgressIndicator());
        }

        return Container(
          height: 240,
          child: ListView.separated(
            scrollDirection: Axis.horizontal,
            itemCount: snapshot.data!.docs.length,
            itemBuilder: (context, index) {
              final productsData = snapshot.data!.docs[index];
              final imageUrlList =
                  productsData['imageUrlList'] as List<dynamic>;

              return GestureDetector(
                onTap: () {
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (contex) =>
                              ProductDetailsScreen(productData: productsData)));
                },
                child: Card(
                  elevation: 3,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10),
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Container(
                        height: 170,
                        width: 190,
                        child: ListView.builder(
                          scrollDirection: Axis.horizontal,
                          itemCount: imageUrlList.length,
                          itemBuilder: (context, imageIndex) {
                            return Padding(
                                padding: const EdgeInsets.only(right: 8.0),
                                child: ClipRRect(
                                    borderRadius: BorderRadius.only(
                                      topLeft: Radius.circular(10),
                                      topRight: Radius.circular(10),
                                    ),
                                    child: ClipRRect(
                                      borderRadius: BorderRadius.only(
                                        topLeft: Radius.circular(10),
                                        topRight: Radius.circular(10),
                                      ),
                                      child: CachedNetworkImage(
                                        imageUrl: imageUrlList[imageIndex],
                                        height: 170,
                                        width: 200,
                                        fit: BoxFit.cover,
                                        placeholder: (context, url) =>
                                            Container(), // Optional placeholder while loading
                                        errorWidget: (context, url, error) =>
                                            Icon(Icons
                                                .error), // Optional error widget
                                      ),
                                    )));
                          },
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.symmetric(
                            vertical: 5.0, horizontal: 5),
                        child: SizedBox(
                          width: 180, // Set a fixed width for the Row
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              ConstrainedBox(
                                constraints: BoxConstraints(
                                    maxWidth: 130), // Set max width
                                child: Text(
                                  productsData['productName'] ?? 'Product Name',
                                  style: TextStyle(
                                    fontSize: 18,
                                    letterSpacing: 1.2,
                                    fontWeight: FontWeight.bold,
                                  ),
                                  overflow: TextOverflow.ellipsis,
                                ),
                              ),
                              // SizedBox(
                              //   height: 20,
                              // ),
                              Text(
                                '\₹ ${productsData['productPrice']}',
                                style: TextStyle(
                                  fontSize: 14,
                                  color: Colors.green,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 5),
                        child: Text(
                          'Brand ${productsData['brandName']}',
                          style: TextStyle(
                            fontSize: 16,
                            // letterSpacing: 1.2,
                            fontWeight: FontWeight.w400,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              );
            },
            separatorBuilder: (context, _) => const SizedBox(width: 15),
          ),
        );
      },
    );
  }
}
