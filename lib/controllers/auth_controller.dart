import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

class AuthController {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  Future<String> signUpUsers(String email, String fullName, String phoneNumber,
      String password) async {
    String res = "Somr error occured";

    try {
      if (email.isNotEmpty &&
          fullName.isNotEmpty &&
          phoneNumber.isNotEmpty &&
          password.isNotEmpty) {
        // Create a new user document
        UserCredential credential = await _auth.createUserWithEmailAndPassword(
            email: email, password: password);

        // Store additional information in Firestore
        await _firestore.collection("buyers").doc(credential.user!.uid).set({
          "email": email,
          "fullName": fullName,
          "phoneNumber": phoneNumber,
          "password": password,
          "buyserId": credential.user!.uid,
          "address": "",
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
