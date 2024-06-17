import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:bill_generation/main.dart'; // Assuming this is your main.dart file
import 'package:bill_generation/second.dart'; // Assuming this is where SecondApp is defined

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

  void _loginUser(BuildContext context) async {
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

  void _registerUser(BuildContext context) async {
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

  void _resetPassword(BuildContext context) async {
    try {
      await FirebaseAuth.instance.sendPasswordResetEmail(email: emailController.text);
      final snackBar = SnackBar(
        content: Text('Password Reset Email Sent'),
      );
      ScaffoldMessenger.of(context).showSnackBar(snackBar);
    } catch (e) {
      final snackBar = SnackBar(
        content: Text('Error Sending Password Reset Email'),
      );
      ScaffoldMessenger.of(context).showSnackBar(snackBar);
      print('Password reset error: $e');
    }
  }

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
                          fontSize: 48,
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

                    const SizedBox(height: 10),
                    Padding(
                      padding: const EdgeInsets.only(left: 180.0),
                      child: GestureDetector(
                        onTap: () {
                          _resetPassword(context); // Call _resetPassword when the link is tapped
                        },
                        child: Text(
                          "Forgot Password?",
                          style: TextStyle(
                            color: Colors.blue,
                            fontWeight: FontWeight.bold,
                            decoration: TextDecoration.underline,
                          ),
                        ),
                      ),
                    ),
                    const SizedBox(height: 10),
                    Row(
                      children: [

                          ElevatedButton(
                            onPressed: () {
                              _loginUser(context); // Call _loginUser for login
                            },
                            child: Text(
                              "Lets Start",
                              style: TextStyle(
                                fontSize: 19,
                                fontWeight: FontWeight.bold,
                                color: Colors.white,
                              ),
                            ),
                            style: ElevatedButton.styleFrom(
                              //padding: EdgeInsets.symmetric(vertical: 5),
                              backgroundColor: Colors.blue,
                            ),
                        ),
                        SizedBox(width: 10),
                        Expanded(
                          child: ElevatedButton(
                            onPressed: () {
                              //_registerUser(context); // Call _registerUser for registration
                              Navigator.pushReplacement(
                                context,
                                MaterialPageRoute(builder: (context) => MyHomePage()),
                              );
                            },

                            child: Text(
                              "Create Account",
                              style: TextStyle(
                                fontSize: 19,
                                fontWeight: FontWeight.bold,
                                color: Colors.white,
                              ),
                            ),
                            style: ElevatedButton.styleFrom(
                              padding: EdgeInsets.symmetric(horizontal: 5,vertical: 5),
                              backgroundColor: Colors.black38,
                            ),
                          ),
                        ),
                      ],
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
