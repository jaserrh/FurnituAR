import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_speed_dial/flutter_speed_dial.dart';
import 'package:furniture_app/buy_screen.dart';
import 'package:furniture_app/items.dart';
import 'package:furniture_app/login.dart';
import 'package:furniture_app/virtual_ar_view_screen.dart';
import 'package:flutter/material.dart';

class ItemDetailsScreen extends StatefulWidget {
  Items? clickedItemInfo;

  ItemDetailsScreen({
    this.clickedItemInfo,
  });
  @override
  State<ItemDetailsScreen> createState() => _ItemDetailsScreenState();
}

class _ItemDetailsScreenState extends State<ItemDetailsScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Color.fromARGB(255, 86, 138, 250),
        title: Text(
          widget.clickedItemInfo!.itemName.toString(),
        ),
      ),
      floatingActionButton: SpeedDial(
        animatedIcon: AnimatedIcons.menu_arrow,
        children: [
          SpeedDialChild(
              child: const Icon(Icons.mobile_screen_share_rounded),
              label: "AR View",
              onTap: () {
                Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (c) => VirtualARViewScreen(
                              clickedItemImageLink:
                                  widget.clickedItemInfo!.itemImage.toString(),
                            )));
              }),
          SpeedDialChild(
              child: const Icon(Icons.shopping_cart),
              label: "Buy Now",
              onTap: () {
                if (FirebaseAuth.instance.currentUser == null) {
                  Navigator.push(
                      context, MaterialPageRoute(builder: (c) => Login()));
                } else {
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (c) =>
                              BuyScreen(item: widget.clickedItemInfo!)));
                }
              }),
        ],
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Image.network(
                widget.clickedItemInfo!.itemImage.toString(),
              ),
              Padding(
                padding: const EdgeInsets.only(left: 8.0, top: 8.0),
                child: Text(
                  widget.clickedItemInfo!.itemName.toString(),
                  textAlign: TextAlign.justify,
                  style: const TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 20,
                    color: Colors.blue,
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(left: 8.0, right: 8.0, top: 6.0),
                child: Text(
                  widget.clickedItemInfo!.itemDescription.toString(),
                  textAlign: TextAlign.justify,
                  style: const TextStyle(
                    fontWeight: FontWeight.normal,
                    fontSize: 16,
                    color: Colors.blue,
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(10.0),
                child: Text(
                  widget.clickedItemInfo!.itemPrice.toString() + " \$",
                  textAlign: TextAlign.justify,
                  style: const TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 30,
                    color: Colors.blue,
                  ),
                ),
              ),
              const Padding(
                padding: EdgeInsets.only(left: 8.0, right: 310.0),
                child: Divider(
                  height: 1,
                  thickness: 2,
                  color: Colors.blue,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
