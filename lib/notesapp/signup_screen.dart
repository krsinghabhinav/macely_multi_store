import 'package:bestproviderproject/notesapp/providers/signup_provider.dart';
import 'package:bestproviderproject/notesapp/signin_screen.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class SignupScreen extends StatefulWidget {
  const SignupScreen({super.key});

  @override
  State<SignupScreen> createState() => _SignupScreenState();
}

class _SignupScreenState extends State<SignupScreen> {
  TextEditingController _phoneController = TextEditingController();
  TextEditingController _userNameController = TextEditingController();
  TextEditingController _emailController = TextEditingController();
  TextEditingController _passwordController = TextEditingController();
  final _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    final SignUpProvider _signupProvider = Provider.of<SignUpProvider>(context);

    return Scaffold(
      appBar: AppBar(
        title: Text('SingUp Screen'),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20),
          child: Center(
            child: Form(
              key: _formKey,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  TextFormField(
                    onChanged: (value) {
                      _signupProvider.setUserName(value);
                    },
                    // controller: _userNameController,
                    decoration: InputDecoration(
                      labelText: 'UserName',
                      border: OutlineInputBorder(),
                    ),
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Please enter the username';
                      }
                      return null; // No validation error
                    },
                  ),
                  SizedBox(
                    height: 20,
                  ),
                  TextFormField(
                    onChanged: (value) {
                      _signupProvider.setPhone(value);
                    },
                    // controller: _phoneController,
                    decoration: InputDecoration(
                      labelText: 'Phone',
                      border: OutlineInputBorder(),
                    ),
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Please enter the phone';
                      }
                      return null; // No validation error
                    },
                  ),
                  SizedBox(
                    height: 20,
                  ),
                  TextFormField(
                    // controller: _emailController,
                    onChanged: (value) {
                      _signupProvider.setEmail(value);
                    },
                    decoration: InputDecoration(
                      labelText: 'Email',
                      border: OutlineInputBorder(),
                    ),
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Please enter the email';
                      }
                      return null; // No validation error
                    },
                  ),
                  SizedBox(
                    height: 20,
                  ),
                  TextFormField(
                    // controller: _passwordController,
                    onChanged: (value) {
                      _signupProvider.setPassword(value);
                    },
                    decoration: InputDecoration(
                      labelText: 'password',
                      border: OutlineInputBorder(),
                    ),
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Please enter the password';
                      }
                      return null; // No validation error
                    },
                  ),
                  SizedBox(
                    height: 20,
                  ),
                  ElevatedButton(
                    onPressed: () {
                      if (_formKey.currentState!.validate()) {
                        _signupProvider.getSignUp(context);
                      }
                    },
                    child: _signupProvider.isLoding
                        ? CircularProgressIndicator()
                        : Text("SignUp"),
                  ),
                  Column(
                    children: [
                      TextButton(
                        onPressed: () {
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => NotesHomeScreen()));
                        },
                        child: Text('Already have an account SignIn'),
                      ),
                    ],
                  )
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
