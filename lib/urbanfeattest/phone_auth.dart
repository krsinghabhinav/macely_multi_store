import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'home_screen.dart'; // Import HomeScreen after authentication

class PhoneAuthScreen extends StatefulWidget {
  @override
  _PhoneAuthScreenState createState() => _PhoneAuthScreenState();
}

class _PhoneAuthScreenState extends State<PhoneAuthScreen> {
  final _phoneController = TextEditingController();
  final _otpController = TextEditingController();
  FirebaseAuth _auth = FirebaseAuth.instance;

  String _verificationId = "";
  bool _otpSent = false;
  bool _loading = false;

  // Function to send OTP
  Future<void> _sendOTP() async {
    setState(() {
      _loading = true;
    });

    await _auth.verifyPhoneNumber(
      phoneNumber: "+91${_phoneController.text}",
      verificationCompleted: (PhoneAuthCredential credential) async {
        await _auth.signInWithCredential(credential);
        _navigateToHomeScreen();
      },
      verificationFailed: (FirebaseAuthException e) {
        setState(() {
          _loading = false;
        });
        print('Error: ${e.message}');
      },
      codeSent: (String verificationId, int? resendToken) {
        setState(() {
          _loading = false;
          _otpSent = true;
          _verificationId = verificationId;
        });
      },
      codeAutoRetrievalTimeout: (String verificationId) {},
    );
  }

  // Function to verify OTP
  Future<void> _verifyOTP() async {
    setState(() {
      _loading = true;
    });

    try {
      PhoneAuthCredential credential = PhoneAuthProvider.credential(
        verificationId: _verificationId,
        smsCode: _otpController.text,
      );

      await _auth.signInWithCredential(credential);
      _navigateToHomeScreen();
    } catch (e) {
      setState(() {
        _loading = false;
      });
      print('Error: ${e.toString()}');
    }
  }

  // Navigate to Home Screen
  void _navigateToHomeScreen() {
    setState(() {
      _loading = false;
    });
    Navigator.pushReplacement(
      context,
      MaterialPageRoute(builder: (context) => HomeScreen()),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Phone Authentication'),
      ),
      body: Padding(
        padding: EdgeInsets.all(16.0),
        child: Column(
          children: [
            TextField(
              controller: _phoneController,
              decoration: InputDecoration(
                labelText: 'Phone Number',
                prefixText: '+91',
              ),
              keyboardType: TextInputType.phone,
            ),
            SizedBox(height: 20),
            _otpSent
                ? TextField(
                    controller: _otpController,
                    decoration: InputDecoration(
                      labelText: 'Enter OTP',
                    ),
                    keyboardType: TextInputType.number,
                  )
                : Container(),
            SizedBox(height: 20),
            _loading
                ? CircularProgressIndicator()
                : ElevatedButton(
                    onPressed: _otpSent ? _verifyOTP : _sendOTP,
                    child: Text(_otpSent ? 'Verify OTP' : 'Send OTP'),
                  ),
          ],
        ),
      ),
    );
  }
}
