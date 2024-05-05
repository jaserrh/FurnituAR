import 'package:flutter/material.dart';
import 'package:furniture_app/items.dart';

class BuyScreen extends StatelessWidget {
  Items item;
  BuyScreen({super.key, required this.item});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Color.fromARGB(255, 86, 138, 250),
        title: const Text("Seller Information"),
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Center(
            child: Text(
              item.sellerName!,
              style: const TextStyle(
                fontSize: 40,
                color: Color.fromARGB(255, 86, 138, 250),
                fontWeight: FontWeight.w900,
              ),
            ),
          ),
          Center(
            child: Text(
              item.sellerLocation!,
              style: const TextStyle(
                fontSize: 40,
                color: Color.fromARGB(255, 86, 138, 250),
                fontWeight: FontWeight.w900,
              ),
            ),
          ),
          Center(
            child: Text(
              item.sellerPhone!,
              style: const TextStyle(
                fontSize: 40,
                color: Color.fromARGB(255, 86, 138, 250),
                fontWeight: FontWeight.w900,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
