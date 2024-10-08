import 'package:bestproviderproject/utils/show_snackBar.dart';
import 'package:flutter/material.dart';

import '../../../controllers/auth_controller.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  final AuthController _authController = AuthController();

  late String email;
  late String password;

  _loginUser() async {
    if (_formKey.currentState!.validate()) {
      await _authController.loginUser(email, password);
      return showSnack(context, "You are now logged in ",
          color: const Color.fromARGB(255, 16, 129, 20));
    } else {
      return showSnack(context, "Please fill all the field ",
          color: Colors.red);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Form(
        key: _formKey,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Center(
              child: Text(
                "Login customer\'s account",
                style: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.w500,
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 25),
              child: TextFormField(
                onChanged: (value) {
                  email = value;
                },
                decoration: InputDecoration(
                  labelText: 'Enter email address',
                ),
                validator: (value) {
                  if (value!.isEmpty) {
                    return 'Please enter your email';
                  } else {
                    return null;
                  }
                },
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 25),
              child: TextFormField(
                onChanged: (value) {
                  password = value;
                },
                decoration: InputDecoration(
                  labelText: 'Enter Password',
                ),
                validator: (value) {
                  if (value!.isEmpty) {
                    return 'Please enter your password';
                  } else {
                    return null;
                  }
                },
              ),
            ),
            SizedBox(
              height: 20,
            ),
            GestureDetector(
              onTap: () {
                _loginUser();
              },
              child: Container(
                width: MediaQuery.of(context).size.width - 40,
                height: 50,
                decoration: BoxDecoration(
                  color: Colors.yellow.shade900,
                  borderRadius: BorderRadius.circular(10),
                ),
                child: Center(
                  child: Text(
                    "Login",
                    style: TextStyle(
                        letterSpacing: 1,
                        fontSize: 22,
                        fontWeight: FontWeight.w600,
                        color: Colors.white),
                  ),
                ),
              ),
            ),
            Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  "Need an account?",
                  style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.w600,
                  ),
                ),
                TextButton(
                    onPressed: () {},
                    child: Text(
                      "Register",
                      style: TextStyle(
                        color: Colors.blue,
                        fontSize: 18,
                        fontWeight: FontWeight.w600,
                      ),
                    ))
              ],
            )
          ],
        ),
      ),
    );
  }
}
