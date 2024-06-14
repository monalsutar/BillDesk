import 'package:flutter/material.dart';
import 'package:bill_generation/third.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:bill_generation/login.dart';

class SecondApp extends StatefulWidget {
  const SecondApp({
    Key? key, required String mname, required String cat,
  }) : super(key: key);

  @override
  State<SecondApp> createState() => _SecondAppState();
}

class _SecondAppState extends State<SecondApp> {
  TextEditingController customerEmailController = TextEditingController();
  TextEditingController phoneNumberController = TextEditingController();
  String merchantEmail = '';
  String merchantName ='';

  @override
  void initState() {
    super.initState();
    _loadMerchantEmail();
  }

  @override
  void dispose() {
    customerEmailController.dispose();
    phoneNumberController.dispose();
    super.dispose();
  }

  void _loadMerchantEmail() async {
    User? user = FirebaseAuth.instance.currentUser;
    setState(() {
      merchantEmail = user?.email ?? 'Unknown';
    });
  }

  void resetTextFields() {
    customerEmailController.clear();
    phoneNumberController.clear();
  }

  void logout(BuildContext context) async {
    await FirebaseAuth.instance.signOut();
    Navigator.pushAndRemoveUntil(
      context,
      MaterialPageRoute(builder: (context) => Login()), // Assuming you have a Login screen
          (Route<dynamic> route) => false,
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        actions: [
          // Add this IconButton to the AppBar
          IconButton(
            icon: Icon(Icons.logout),
            onPressed: () {
              logout(context);
            },
          ),
        ],
      ),
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
                        "Merchant: " + merchantEmail,
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
                        controller: customerEmailController,
                        decoration: InputDecoration(
                          border: OutlineInputBorder(),
                          hintText: "Customer Email",
                          hintStyle: TextStyle(fontSize: 18.6),
                          prefixIcon: Icon(Icons.person),
                        ),
                      ),
                      SizedBox(height: 29),
                      TextField(
                        controller: phoneNumberController,
                        decoration: InputDecoration(
                          border: OutlineInputBorder(),
                          hintText: "Phone Number",
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
                                  builder: (context) => ThirdApp(customerEmail: customerEmailController.text,merchantName: merchantEmail,),
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
                              backgroundColor: Colors.black38,
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
