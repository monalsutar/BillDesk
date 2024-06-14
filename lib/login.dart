import 'package:bill_generation/main.dart';
import 'package:bill_generation/second.dart';
import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';

class Login extends StatefulWidget {
  const Login({Key? key}) : super(key: key);

  @override
  State<Login> createState() => _LoginState();
}

class _LoginState extends State<Login> {
  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();


  @override
  void dispose() {
    emailController.dispose();
    passwordController.dispose();
    super.dispose();
  }

  void _loginUser() async {
    try {
      UserCredential userCredential = await FirebaseAuth.instance.signInWithEmailAndPassword(
        email: emailController.text,
        password: passwordController.text,
      );

      final snackBar = SnackBar(
        content: Text('Login Successful'),
      );
      ScaffoldMessenger.of(context).showSnackBar(snackBar);

      // Navigate to the SecondApp after successful login
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(
          builder: (context) => SecondApp(
            mname: emailController.text, // Passing email as mname for demonstration
            cat: passwordController.text,
          ),
        ),
      );
    } catch (e) {
      final snackBar = SnackBar(
        content: Text('Login Failed'),
      );
      ScaffoldMessenger.of(context).showSnackBar(snackBar);

      // Handle login errors here
      print('Login error: $e');
    }
  }

  void _registerUser() async {
    try {
      UserCredential userCredential = await FirebaseAuth.instance.createUserWithEmailAndPassword(
        email: emailController.text,
        password: passwordController.text,
      );

      final snackBar = SnackBar(
        content: Text('Registration Successful'),
      );
      ScaffoldMessenger.of(context).showSnackBar(snackBar);

      // Navigate to the SecondApp after successful registration
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(
          builder: (context) => SecondApp(
            mname: emailController.text, // Passing email as mname for demonstration
            cat: passwordController.text,
          ),
        ),
      );
    } catch (e) {
      final snackBar = SnackBar(
        content: Text('Registration Failed'),
      );
      ScaffoldMessenger.of(context).showSnackBar(snackBar);

      // Handle registration errors here
      print('Registration error: $e');
    }
  }


  //
  // void getStarted(BuildContext context) async {
  //   try {
  //     UserCredential userCredential = await FirebaseAuth.instance.signInWithEmailAndPassword(
  //       email: emailController.text,
  //       password: passwordController.text,
  //     );
  //      final snackBar = SnackBar(
  //             content: Text('Login Successful'),
  //           );
  //           ScaffoldMessenger.of(context).showSnackBar(snackBar);
  //     // If login is successful, navigate to the next screen
  //     Navigator.push(
  //       context,
  //       MaterialPageRoute(
  //         builder: (context) => SecondApp( mname: emailController.text, // Passing email as mname for demonstration
  //         cat: passwordController.text,),
  //       ),
  //     );
  //   } catch (e) {
  //     // Handle login errors here
  // final snackBar = SnackBar(
  //             content: Text('Login Failed'),
  //           );
  //           ScaffoldMessenger.of(context).showSnackBar(snackBar);
  //     // If login is successful, navigate to the next screen
  //     // You can show an error message to the user if login fails
  //   }
  // }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              margin: EdgeInsets.only(top: 50, left: 10),
              child: Image.asset(
                "assets/images/logo.png",
                width: 190,
                height: 50,
              ),
            ),
            const SizedBox(height: 10),
            Container(
              width: MediaQuery.of(context).size.width,
              child: Padding(
                padding: const EdgeInsets.all(40.0),
                child: Column(
                  children: [
                    RichText(
                      text: TextSpan(
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 49,
                          color: Colors.black,
                        ),
                        children: [
                          TextSpan(
                            text: "Calculate",
                            style: TextStyle(
                              color: Colors.blue,
                              fontSize: 52,
                            ),
                          ),
                          TextSpan(text: " your bills easily with us"),
                        ],
                      ),
                      textAlign: TextAlign.left,
                    ),
                    const SizedBox(height: 50),
                    TextField(
                      controller: emailController,
                      decoration: InputDecoration(
                        border: OutlineInputBorder(),
                        hintText: "Email",
                        prefixIcon: Icon(Icons.email),
                      ),
                    ),
                    const SizedBox(height: 18),
                    TextField(
                      controller: passwordController,
                      decoration: InputDecoration(
                        border: OutlineInputBorder(),
                        hintText: "Password",
                        prefixIcon: Icon(Icons.password),
                      ),
                      obscureText: true,
                    ),
                    const SizedBox(height: 40),
                    TextButton(
                      onPressed: () {
                        _registerUser();
                      },
                      child: Text(
                        "Let's Start",
                        style: TextStyle(
                          fontSize: 19,
                          fontWeight: FontWeight.bold,
                          color: Colors.white,
                        ),
                      ),
                      style: TextButton.styleFrom(
                        backgroundColor: Colors.blue,
                      ),
                    ),

                    TextButton(
                      onPressed: () {
                        Navigator.pushReplacement(
                          context,
                          MaterialPageRoute(builder: (context) => MyApp()),
                        );
                      },
                      child: Text(
                        "SignUp",
                        style: TextStyle(
                          fontSize: 19,
                          fontWeight: FontWeight.bold,
                          color: Colors.white,
                        ),
                      ),
                      style: TextButton.styleFrom(
                        backgroundColor: Colors.blue,
                      ),
                    ),

                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

