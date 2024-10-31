// import 'package:cloud_firestore/cloud_firestore.dart';
// import 'package:flutter/material.dart';

// class HomeProductWidget extends StatefulWidget {
//   final String categoryName;
//   const HomeProductWidget({super.key, required this.categoryName});

//   @override
//   State<HomeProductWidget> createState() => _HomeProductWidgetState();
// }

// class _HomeProductWidgetState extends State<HomeProductWidget> {
//   late final Stream<QuerySnapshot> _productStream = FirebaseFirestore.instance
//       .collection('products')
//       .where('category', isEqualTo: widget.categoryName)
//       .snapshots();

//   @override
//   Widget build(BuildContext context) {
//     return StreamBuilder<QuerySnapshot>(
//       stream: _productStream,
//       builder: (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
//         if (snapshot.hasError) {
//           return const Center(child: Text('Something went wrong'));
//         }

//         if (snapshot.connectionState == ConnectionState.waiting) {
//           return const Center(child: CircularProgressIndicator());
//         }

//         return Container(
//           height: 200,
//           child: ListView.separated(
//               itemBuilder: (context, index) {
//                 final productData = snapshot.data!.docs[index];
//                 return Text(productData['productName']);
//               },
//               separatorBuilder: (context, _) => SizedBox(
//                     width: 15,
//                   ),
//               itemCount: snapshot.data!.docs.length),
//         );
//       },
//     );
//   }
// }




// *************************************************************


// import 'package:cloud_firestore/cloud_firestore.dart';
// import 'package:flutter/material.dart';

// class HomeProductWidget extends StatefulWidget {
//   final String categoryName;
//   const HomeProductWidget({super.key, required this.categoryName});

//   @override
//   State<HomeProductWidget> createState() => _HomeProductWidgetState();
// }

// class _HomeProductWidgetState extends State<HomeProductWidget> {
//   late Stream<QuerySnapshot> _productStream;

//   @override
//   void initState() {
//     super.initState();
//     _updateProductStream(widget.categoryName);
//   }

//   void _updateProductStream(String categoryName) {
//     setState(() {
//       _productStream = FirebaseFirestore.instance
//           .collection('products')
//           .where('category', isEqualTo: categoryName)
//           .snapshots();
//     });
//   }

//   @override
//   void didUpdateWidget(covariant HomeProductWidget oldWidget) {
//     super.didUpdateWidget(oldWidget);
//     if (oldWidget.categoryName != widget.categoryName) {
//       _updateProductStream(widget.categoryName);
//     }
//   }

//   void _showImageDialog(List<String> imageUrlList, int initialIndex) {
//     showDialog(
//       context: context,
//       builder: (BuildContext context) {
//         return Dialog(
//           child: Container(
//             width: MediaQuery.of(context).size.width * 0.8,
//             height: MediaQuery.of(context).size.height *
//                 0.5, // Adjust height as needed
//             child: PageView.builder(
//               itemCount: imageUrlList.length,
//               controller: PageController(initialPage: initialIndex),
//               itemBuilder: (context, index) {
//                 return Image.network(
//                   imageUrlList[index],
//                   fit: BoxFit.cover,
//                 );
//               },
//             ),
//           ),
//         );
//       },
//     );
//   }

//   @override
//   Widget build(BuildContext context) {
//     return StreamBuilder<QuerySnapshot>(
//       stream: _productStream,
//       builder: (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
//         if (snapshot.hasError) {
//           return const Center(child: Text('Something went wrong'));
//         }

//         if (snapshot.connectionState == ConnectionState.waiting) {
//           return const Center(child: CircularProgressIndicator());
//         }

//         return Container(
//           height: 220,
//           child: ListView.separated(
//             scrollDirection: Axis.horizontal,
//             itemBuilder: (context, index) {
//               final productsData = snapshot.data!.docs[index];
//               final imageUrlList =
//                   productsData['imageUrlList'] as List<dynamic>;

//               return Container(
//                 width: MediaQuery.of(context).size.width,
//                 child: ListView.builder(
//                   scrollDirection: Axis.horizontal,
//                   itemCount: imageUrlList.length,
//                   itemBuilder: (context, imageIndex) {
//                     final imageUrl = imageUrlList[imageIndex];
//                     return GestureDetector(
//                       onTap: () => _showImageDialog(
//                           imageUrlList.map((e) => e.toString()).toList(),
//                           imageIndex), // Pass all images and current index
//                       child: Container(
//                         width: 20, // Width for each image
//                         margin: const EdgeInsets.only(
//                             right: 5), // Spacing between images
//                         child: Image.network(
//                           imageUrl,
//                           fit: BoxFit.cover,
//                         ),
//                       ),
//                     );
//                   },
//                 ),
//               );
//             },
//             separatorBuilder: (context, _) => const SizedBox(width: 15),
//             itemCount: snapshot.data!.docs.length,
//           ),
//         );
//       },
//     );
//   }
// }


// *****************************************************
// import 'package:cloud_firestore/cloud_firestore.dart';
// import 'package:flutter/material.dart';

