import 'package:bestproviderproject/notesapp/note_main_screen.dart';
import 'package:bestproviderproject/notesapp/providers/signup_provider.dart';
import 'package:bestproviderproject/notesapp/signin_screen.dart';
import 'package:bestproviderproject/provider/product_provider.dart';
import 'package:bestproviderproject/views/buyers/auth/login_screen.dart';
import 'package:bestproviderproject/views/buyers/main_screen.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';

import 'package:firebase_core/firebase_core.dart';
import 'package:provider/provider.dart';
import 'firebase_options.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';

import 'notesapp/providers/createnote_provider.dart';
import 'notesapp/providers/delete_provider.dart';
import 'notesapp/providers/signIn_provider.dart';
import 'vendor/views/screen/main_vender_screen.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  runApp(const MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  User? user;
  @override
  void initState() {
    super.initState();
    user = FirebaseAuth.instance.currentUser;

    if (user != null) {
      print("user==========${user}");
      print("user==========${user!.uid.toString()}");
    } else {
      print("No user logged in.");
    }
  }

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    SystemChrome.setSystemUIOverlayStyle(
        SystemUiOverlayStyle(statusBarColor: Colors.transparent));
    return MultiProvider(
        providers: [
          ChangeNotifierProvider(create: (_) => ProductProvider()),
          ChangeNotifierProvider(create: (_) => SignUpProvider()),
          ChangeNotifierProvider(create: (_) => SingInProvider()),
          ChangeNotifierProvider(create: (_) => CreatenoteProvider()),
          ChangeNotifierProvider(create: (_) => DeleteProvider()),
        ],
        child: GetMaterialApp(
          debugShowCheckedModeBanner: false,
          title: 'Flutter Demo',
          theme: ThemeData(
            colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
            useMaterial3: true,
            fontFamily: 'Brand-Bold',
          ),
          // home: NotesHomeScreen(),
          home: user != null ? NoteMainScreen() : NotesHomeScreen(),
          builder: EasyLoading.init(),
        ));
  }
}
