import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/foundation.dart';

class UpdateProvider with ChangeNotifier {
  final _auth = FirebaseAuth.instance;
}
