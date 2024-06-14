import 'package:bill_generation/firebase_options.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:bill_generation/login.dart';
import 'package:bill_generation/second.dart';
import 'splash_screen.dart';


void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: SplashScreen(),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({Key? key}) : super(key: key);


  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  TextEditingController merchantname = TextEditingController();
  TextEditingController email = TextEditingController();
  TextEditingController password = TextEditingController();
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();



  @override
  void dispose() {
    merchantname.dispose();
    email.dispose();
    password.dispose();
    super.dispose();
  }



  void getStarted(BuildContext context, String mname, String category) async {
    try {
      UserCredential userCredential =
      await FirebaseAuth.instance.createUserWithEmailAndPassword(
        email: email.text,
        password: password.text,
      );

      final snackBar = SnackBar(
        content: Text('Account created'),
      );
      ScaffoldMessenger.of(context).showSnackBar(snackBar);

      // User successfully signed up, now you can save additional user data or navigate to the next screen.
      // For example, you can save the merchant name along with the user ID to Firestore.

      // Navigate to the second screen after successful account creation
      Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) => SecondApp(
            mname: mname,
            cat: category,
          ),
        ),
      );
    } catch (e) {
      // Handle any errors that occur during sign up.
      final snackBar = SnackBar(
        content: Text('Error occuring'),
      );
      ScaffoldMessenger.of(context).showSnackBar(snackBar);
      // Show Snackbar for error
    }
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: _scaffoldKey,
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
                          fontSize: 43,
                          color: Colors.black,
                        ),
                        children: [
                          TextSpan(
                            text: "Calculate",
                            style: TextStyle(
                              color: Colors.blue,
                              fontSize: 51,
                            ),
                          ),
                          TextSpan(text: " your bills easily with us"),
                        ],
                      ),
                      textAlign: TextAlign.left,
                    ),
                    const SizedBox(height: 50),
                    TextField(
                      decoration: InputDecoration(
                        border: OutlineInputBorder(),
                        hintText: "Merchant Name",
                        prefixIcon: Icon(Icons.person),
                      ),
                      controller: merchantname,
                    ),
                    const SizedBox(height: 18),
                    TextField(
                      decoration: InputDecoration(
                        border: OutlineInputBorder(),
                        hintText: "Email",
                        prefixIcon: Icon(Icons.email),
                      ),
                      controller: email,
                    ),
                    const SizedBox(height: 18),
                    TextField(
                      obscureText: true, // Hides the entered text
                      decoration: InputDecoration(
                        border: OutlineInputBorder(),
                        hintText: "Password",
                        prefixIcon: Icon(Icons.password),
                      ),
                      controller: password,
                    ),
                    const SizedBox(height: 20),
                    Row(
                      children: [
                        ElevatedButton(
                          onPressed: () {
                            String mname = merchantname.text;
                            String category = password.text;
                            print("Name: $mname");
                            getStarted(context, mname, category);
                          },
                          child: Text(
                            "Get Started",
                            style: TextStyle(
                              fontSize: 18,
                              fontWeight: FontWeight.bold,
                              color: Colors.white,
                            ),
                          ),
                          style: ElevatedButton.styleFrom(
                            backgroundColor: Colors.blue,
                          ),
                        ),
                        SizedBox(width: 2),

                        TextButton(
                          onPressed: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) => Login(),
                              ),
                            );
                          },
                          child: Text(
                            "Continue Log in",
                            style: TextStyle(
                              fontSize: 18,
                              fontWeight: FontWeight.bold,
                              color: Colors.white,
                            ),
                          ),
                          style: TextButton.styleFrom(
                            backgroundColor: Colors.black38,
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
