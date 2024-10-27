import 'dart:typed_data';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:image_picker/image_picker.dart';

class VendorController {
  final FirebaseStorage _storage = FirebaseStorage.instance;
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  _uploadVendorImageToStorage(Uint8List? image) async {
    try {
      Reference ref =
          _storage.ref().child("storeImage").child(_auth.currentUser!.uid);
      UploadTask uploadTask = ref.putData(image!);
      TaskSnapshot snapshot = await uploadTask;
      String downloadTask = await snapshot.ref.getDownloadURL();
      return downloadTask;
    } catch (e) {
      print("Error uploading image: $e");
      return null;
    }
  }

  pickStoreImage(ImageSource source) async {
    try {
      final ImagePicker _imagePicker = ImagePicker();
      XFile? _file = await _imagePicker.pickImage(source: source);
      if (_file != null) {
        print("Image Selected: ${_file.path}");
        return await _file.readAsBytes(); // return the image bytes
      } else {
        print("No Image Selected");
        return null;
      }
    } catch (e) {
      print("Error picking image: $e");
      return null;
    }
  }

  Future<String> registerVendor(
    String bussinessName,
    String email,
    String phoneNumber,
    String countryValue,
    String stateValue,
    String cityValue,
    String taxRegister,
    String taxNumber,
    Uint8List? image,
  ) async {
    String res = 'some error occured';

    try {
      String uploadImage = await _uploadVendorImageToStorage(image);
      _firestore.collection('vendors').doc(_auth.currentUser!.uid).set({
        'bussinessName': bussinessName,
        'email': email,
        'phoneNumber': phoneNumber,
        'countryValue': countryValue,
        'stateValue': stateValue,
        'cityValue': cityValue,
        'taxRegister': taxRegister,
        'taxNumber': taxNumber,
        'image': uploadImage,
        'approved': false,
        'vendorId': _auth.currentUser!.uid,
      });
    } catch (e) {
      res = e.toString();
      print(e);
    }
    return res;
  }
}
