import 'package:bestproviderproject/notesapp/providers/foraget_provider.dart';
import 'package:bestproviderproject/notesapp/signin_screen.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class ForgetPassword extends StatefulWidget {
  const ForgetPassword({super.key});

  @override
  State<ForgetPassword> createState() => _ForgetPasswordState();
}

class _ForgetPasswordState extends State<ForgetPassword> {
  @override
  Widget build(BuildContext context) {
    final ForagetProvider _foragetProvider =
        Provider.of<ForagetProvider>(context);

    return Scaffold(
      appBar: AppBar(
        title: Text('Forget Possword'),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              TextFormField(
                  onChanged: (value) {
                    _foragetProvider.setEmail(value);
                  },
                  decoration: InputDecoration(
                    labelText: 'Phone',
                    border: OutlineInputBorder(),
                  )),
              SizedBox(
                height: 20,
              ),
              SizedBox(
                height: 20,
              ),
              ElevatedButton(
                onPressed: () {
                  _foragetProvider.getForgetPassword(context);
                },
                child: Text("Forget Password"),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
