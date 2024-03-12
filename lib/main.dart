import 'package:flutter/material.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        body: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [

            Container(
              margin: EdgeInsets.only(top: 60, left: 10),
              child: Image.asset(
                "assets/images/logo.png",
                width: 190,
                height: 50,
                fit: BoxFit.fill,
              ),
            ),


            const SizedBox(height: 10),
            Container(
              height: 650,
              width: 500,

              child: Padding(
                padding: const EdgeInsets.all(40.0),
                child: Column(
                  children: [
                    const Text(
                            "Calculate your bills easily with us",
                          style: TextStyle(
                            fontSize: 48,
                            fontWeight: FontWeight.bold,
                            fontFamily: 'Ariel',
                            //color: Colors.blueGrey
                          ),
                          textAlign: TextAlign.left,

                    ),
                    const SizedBox(height: 10,),
                    const Text(
                        "Enter merchant details below and get started",

                      style: TextStyle(
                        fontSize: 15,
                        fontWeight: FontWeight.bold
                      ),
                      textAlign: TextAlign.left,
                    ),
                    const SizedBox(height: 50),
                    const TextField(
                      decoration: InputDecoration(
                          border: OutlineInputBorder(),
                          hintText: "Merchant Name"
                      ),
                    ),
                    const SizedBox(height: 18),
                    const TextField(
                      decoration: InputDecoration(
                          border: OutlineInputBorder(),
                          hintText: "Category"
                      ),
                    ),

                    const SizedBox(height: 50),
                    Row(
                      children: [
                        TextButton(
                          onPressed: () {
                            print("Button pressed");
                          },
                          child: Text(
                            "Get Started",
                            style:
                            TextStyle(
                              fontSize: 18,
                              fontWeight: FontWeight.bold,
                              color: Colors.white, // You can customize the text color
                            ),
                          ),
                          style: TextButton.styleFrom(
                            backgroundColor: Colors.blue, // You can customize the button background color
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
