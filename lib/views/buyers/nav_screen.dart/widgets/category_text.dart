import 'package:flutter/material.dart';

class CategoryText extends StatefulWidget {
  const CategoryText({super.key});

  @override
  State<CategoryText> createState() => _CategoryTextState();
}

class _CategoryTextState extends State<CategoryText> {
  final List<String> _categoriesLabel = [
    'Food',
    'Vegetable',
    'Egg',
    'Tea',
    'Coffee',
  ];

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        SizedBox(
          height: 8,
        ),
        Text(
          "Categories",
          style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
        ),
        SizedBox(height: 6),
        Container(
          height: 40, // Height is now consistent
          child: Row(
            children: [
              Expanded(
                child: ListView.builder(
                  scrollDirection: Axis.horizontal,
                  itemCount: _categoriesLabel.length,
                  itemBuilder: (context, index) {
                    return Padding(
                      padding: const EdgeInsets.symmetric(
                        horizontal: 3.0,
                      ),
                      child: ActionChip(
                        onPressed: () {},
                        backgroundColor: Colors.yellow.shade900,
                        label: Text(
                          _categoriesLabel[index],
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
        ),
      ],
    );
  }
}