// class HomeProductWidget extends StatefulWidget {
//   final String categoryName;
//   const HomeProductWidget({super.key, required this.categoryName});

//   @override
//   State<HomeProductWidget> createState() => _HomeProductWidgetState();
// }

// class _HomeProductWidgetState extends State<HomeProductWidget> {
//   late Stream<QuerySnapshot> _productStream;

//   @override
//   void initState() {
//     super.initState();
//     _updateProductStream(widget.categoryName);
//   }

//   void _updateProductStream(String categoryName) {
//     setState(() {
//       _productStream = FirebaseFirestore.instance
//           .collection('products')
//           .where('category', isEqualTo: categoryName)
//           .snapshots();
//     });
//   }

//   @override
//   void didUpdateWidget(covariant HomeProductWidget oldWidget) {
//     super.didUpdateWidget(oldWidget);
//     if (oldWidget.categoryName != widget.categoryName) {
//       _updateProductStream(widget.categoryName);
//     }
//   }

//   @override
//   Widget build(BuildContext context) {
//     final screenWidth = MediaQuery.of(context).size.width;
//     final cardWidth = screenWidth * 0.5; // 50% of screen width
//     final cardHeight = 1.2 * cardWidth; // Maintain aspect ratio
//     final imageHeight = cardHeight * 0.7; // 70% of card height
//     final padding = EdgeInsets.symmetric(
//         horizontal: screenWidth * 0.025); // 2.5% of screen width

//     return StreamBuilder<QuerySnapshot>(
//       stream: _productStream,
//       builder: (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
//         if (snapshot.hasError) {
//           return const Center(child: Text('Something went wrong'));
//         }

//         if (snapshot.connectionState == ConnectionState.waiting) {
//           return const Center(child: CircularProgressIndicator());
//         }

//         return Container(
//           height: cardHeight,
//           child: ListView.separated(
//             scrollDirection: Axis.horizontal,
//             itemCount: snapshot.data!.docs.length,
//             itemBuilder: (context, index) {
//               final productsData = snapshot.data!.docs[index];
//               final imageUrlList =
//                   productsData['imageUrlList'] as List<dynamic>;

//               return Card(
//                 elevation: 3,
//                 shape: RoundedRectangleBorder(
//                   borderRadius: BorderRadius.circular(10),
//                 ),
//                 child: Column(
//                   crossAxisAlignment: CrossAxisAlignment.start,
//                   children: [
//                     Container(
//                       height: imageHeight,
//                       width: cardWidth,
//                       child: ClipRRect(
//                         borderRadius: BorderRadius.only(
//                           topLeft: Radius.circular(10),
//                           topRight: Radius.circular(10),
//                         ),
//                         child: ListView.builder(
//                           scrollDirection: Axis.horizontal,
//                           itemCount: imageUrlList.length,
//                           itemBuilder: (context, imageIndex) {
//                             return Container(
//                               margin: EdgeInsets.only(right: 3),
//                               width: cardWidth, // Set width to match card width
//                               child: Image.network(
//                                 imageUrlList[imageIndex],
//                                 height: imageHeight,
//                                 fit: BoxFit.cover,
//                               ),
//                             );
//                           },
//                         ),
//                       ),
//                     ),
//                     Padding(
//                       padding: padding,
//                       child: SizedBox(
//                         width: cardWidth - 18, // Adjusted width for text
//                         child: Row(
//                           mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                           children: [
//                             ConstrainedBox(
//                               constraints: BoxConstraints(
//                                   maxWidth: cardWidth * 0.55), // Set max width
//                               child: Text(
//                                 productsData['productName'] ?? 'Product Name',
//                                 style: TextStyle(
//                                   fontSize: 18,
//                                   letterSpacing: 1.2,
//                                   fontWeight: FontWeight.bold,
//                                 ),
//                                 overflow: TextOverflow.ellipsis,
//                               ),
//                             ),
//                             Text(
//                               '₹ ${productsData['productPrice']}',
//                               style: TextStyle(
//                                 fontSize: 14,
//                                 color: Colors.green,
//                               ),
//                             ),
//                           ],
//                         ),
//                       ),
//                     ),
//                     Padding(
//                       padding: padding,
//                       child: Text(
//                         'Brand ${productsData['brandName']}',
//                         style: TextStyle(
//                           fontSize: 16,
//                           fontWeight: FontWeight.w400,
//                         ),
//                       ),
//                     ),
//                   ],
//                 ),
//               );
//             },
//             separatorBuilder: (context, _) =>
//                 SizedBox(width: screenWidth * 0.04), // Space between cards
//           ),
//         );
//       },
//     );
//   }
// }


// **********************************
// PhotoView(
//                     imageProvider: NetworkImage(
//                       widget.productData['imageUrlList'][_imageIndex],
//                     ),
//                     minScale: PhotoViewComputedScale.contained,
//                     maxScale: PhotoViewComputedScale.covered,
//                     heroAttributes:
//                         const PhotoViewHeroAttributes(tag: 'imageHero'),
//                   ),