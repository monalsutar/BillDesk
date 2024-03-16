import 'package:flutter/material.dart';

class ThirdApp extends StatefulWidget {
  const ThirdApp({Key? key}) : super(key: key);

  @override
  State<ThirdApp> createState() => _ThirdAppState();
}

class _ThirdAppState extends State<ThirdApp> {

  TextEditingController name = new TextEditingController();

  @override
  void dispose(){
    name.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        //title: Text("Third Screen"),
      ),
      body: SingleChildScrollView(
        child: Container(
          child: Column(
            children: [
              Container(
                width: MediaQuery.of(context).size.width,
                height: 70,
                color: Colors.blue,
                child: const Row(
                  children: [
                    Padding(
                      padding: const EdgeInsets.all(15),
                      child: Text(
                        "Customer Name: ",
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 20,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              SizedBox(height: 20),
              const Text(
                "Product Details",
                style: TextStyle(fontWeight: FontWeight.bold, fontSize: 21),
              ),
              SizedBox(height: 20),
              Column(
                children: [
                  Padding(
                    padding: const EdgeInsets.only(left: 15, right: 15, bottom: 10),
                    child: TextFormField(
                      decoration: InputDecoration(
                          border: OutlineInputBorder(),
                          hintText: "Product Name",
                          hintStyle: TextStyle(fontSize: 16),
                          prefixIcon: Icon(Icons.person)
                      ),
                      controller: name,
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(left: 15, right: 15, bottom: 10),
                    child: TextFormField(
                      decoration: InputDecoration(
                          border: OutlineInputBorder(),
                          hintText: "Product Category",
                          hintStyle: TextStyle(fontSize: 16),
                          prefixIcon: Icon(Icons.category)
                      ),
                    ),
                  ),
                  Row(
                    children: [
                      Expanded(
                        child: Padding(
                          padding: const EdgeInsets.only(left: 15, right: 7.5, bottom: 10),
                          child: TextFormField(
                            decoration: InputDecoration(
                                border: OutlineInputBorder(),
                                hintText: "Product Price",
                                hintStyle: TextStyle(fontSize: 16),
                                prefixIcon: Icon(Icons.currency_rupee)
                            ),
                          ),
                        ),
                      ),
                      Expanded(
                        child: Padding(
                          padding: const EdgeInsets.only(left: 7.5, right: 15, bottom: 15),
                          child: TextFormField(
                            decoration: InputDecoration(
                                border: OutlineInputBorder(),
                                hintText: "Product Quantity",
                                hintStyle: TextStyle(fontSize: 16),

                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                  Padding(
                    padding: const EdgeInsets.all(15),
                    child: Row(
                      children: [

                        Expanded(
                            child: ElevatedButton(
                              onPressed: () {
                                String name1 = name.text;
                                print('Name: $name1');
                              },
                              child: Text(
                                "Add to Cart",
                                style: TextStyle(
                                    fontSize: 16, fontWeight: FontWeight.bold, color: Colors.white),
                              ),
                              style: ElevatedButton.styleFrom(backgroundColor: Colors.blue),
                            ),
                        ),
                        SizedBox(width: 20),

                        Expanded(
                          child: ElevatedButton(
                            onPressed: () {},
                            child: Text(
                              "New Product",
                              style: TextStyle(
                                  fontSize: 16, fontWeight: FontWeight.bold, color: Colors.white),
                            ),
                            style: ElevatedButton.styleFrom(backgroundColor: Colors.blue),
                          ),
                        ),

                      ],
                    ),
                  )
                ],
              )
            ],
          ),
        ),
      ),
    );
  }
}
