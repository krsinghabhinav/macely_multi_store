import 'package:bestproviderproject/provider/product_provider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class AttributeScreen extends StatefulWidget {
  const AttributeScreen({super.key});

  @override
  State<AttributeScreen> createState() => _AttributeScreenState();
}

class _AttributeScreenState extends State<AttributeScreen>
    with AutomaticKeepAliveClientMixin {
  @override
  bool get wantKeepAlive => true;
  final TextEditingController _sizeController = TextEditingController();
  bool _entered = false;
  List<String> _sizeList = [];
  bool _isSave = false;

  @override
  void dispose() {
    _sizeController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    super.build(context);
    final ProductProvider productProvider =
        Provider.of<ProductProvider>(context);

    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20),
      child: Column(
        children: [
          // Brand text field
          TextFormField(
            onChanged: (value) {
              productProvider.getFormData(brandName: value);
            },
            decoration: const InputDecoration(
              labelText: 'Brand',
            ),
            validator: (value) {
              if (value!.isEmpty) {
                return 'Please Enter  Brand Name';
              } else {
                return null;
              }
            },
          ),
          // Row containing size input field and "Add" button
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              SizedBox(
                width: 70,
                child: TextFormField(
                  controller: _sizeController,
                  onChanged: (value) {
                    setState(() {
                      _entered = value.isNotEmpty;
                    });
                  },
                  decoration: const InputDecoration(
                    labelText: 'Size',
                  ),
                ),
              ),
              _entered
                  ? ElevatedButton(
                      onPressed: () {
                        setState(() {
                          _sizeList.add(_sizeController.text);
                          print(_sizeList);
                          _sizeController.clear();
                          // _entered = false;
                        });
                      },
                      style: ElevatedButton.styleFrom(
                        elevation: 4,
                        shape: ContinuousRectangleBorder(
                          borderRadius: BorderRadius.circular(20),
                        ),
                        backgroundColor: Colors.red,
                        foregroundColor: Colors.white,
                      ),
                      child: const Text(
                        'Add',
                        style: TextStyle(fontSize: 18),
                      ),
                    )
                  : const SizedBox.shrink(),
            ],
          ),
          const SizedBox(height: 10),
          // Size list display

          if (_sizeList.isNotEmpty)
            Container(
              height: 40,
              child: ListView.builder(
                scrollDirection: Axis.horizontal,
                itemCount: _sizeList.length,
                itemBuilder: (context, index) {
                  return Padding(
                    padding: const EdgeInsets.only(left: 8),
                    child: InkWell(
                      onTap: () {
                        setState(() {
                          _sizeList.removeAt(index);
                          productProvider.getFormData(sizeList: _sizeList);

                          print(_sizeList);
                        });
                      },
                      child: Container(
                        width: 50,
                        height: 30,
                        decoration: BoxDecoration(
                          color: Colors.yellow.shade800,
                          border: Border.all(color: Colors.black, width: 1),
                          borderRadius: BorderRadius.circular(8),
                        ),
                        alignment: Alignment.center,
                        child: Text(
                          _sizeList[index],
                          style: const TextStyle(
                            color: Colors.black,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                    ),
                  );
                },
              ),
            ),

          // Conditional "Save" button

          if (_sizeList.isNotEmpty)
            ElevatedButton(
              onPressed: () {
                setState(() {
                  _isSave = true;
                  productProvider.getFormData(sizeList: _sizeList);
                });
              },
              style: ElevatedButton.styleFrom(
                elevation: 4,
                shape: ContinuousRectangleBorder(
                  borderRadius: BorderRadius.circular(20),
                ),
                backgroundColor: Colors.red,
                foregroundColor: Colors.white,
              ),
              child: Text(
                _isSave ? 'Saved Size' : 'Save Size',
                style: const TextStyle(fontSize: 18),
              ),
            ),
        ],
      ),
    );
  }
}
