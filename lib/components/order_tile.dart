import 'package:flapkapchallenge/models/order_item.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class OrderTile extends StatelessWidget {
  OrderItem orderItem;

  OrderTile({Key? key, required this.orderItem}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      constraints: const BoxConstraints.expand(
        width: 270,
      ),
      decoration: BoxDecoration(
        image: DecorationImage(
          image: AssetImage(backgroundImage(orderItem.status)),
          fit: BoxFit.none,
        ),
      ),
      child: Stack(
        children: [
          Container(
            decoration: BoxDecoration(
              // 1
              color: Colors.black.withOpacity(0.4),
              // 2
              borderRadius: const BorderRadius.all(Radius.circular(10.0)),
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      orderItem.buyer,
                      style: TextStyle(color: Colors.white),
                    ),
                    Text(
                      orderItem.registered,
                      style: TextStyle(color: Colors.white, fontSize: 8),
                    )
                  ],
                ),
                Wrap(
                  children: createTagChips(),
                ),
                Align(
                  alignment: Alignment.bottomRight,
                  child: Wrap(
                    children: [
                      SvgPicture.asset(
                        'assets/company.svg',
                        height: 15,
                        width: 15,
                      ),
                      const SizedBox(width: 2.0),
                      Text(
                        orderItem.company,
                        style: TextStyle(color: Colors.white),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  List<Widget> createTagChips() {
    final chips = <Widget>[];
    orderItem.tags.forEach((element) {
      final chip = Chip(
        label: Text(
          element,
          style: TextStyle(color: Colors.white),
        ),
        backgroundColor: Colors.black.withOpacity(0.8),
      );
      chips.add(Padding(
        padding: const EdgeInsets.all(2.0),
        child: chip,
      ));
    });

    return chips;
  }

  String backgroundImage(String status) {
    if (status == "ORDERED") {
      return 'assets/ordered_package.png';
    } else if (status == "DELIVERED") {
      return 'assets/delivered_package.png';
    } else {
      return 'assets/returned_package.png';
    }
  }
}
