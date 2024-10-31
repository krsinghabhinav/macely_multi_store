import 'package:bestproviderproject/views/buyers/nav_screen.dart/widgets/home_product_widget.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class CategoryText extends StatefulWidget {
  const CategoryText({super.key});

  @override
  State<CategoryText> createState() => _CategoryTextState();
}

class _CategoryTextState extends State<CategoryText> {
  String? _selectedCategory;
  final Stream<QuerySnapshot> _categoryStream =
      FirebaseFirestore.instance.collection('categories').snapshots();

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const SizedBox(height: 8),
        const Text(
          "Categories",
          style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
        ),
        const SizedBox(height: 6),
        // Setting a fixed height for the StreamBuilder's ListView
        SizedBox(
          height: 50, // Adjust based on how many items you expect
          child: StreamBuilder<QuerySnapshot>(
            stream: _categoryStream,
            builder:
                (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
              if (snapshot.hasError) {
                return const Center(child: Text('Something went wrong'));
              }
              if (snapshot.connectionState == ConnectionState.waiting) {
                return const Center(child: CircularProgressIndicator());
              }
              if (!snapshot.hasData || snapshot.data!.docs.isEmpty) {
                return const Center(child: Text("No data available"));
              }

              // Set the selected category to the first category when data is received
              if (_selectedCategory == null) {
                _selectedCategory = snapshot.data!.docs[0]['categoryName'];
              }

              return Container(
                height: 50, // Height is now consistent
                child: Row(
                  children: [
                    Expanded(
                      child: ListView.builder(
                        scrollDirection: Axis.horizontal,
                        itemCount: snapshot.data!.docs.length,
                        itemBuilder: (context, index) {
                          final categoryData = snapshot.data!.docs[index];
                          return Padding(
                            padding: const EdgeInsets.symmetric(
                              horizontal: 3.0,
                            ),
                            child: ActionChip(
                              onPressed: () {
                                setState(() {
                                  _selectedCategory =
                                      categoryData['categoryName'];
                                });
                                print(_selectedCategory);
                              },
                              backgroundColor: Colors.yellow.shade900,
                              label: Text(
                                categoryData['categoryName'],
                                style: TextStyle(
                                  fontSize: 16,
                                  fontWeight: FontWeight.w500,
                                  color: Colors.white,
                                ),
                              ),
                            ),
                          );
                        },
                      ),
                    ),
                    InkWell(
                      onTap: () {},
                      child: Icon(Icons.arrow_forward_ios),
                    )
                  ],
                ),
              );
            },
          ),
        ),
        // Display the HomeProductWidget based on the selected category
        if (_selectedCategory != null)
          HomeProductWidget(categoryName: _selectedCategory!),
      ],
    );
  }
}
