import 'package:flapkapchallenge/api/fetch_data.dart';
import 'package:flapkapchallenge/components/delivered_list_view.dart';
import 'package:flapkapchallenge/components/ordered_list_view.dart';
import 'package:flapkapchallenge/components/orders_metrics.dart';
import 'package:flapkapchallenge/components/returned_list_view.dart';
import 'package:flapkapchallenge/models/order_item.dart';
import 'package:flapkapchallenge/screens/graph_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class OrdersScreen extends StatelessWidget {
  final fetchData = FetchData();

  OrdersScreen({Key? key}) : super(key: key);

  final orderedList = <OrderItem>[];
  final deliveredList = <OrderItem>[];
  final returnedList = <OrderItem>[];

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
        future: fetchData.getOrders(),
        builder: (context, AsyncSnapshot<List<OrderItem>> snapshot) {
          if (snapshot.connectionState == ConnectionState.done) {
            classifyOrders(snapshot.data ?? []);
            return Scaffold(
              body: SafeArea(
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Stack(
                    children: [
                      ListView(
                        scrollDirection: Axis.vertical,
                        children: [
                          OrdersMetrics(
                            orders: snapshot.data ?? [],
                          ),
                          const SizedBox(
                            height: 10,
                          ),
                          const SizedBox(
                            height: 20,
                          ),
                          OrderedListView(orders: orderedList),
                          const SizedBox(
                            height: 40,
                          ),
                          DeliveredListView(orders: deliveredList),
                          const SizedBox(
                            height: 40,
                          ),
                          ReturnedListView(orders: returnedList),
                        ],
                      ),
                      Align(
                        alignment: Alignment.bottomRight,
                        child: MaterialButton(
                          height: 50,
                          textColor: Colors.white,
                          child: SvgPicture.asset(
                            'assets/graph.svg',
                            height: 25,
                            width: 25,
                          ),
                          shape: CircleBorder(),
                          color: Colors.white.withOpacity(0.6),
                          onPressed: () {
                            Navigator.of(context)
                                .push(GraphScreen.route(snapshot.data ?? []));
                          },
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            );
          } else {
            return const Scaffold(
              body: Center(
                child: CircularProgressIndicator(),
              ),
            );
          }
        });
  }

  classifyOrders(List<OrderItem> orders) {
    for (final order in orders) {
      if (order.status == "ORDERED") {
        orderedList.add(order);
      } else if (order.status == "DELIVERED") {
        deliveredList.add(order);
      } else if (order.status == "RETURNED") {
        returnedList.add(order);
      } else {
        throw Exception('Unknown Order Status');
      }
    }
  }
}
