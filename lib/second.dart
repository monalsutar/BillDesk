import 'package:flutter/material.dart';
import 'package:bill_generation/third.dart';

class SecondApp extends StatefulWidget {
  final String mname;
  final String cat;

  SecondApp(this.mname, this.cat, {Key? key}) : super(key: key);

  @override
  State<SecondApp> createState() => _SecondAppState();
}

class _SecondAppState extends State<SecondApp> {
  TextEditingController customerNameController = TextEditingController();
  TextEditingController phoneNumberController = TextEditingController();

  @override
  void dispose() {
    customerNameController.dispose();
    phoneNumberController.dispose();
    super.dispose();
  }

  void resetTextFields() {
    customerNameController.clear();
    phoneNumberController.clear();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: SingleChildScrollView(
        child: Container(
          child: Column(
            children: [
              Container(
                width: MediaQuery.of(context).size.width,
                height: 70,
                color: Colors.blue,
                child: Row(
                  children: [
                    Padding(
                      padding: const EdgeInsets.all(15),
                      child: Text(
                        "Merchant Name: " + widget.mname,
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 17,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              SizedBox(height: 40),
              Text(
                "Customer Details",
                style: TextStyle(fontWeight: FontWeight.bold, fontSize: 35),
              ),
              SizedBox(height: 20),
              Container(
                child: Padding(
                  padding: const EdgeInsets.all(25),
                  child: Column(
                    children: [
                      TextField(
                        controller: customerNameController,
                        decoration: InputDecoration(
                          border: OutlineInputBorder(),
                          hintText: "Customer Name:",
                          hintStyle: TextStyle(fontSize: 18.6),
                          prefixIcon: Icon(Icons.person),
                        ),
                      ),
                      SizedBox(height: 29),
                      TextField(
                        controller: phoneNumberController,
                        decoration: InputDecoration(
                          border: OutlineInputBorder(),
                          hintText: "Phone Number:",
                          hintStyle: TextStyle(fontSize: 18.6),
                          prefixIcon: Icon(Icons.phone),
                        ),
                      ),
                      SizedBox(height: 35),
                      Row(
                        children: [
                          ElevatedButton(
                            onPressed: () {
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (context) => ThirdApp(),
                                ),
                              );
                            },
                            child: Text(
                              "Done",
                              style: TextStyle(
                                color: Colors.white,
                                fontSize: 20,
                              ),
                            ),
                            style: ElevatedButton.styleFrom(
                              backgroundColor: Colors.blue,
                            ),
                          ),
                          SizedBox(width: 62),
                          ElevatedButton(
                            onPressed: () {
                              resetTextFields();
                            },
                            child: Text(
                              "New Customer",
                              style: TextStyle(
                                color: Colors.white,
                                fontSize: 20,
                              ),
                            ),
                            style: ElevatedButton.styleFrom(
                              backgroundColor: Colors.black26,
                            ),
                          ),
                        ],
                      )
                    ],
                  ),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
