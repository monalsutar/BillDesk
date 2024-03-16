import 'package:flutter/material.dart';
import 'package:bill_generation/second.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: MyHomePage(),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({Key? key}) : super(key: key);

  @override
  _MyHomePageState createState() => _MyHomePageState();
}



class _MyHomePageState extends State<MyHomePage> {

  TextEditingController merchantname = new TextEditingController();

  @override
  void dispose(){
    merchantname.dispose();
    super.dispose();
  }

  void getStarted(BuildContext context, String mname) {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => SecondApp(mname),
      ),
    );
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
                //fit: BoxFit.fill,
              ),
            ),
            const SizedBox(height: 10),
            Container(
              //height: MediaQuery.sizeOf(context).height,
              //height: double.infinity,
              width: MediaQuery.sizeOf(context).width,
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
                    const TextField(
                      decoration: InputDecoration(
                        border: OutlineInputBorder(),
                        hintText: "Category",
                        prefixIcon: Icon(Icons.category)
                      ),
                    ),
                    const SizedBox(height: 20),
                    Row(
                      children: [
                        ElevatedButton(
                          onPressed: () {
                            String mname = merchantname.text;
                            print("Name: $mname");

                            getStarted(context,mname);

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
                        SizedBox(width: 85),
                        TextButton(
                          onPressed: () {},
                          child: Text(
                            "Continue",
                            style: TextStyle(
                              fontSize: 18,
                              fontWeight: FontWeight.bold,
                              color: Colors.black,
                            ),
                          ),
                          style: TextButton.styleFrom(
                            backgroundColor: Colors.grey,
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
