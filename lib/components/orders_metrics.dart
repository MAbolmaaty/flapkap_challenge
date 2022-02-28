import 'package:flapkapchallenge/models/order_item.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class OrdersMetrics extends StatelessWidget {
  final List<OrderItem> orders;

  const OrdersMetrics({
    Key? key,
    required this.orders,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Row(
              children: [
                SvgPicture.asset(
                  'assets/total_count.svg',
                  height: 15,
                  width: 15,
                ),
                const SizedBox(
                  width: 5,
                ),
                const Text('Total Count : '),
                Text(orders.length.toString()),
              ],
            ),
            Row(
              children: [
                SvgPicture.asset(
                  'assets/returns.svg',
                  height: 15,
                  width: 15,
                ),
                const SizedBox(
                  width: 5,
                ),
                Text('Returns : ${calculateReturns()}'),
              ],
            ),
          ],
        ),
        const SizedBox(
          height: 20,
        ),
        Wrap(
          children: [
            SvgPicture.asset(
              'assets/average_price.svg',
              height: 15,
              width: 15,
            ),
            const SizedBox(
              width: 5,
            ),
            Text('Average Price : \$${calculateAveragePrice()}'),
          ],
        ),
      ],
    );
  }

  double calculateAveragePrice() {
    double total = 0.0;
    RegExp extractNumber = RegExp("\\d*,?\\d*\\.?\\d*\$");
    for (final order in orders) {
      var splits = extractNumber.allMatches(order.price).toList();
      String price = splits[0].group(0).toString();
      price = price.replaceAll(",", "");
      total += double.parse(price);
    }
    total = double.parse((total).toStringAsFixed(2));
    return total;
  }

  int calculateReturns() {
    int numOfReturns = 0;
    for (final order in orders) {
      if (order.status == "RETURNED") numOfReturns += 1;
    }
    return numOfReturns;
  }
}
