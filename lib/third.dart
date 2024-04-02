import 'package:flutter/material.dart';
import 'package:pdf/widgets.dart' as pw;
import 'package:pdf/pdf.dart';
import 'dart:io';
import 'package:path_provider/path_provider.dart';

class ThirdApp extends StatefulWidget {
  const ThirdApp({Key? key}) : super(key: key);

  @override
  State<ThirdApp> createState() => _ThirdAppState();
}

class Product {
  String name;
  String category;
  double price;
  int quantity;

  Product({
    required this.name,
    required this.category,
    required this.price,
    required this.quantity,
  });
}

class _ThirdAppState extends State<ThirdApp> {
  TextEditingController nameController = TextEditingController();
  TextEditingController categoryController = TextEditingController();
  TextEditingController priceController = TextEditingController();
  TextEditingController quantityController = TextEditingController();

  List<Product> cartItems = [];

  @override
  void dispose() {
    nameController.dispose();
    categoryController.dispose();
    priceController.dispose();
    quantityController.dispose();
    super.dispose();
  }

  double getTotalPrice() {
    double totalPrice = 0;
    for (var item in cartItems) {
      totalPrice += item.price * item.quantity;
    }
    return totalPrice;
  }

  Future<void> _generatePDF() async {
    final pdf = pw.Document();
    pdf.addPage(
      pw.Page(
        build: (pw.Context context) {
          return pw.Container(
            child: pw.Column(
              crossAxisAlignment: pw.CrossAxisAlignment.start,
              children: [
                pw.Text("Merchant Name: ${nameController.text}"),
                pw.Text("Customer Name: "), // Add customer name here
                pw.Text("Cart Items: "),
                pw.ListView.builder(
                  itemCount: cartItems.length,
                  itemBuilder: (context, index) {
                    final product = cartItems[index];
                    return pw.Text(
                        "Name: ${product.name}, Category: ${product.category}, Price: ${product.price}, Quantity: ${product.quantity}");
                  },
                ),
              ],
            ),
          );
        },
      ),
    );

    final timestamp = DateTime.now().millisecondsSinceEpoch;
    final output = await getExternalStorageDirectory();
    final file = File("${output!.path}/bill_$timestamp.pdf");
    await file.writeAsBytes(await pdf.save());

    // Show confirmation dialog for saving the PDF file
    final bool savePDF = await showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: Text("Save PDF?"),
        content: Text("Do you want to save the PDF file?"),
        actions: [
          TextButton(
            onPressed: () {
              Navigator.of(context).pop(true);
            },
            child: Text("Yes"),
          ),
          TextButton(
            onPressed: () {
              Navigator.of(context).pop(false);
            },
            child: Text("No"),
          ),
        ],
      ),
    );

    // If user wants to save the PDF, show confirmation dialog
    if (savePDF) {
      showDialog(
        context: context,
        builder: (context) => AlertDialog(
          title: Text("PDF Saved"),
          content: Text("PDF file saved at ${output.path}/bill_$timestamp.pdf"),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              child: Text("OK"),
            ),
          ],
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: Container(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
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
                      "Product Details ",
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
            SizedBox(height: 20),
            Padding(
              padding: const EdgeInsets.only(left: 20, right: 20),
              child: TextFormField(
                controller: nameController,
                decoration: InputDecoration(
                  border: OutlineInputBorder(),
                  hintText: "Product Name",
                ),
              ),
            ),
            SizedBox(height: 10),
            Padding(
              padding: const EdgeInsets.only(left: 20, right: 20, top: 15),
              child: TextFormField(
                controller: categoryController,
                decoration: InputDecoration(
                  border: OutlineInputBorder(),
                  hintText: "Product Category",
                ),
              ),
            ),
            SizedBox(height: 10),
            Padding(
              padding: const EdgeInsets.only(left: 20, right: 20, top: 15),
              child: Row(
                children: [
                  Expanded(
                    child: TextFormField(
                      controller: priceController,
                      decoration: InputDecoration(
                        border: OutlineInputBorder(),
                        hintText: "Product Price",
                      ),
                    ),
                  ),
                  SizedBox(width: 15),
                  Expanded(
                    child: TextFormField(
                      controller: quantityController,
                      decoration: InputDecoration(
                        border: OutlineInputBorder(),
                        hintText: "Product Quantity",
                      ),
                    ),
                  ),
                ],
              ),
            ),
            SizedBox(height: 20),
            Padding(
              padding: const EdgeInsets.only(left: 20),
              child: ElevatedButton(
                onPressed: () {
                  String name = nameController.text;
                  String category = categoryController.text;
                  double price =
                      double.tryParse(priceController.text) ?? 0.0;
                  int quantity =
                      int.tryParse(quantityController.text) ?? 0;
                  if (name.isNotEmpty &&
                      category.isNotEmpty &&
                      price > 0 &&
                      quantity > 0) {
                    setState(() {
                      cartItems.add(Product(
                        name: name,
                        category: category,
                        price: price,
                        quantity: quantity,
                      ));
                      // Clear the text fields
                      nameController.clear();
                      categoryController.clear();
                      priceController.clear();
                      quantityController.clear();
                    });
                  }
                },
                child: Text(
                  "Add to Cart",
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 20,
                  ),
                ),
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.blue,
                ),
              ),
            ),


            SizedBox(height: 5),
            Padding(
              padding: const EdgeInsets.only(left: 20, right: 20),
              child: const Text(
                "Cart Items",
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 18,
                ),
              ),
            ),
            SizedBox(height: 10),
            Expanded(
              child: SingleChildScrollView(
                child: Column(
                  children: [
                    ListView.builder(
                      shrinkWrap: true,
                      physics: const NeverScrollableScrollPhysics(),
                      itemCount: cartItems.length,
                      itemBuilder: (context, index) {
                        final product = cartItems[index];
                        // Calculate total price for each product
                        final totalPrice = product.price * product.quantity;
                        return ListTile(
                          title: Text(product.name),
                          subtitle: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                  "Category: ${product.category}\nPrice: \$${product.price}\nQuantity: ${product.quantity}"),
                              Text("Total Price: \$${totalPrice.toStringAsFixed(2)}"),
                            ],
                          ),
                        );
                      },
                    ),
                    // Display total price of all items
                    Text(
                      "Total Price: \$${getTotalPrice().toStringAsFixed(2)}",
                      style: TextStyle(
                          fontSize: 20,
                          color: Colors.blue,
                          fontWeight: FontWeight.bold
                      ),
                    ),
                  ],
                ),
              ),
            ),
            Row(
              children: [
                Padding(
                  padding: const EdgeInsets.only(left: 20),
                  child: Text(
                    "Total Price:",
                    style: TextStyle(
                        fontSize: 20,
                        color: Colors.blue,
                        fontWeight: FontWeight.bold
                    ),
                  ),
                ),


                Padding(
                  padding: const EdgeInsets.only(left: 30),
                  child: ElevatedButton(
                    onPressed: _generatePDF,
                    child: Text(
                      "Generate Bill",
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 20,
                      ),
                    ),
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.green,

                    ),
                  ),
                ),


              ],
            ),
          ],
        ),
      ),
    );
  }
}

void main() {
  runApp(MaterialApp(
    home: ThirdApp(),
  ));
}
