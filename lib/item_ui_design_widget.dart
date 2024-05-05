import 'package:furniture_app/item_details_screen.dart';
import 'package:furniture_app/items.dart';
import 'package:flutter/material.dart';

class ItemUIDesignWidget extends StatefulWidget {
  Items? itemsInfo;
  BuildContext? context;

  ItemUIDesignWidget({
    this.itemsInfo,
    this.context,
  });

  @override
  State<ItemUIDesignWidget> createState() => _ItemUIDesignWidgetState();
}

class _ItemUIDesignWidgetState extends State<ItemUIDesignWidget> {
  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        //send user to the item detail screen
        Navigator.push(
            context,
            MaterialPageRoute(
                builder: (c) => ItemDetailsScreen(
                      clickedItemInfo: widget.itemsInfo,
                    )));
      },
      splashColor: Colors.black,
      child: Padding(
        padding: const EdgeInsets.all(6.0),
        child: SizedBox(
          height: 180,
          width: MediaQuery.of(context).size.width,
          child: Row(
            children: [
              //image
              Image.network(
                widget.itemsInfo!.itemImage.toString(),
                width: 140,
                height: 140,
              ),

              const SizedBox(
                width: 4.0,
              ),

              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const SizedBox(height: 15),

                    //item name
                    Expanded(
                      child: Text(
                        widget.itemsInfo!.itemName.toString(),
                        maxLines: 2,
                        style: const TextStyle(
                          color: Color.fromARGB(255, 2, 82, 219),
                          fontSize: 25,
                          fontWeight: FontWeight.w800,
                        ),
                      ),
                    ),

                    //seller name
                    Expanded(
                      child: Text(
                        widget.itemsInfo!.sellerName.toString(),
                        maxLines: 2,
                        style: const TextStyle(
                          color: Color.fromARGB(255, 86, 138, 250),
                          fontSize: 25,
                        ),
                      ),
                    ),

                    //show discount badge - 50% OFF badge
                    //price origional
                    // new price
                    Row(
                      children: [
                        //50% OFF badge
                        Container(
                          decoration: const BoxDecoration(
                            shape: BoxShape.rectangle,
                            color: Color.fromARGB(255, 86, 138, 250),
                          ),
                          alignment: Alignment.topLeft,
                          width: 40,
                          height: 44,
                          child: const Center(
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Text(
                                  "50%",
                                  style: TextStyle(
                                    fontSize: 15.0,
                                    color: Colors.white,
                                    fontWeight: FontWeight.w700,
                                  ),
                                ),
                                Text(
                                  "OFF",
                                  style: TextStyle(
                                    fontSize: 12.0,
                                    color: Colors.white,
                                    fontWeight: FontWeight.w700,
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),

                        const SizedBox(
                          width: 10,
                        ),

                        //origional price
                        //new price
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            //origional price
                            Row(
                              children: [
                                const Text(
                                  "Origional Price: \$",
                                  style: TextStyle(
                                    fontSize: 14,
                                    color: Colors.black,
                                    decoration: TextDecoration.lineThrough,
                                    fontWeight: FontWeight.w500,
                                  ),
                                ),
                                Text(
                                  (double.parse(widget.itemsInfo!.itemPrice!) +
                                          double.parse(
                                              widget.itemsInfo!.itemPrice!))
                                      .toString(),
                                  style: const TextStyle(
                                    fontSize: 16,
                                    color: Colors.black,
                                    decoration: TextDecoration.lineThrough,
                                  ),
                                ),
                              ],
                            ),

                            //new price
                            Row(
                              children: [
                                const Text(
                                  "New Price: ",
                                  style: TextStyle(
                                    fontSize: 14,
                                    color: Colors.black,
                                    fontWeight: FontWeight.w500,
                                  ),
                                ),
                                const Text(
                                  "\$",
                                  style: TextStyle(
                                    fontSize: 25,
                                    color: Color.fromARGB(255, 86, 138, 250),
                                  ),
                                ),
                                Text(
                                  widget.itemsInfo!.itemPrice.toString(),
                                  style: const TextStyle(
                                    fontSize: 25,
                                    color: Color.fromARGB(255, 86, 138, 250),
                                  ),
                                ),
                              ],
                            ),
                          ],
                        ),
                      ],
                    ),

                    const SizedBox(
                      height: 8.0,
                    ),

                    const Divider(
                      height: 4,
                      color: Colors.white70,
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
