import 'dart:io';
import 'package:bestproviderproject/provider/product_provider.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:image_picker/image_picker.dart';
import 'package:provider/provider.dart';
import 'package:uuid/uuid.dart';

class ImagesScreen extends StatefulWidget {
  const ImagesScreen({super.key});

  @override
  State<ImagesScreen> createState() => _ImagesScreenState();
}

class _ImagesScreenState extends State<ImagesScreen>
    with AutomaticKeepAliveClientMixin {
  @override
  bool get wantKeepAlive => true;
  final FirebaseStorage _storage = FirebaseStorage.instance;

  final ImagePicker _picker = ImagePicker();
  List<File> _image = [];
  List<String> _imageUrlsList = [];
  bool _isUploaded = false;
  chooseImage() async {
    final pickedFile = await _picker.pickImage(
      source: ImageSource.gallery,
    );
    if (pickedFile == null) {
      print('no image picked');
    } else {
      setState(() {
        _image.add(File(pickedFile.path));
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    super.build(context);
    final ProductProvider _productProvider =
        Provider.of<ProductProvider>(context);

    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 5, vertical: 10),
      child: Column(
        children: [
          GridView.builder(
            shrinkWrap: true,
            physics: NeverScrollableScrollPhysics(),
            gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 3,
              mainAxisSpacing: 5,
              crossAxisSpacing: 5,
              childAspectRatio:
                  5 / 6, // Aspect ratio 1:1 for equal width and height
            ),
            itemCount: _image.length + 1,
            itemBuilder: (context, index) {
              return index == 0
                  ? Center(
                      child: IconButton(
                        onPressed: () {
                          chooseImage();
                        },
                        icon: Icon(Icons.add),
                      ),
                    )
                  : Container(
                      width: 100, // Fixed width
                      height: 100, // Fixed height
                      decoration: BoxDecoration(
                        image: DecorationImage(
                          image: FileImage(_image[index - 1]),
                          fit: BoxFit
                              .cover, // Ensures the image fits within the container
                        ),
                        borderRadius: BorderRadius.circular(
                            8), // Optional: for rounded corners
                      ),
                    );
            },
          ),
          SizedBox(
            height: 20,
          ),
          _image.isNotEmpty
              ? ElevatedButton(
                  onPressed: () async {
                    EasyLoading.show(status: 'Saving Images');
                    for (var img in _image) {
                      print(img.path);

                      Reference ref = _storage
                          .ref()
                          .child('ProductImage')
                          .child(Uuid().v4());
                      await ref.putFile(img).whenComplete(() async {
                        await ref.getDownloadURL().then((value) {
                          setState(() {
                            _isUploaded = true;
                            _imageUrlsList.add(value);
                          });
                        });
                      });
                    }
                    setState(() {
                      _productProvider.getFormData(
                          imageUrlList: _imageUrlsList);
                      print(
                        _productProvider.productData['imageUrlList'],
                      );
                      EasyLoading.dismiss();
                    });
                  },
                  style: ElevatedButton.styleFrom(
                    elevation: 4,
                    shape: ContinuousRectangleBorder(
                        borderRadius: BorderRadius.circular(20)),
                    backgroundColor: Colors.red,
                    foregroundColor: Colors.white,
                  ),
                  child: _isUploaded
                      ? Text(
                          'Uploaded',
                          style: TextStyle(
                              color: const Color.fromARGB(255, 255, 255, 255),
                              fontSize: 18),
                        )
                      : Text(
                          'Upload',
                          style: TextStyle(
                              color: const Color.fromARGB(255, 255, 255, 255),
                              fontSize: 18),
                        ))
              : Text('')
        ],
      ),
    );
  }
}
