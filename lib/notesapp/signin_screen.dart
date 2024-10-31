import 'package:bestproviderproject/notesapp/providers/signIn_provider.dart';
import 'package:bestproviderproject/notesapp/signup_screen.dart';
import 'package:firebase_ui_auth/firebase_ui_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class NotesHomeScreen extends StatefulWidget {
  const NotesHomeScreen({super.key});

  @override
  State<NotesHomeScreen> createState() => _NotesHomeScreenState();
}

class _NotesHomeScreenState extends State<NotesHomeScreen> {
  @override
  Widget build(BuildContext context) {
    final SingInProvider _singInProvider = Provider.of<SingInProvider>(context);

    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        title: Text('SingIn Screen'),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              TextFormField(
                  onChanged: (value) {
                    _singInProvider.setEmail(value);
                  },
                  decoration: InputDecoration(
                    labelText: 'Email',
                    border: OutlineInputBorder(),
                  )),
              SizedBox(
                height: 20,
              ),
              TextFormField(
                onChanged: (value) {
                  _singInProvider.setPassword(value);
                },
                decoration: InputDecoration(
                  labelText: 'password',
                  border: OutlineInputBorder(),
                ),
              ),
              SizedBox(
                height: 20,
              ),
              ElevatedButton(
                onPressed: () {
                  _singInProvider.getLoginIn(context);
                },
                child: _singInProvider.isLoading
                    ? CircularProgressIndicator()
                    : Text("Login"),
              ),
              Column(
                children: [
                  TextButton(
                    onPressed: () {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => ForgotPasswordScreen()));
                    },
                    child: Text('Forget Password'),
                  ),
                  TextButton(
                    onPressed: () {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => SignupScreen()));
                    },
                    child: Text('Don\'t have an account SignUp'),
                  ),
                ],
              )
            ],
          ),
        ),
      ),
    );
  }
}
