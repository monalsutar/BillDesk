import 'package:flutter/material.dart';
import 'package:pdf/widgets.dart' as pw;
import 'package:pdf/pdf.dart';
import 'package:mailer/mailer.dart';
import 'package:mailer/smtp_server/gmail.dart'; 
import 'dart:io';
import 'package:url_launcher/url_launcher.dart';
import 'package:path_provider/path_provider.dart';

class ThirdApp extends StatefulWidget {
  final String customerEmail;
  final String merchantName;
  const ThirdApp({Key? key, required this.customerEmail, required this.merchantName}) : super(key: key);

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

  _launchEmail(String email) async {
    final Uri _emailLaunchUri = Uri(
      scheme: 'mailto',
      path: email,
      queryParameters: {
        'subject': 'Your\tFinal\tBill\tBy\tBillDesk',
        'body': _generateEmailBody(), // Call a function to generate email body
      },
    );

    if (await canLaunch(_emailLaunchUri.toString())) {
      await launch(_emailLaunchUri.toString());
    } else {
      throw 'Could not launch email';
    }
    try {
      if (await canLaunch(_emailLaunchUri.toString())) {
        await launch(_emailLaunchUri.toString());
      } else {
        throw 'Could not launch email';
      }
    } catch (e) {
      print('Error launching email: $e');
    }
  }


  String _generateEmailBody() {
    String body = 'Dear\tCustomer,\n\n'
        'Here\tis\tthe\tlist\tof\titems\tin\tyour\tbill:\n\n';

    for (var item in cartItems) {
      body += 'Name:\t${item.name}\n'
          'Category:\t${item.category}\n'
          'Price:\tRs\t${item.price}\n'
          'Quantity:\t${item.quantity}\n'
          '---------------------------------------\n';
    }

    body += '\nTotal\tPrice:\tRs\t${getTPrice().toStringAsFixed(2)}\n\n'
        'Thank\tyou\tfor\tshopping\twith\tus!\n\n'
        'Best\tregards,\n'
        'Merchant\tName,\t${widget.merchantName}';


    // No need to encode the email body
    return body;
  }

  double getTPrice() {
    double totalPrice = 0;
    for (var item in cartItems) {
      totalPrice += item.price * item.quantity;
    }
    return totalPrice;
  }


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
      appBar: AppBar(
        title: Padding(
          padding:
          const EdgeInsets.only(top: 28,bottom: 5,left: 150),
          child: Image.asset(
            'assets/images/logo.png', // Adjust the path as per your project structure
            width: 250,
            height: 190,
            // You can adjust width and height as per your logo size
          ),
        ),
      ),
      body: SingleChildScrollView(
        child: Container(
          child: Padding(
            padding: const EdgeInsets.only(top: 20.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Container(
                  width: MediaQuery.of(context).size.width,
                  height: 60,
                  color: Colors.blue,
                  child: Row(
                    children: [
                      Padding(
                        padding: const EdgeInsets.only(left: 20),
                        child: Text(
                          "Product Details ",
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 18,
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
                  padding: const EdgeInsets.only(left: 15,right: 15), // Remove the left padding
                  child: SizedBox(
                    width: MediaQuery.of(context).size.width, // Set the width to the device width
                    child: ElevatedButton(
                      onPressed: () {
                        String name = nameController.text;
                        String category = categoryController.text;
                        double price = double.tryParse(priceController.text) ?? 0.0;
                        int quantity = int.tryParse(quantityController.text) ?? 0;
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
                ),


                SizedBox(height: 5),
                const Padding(
                  padding: EdgeInsets.only(left: 24, right: 20),
                  child: Text(
                    "Cart Items:",
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 18,
                    ),
                  ),
                ),

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
                              "Category: ${product.category}\nPrice: \Rs ${product.price}\nQuantity: ${product.quantity}"),
                          Text(
                            "Total Price: \Rs ${totalPrice.toStringAsFixed(2)}",
                          ),
                        ],
                      ),
                    );
                  },
                ),
                Padding(
                  padding: const EdgeInsets.only(left: 80,bottom: 10,top: 10),
                  child: Text(
                    "Total Price: \Rs ${getTotalPrice().toStringAsFixed(2)}",
                    style: TextStyle(
                        fontSize: 20,
                        color: Colors.blue,
                        fontWeight: FontWeight.bold,
                      backgroundColor: Colors.yellow
                    ),
                  ),
                ),
                // Display total price of all items
                Row(
                  children: [

                    Padding(
                      padding: const EdgeInsets.only(left: 5, bottom: 10),
                      child: ElevatedButton(
                        onPressed: _generatePDF,
                        child: Text(
                          "Save Bill PDF",
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
                    Padding(
                      padding: const EdgeInsets.only(left: 4, bottom: 10),
                      child: ElevatedButton(
                        onPressed: () {
                          _launchEmail(widget.customerEmail);
                        },
                        child: Text(
                          "Send Bill Mail",
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 20,
                          ),
                        ),
                        style: ElevatedButton.styleFrom(
                          backgroundColor:
                              Colors.orange, // You can adjust the color as needed
                        ),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
