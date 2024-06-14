import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:bill_generation/login.dart';
import 'package:bill_generation/second.dart';
import 'package:bill_generation/main.dart'; // Import your Main widget

class SplashScreen extends StatefulWidget {
  @override
  _SplashScreenState createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    super.initState();
    _checkLoginStatus();
  }

  void _checkLoginStatus() async {
    await Future.delayed(Duration(seconds: 2)); // Simulate a delay

    User? user = FirebaseAuth.instance.currentUser;

    if (user != null) {
      // Navigate to the SecondApp if the user is already logged in
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (context) => SecondApp(mname: user.displayName ?? '', cat: '')),
      );
    } else {
      // Navigate to the Login screen if the user is not logged in
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (context) => Login()), // Ensure this is the correct login screen
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Image.asset(
              "assets/images/logo.png",
              width: 190,
              height: 50,
            ),
            SizedBox(height: 20),
            CircularProgressIndicator(),
          ],
        ),
      ),
    );
  }
}
