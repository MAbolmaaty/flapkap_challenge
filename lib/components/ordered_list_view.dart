import 'package:flapkapchallenge/components/order_tile.dart';
import 'package:flapkapchallenge/models/order_item.dart';
import 'package:flutter/material.dart';

class OrderedListView extends StatelessWidget {
  final List<OrderItem> orders;

  const OrderedListView({Key? key, required this.orders}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text(
          'Ordered Items',
          style: TextStyle(fontSize: 19, fontWeight: FontWeight.w700),
        ),
        const SizedBox(
          height: 20,
        ),
        Container(
          height: 250,
          color: Colors.transparent,
          child: ListView.separated(
              scrollDirection: Axis.horizontal,
              itemBuilder: (context, index) {
                return OrderTile(orderItem: orders[index]);
              },
              separatorBuilder: (context, index) {
                return const SizedBox(
                  width: 16,
                );
              },
              itemCount: orders.length),
        ),
      ],
    );
  }
}
