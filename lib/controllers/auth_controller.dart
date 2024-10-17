import 'dart:typed_data';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:image_picker/image_picker.dart';

class AuthController {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  final FirebaseStorage _storage = FirebaseStorage.instance;
  String? profileName;

  uploadProfileImage(Uint8List image) async {
    Reference ref =
        _storage.ref().child("profileImage").child(_auth.currentUser!.uid);
    UploadTask uploadTask = ref.putData(image);
    TaskSnapshot snapshot = await uploadTask;
    String downlodurl = await snapshot.ref.getDownloadURL();
    return downlodurl;
  }

  pickerProfileImage(ImageSource source) async {
    final ImagePicker imagePicker = ImagePicker();
    XFile? _file = await imagePicker.pickImage(source: source);
    if (_file != null) {
      return _file.readAsBytes();
    } else {
      print('No image Selected');
    }
  }

  Future<String> signUpUsers(String email, String fullName, String phoneNumber,
      String password, Uint8List? image) async {
    String res = "Somr error occured";

    try {
      if (email.isNotEmpty &&
          fullName.isNotEmpty &&
          phoneNumber.isNotEmpty &&
          password.isNotEmpty &&
          image != null) {
        // Create a new user document
        UserCredential credential = await _auth.createUserWithEmailAndPassword(
            email: email, password: password);
        String profileImageUrl = await uploadProfileImage(image);

        // Store additional information in Firestore
        await _firestore.collection("buyers").doc(credential.user!.uid).set({
          "email": email,
          "fullName": fullName,
          "phoneNumber": phoneNumber,
          "password": password,
          "buyserId": credential.user!.uid,
          "address": "",
          "profileImage": profileImageUrl,
        });

        res = "success";
      } else {
        res = "Please fill all the fields";
      }
    } catch (e) {}
    return res;
  }

  loginUser(String email, String password) async {
    String res = "Somr error occured";
    try {
      if (email.isNotEmpty && password.isNotEmpty) {
        await _auth.signInWithEmailAndPassword(
            email: email, password: password);
        res = "success";
      } else {
        res = "Please Fill all the field";
      }
    } catch (e) {
      res = e.toString();
    }
    return res;
  }
}
