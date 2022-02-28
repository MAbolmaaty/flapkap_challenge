import 'package:flapkapchallenge/models/order_item.dart';
import 'package:flutter/material.dart';
import 'package:syncfusion_flutter_charts/charts.dart';

class GraphScreen extends StatelessWidget {
  static Route<dynamic> route(List<OrderItem> orders) => MaterialPageRoute(
        builder: (context) => GraphScreen(
          orders: orders,
        ),
      );

  List<OrderItem> orders;

  GraphScreen({Key? key, required this.orders}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Orders Graph"),
        backgroundColor: Colors.grey,
      ),
      body: Center(
          child: Container(
              margin: EdgeInsets.all(8.0),
              child: SfCartesianChart(
                primaryXAxis: CategoryAxis(),
                series: <LineSeries<OrdersData, String>>[
                  LineSeries<OrdersData, String>(
                      // Bind data source
                      dataSource: analyzeData(),
                      xValueMapper: (OrdersData sales, _) => sales.month,
                      yValueMapper: (OrdersData sales, _) => sales.orders)
                ],
              ))),
    );
  }

  List<OrdersData> analyzeData() {
    List<OrdersData> ordersData = [];
    Map<String, int> ordersDataMap = {
      "Jan": 0,
      "Feb": 0,
      "Mar": 0,
      "Apr": 0,
      "May": 0,
      "Jun": 0,
      "Jul": 0,
      "Aug": 0,
      "Sep": 0,
      "Oct": 0,
      "Nov": 0,
      "Dec": 0,
    };
    for (final order in orders) {
      String date = order.registered;
      RegExp extractMonth = RegExp("-\\d*-");
      var splits = extractMonth.allMatches(date).toList();
      String month = splits[0].group(0).toString();
      month = month.replaceAll("-", "");
      switch (month) {
        case "01":
          ordersDataMap["Jan"] = (ordersDataMap["Jan"])!.toInt() + 1;
          break;
        case "02":
          ordersDataMap["Feb"] = (ordersDataMap["Feb"])!.toInt() + 1;
          break;
        case "03":
          ordersDataMap["Mar"] = (ordersDataMap["Mar"])!.toInt() + 1;
          break;
        case "04":
          ordersDataMap["Apr"] = (ordersDataMap["Apr"])!.toInt() + 1;
          break;
        case "05":
          ordersDataMap["May"] = (ordersDataMap["May"])!.toInt() + 1;
          break;
        case "06":
          ordersDataMap["Jun"] = (ordersDataMap["Jun"])!.toInt() + 1;
          break;
        case "07":
          ordersDataMap["Jul"] = (ordersDataMap["Jul"])!.toInt() + 1;
          break;
        case "08":
          ordersDataMap["Aug"] = (ordersDataMap["Aug"])!.toInt() + 1;
          break;
        case "09":
          ordersDataMap["Sep"] = (ordersDataMap["Sep"])!.toInt() + 1;
          break;
        case "10":
          ordersDataMap["Oct"] = (ordersDataMap["Oct"])!.toInt() + 1;
          break;
        case "11":
          ordersDataMap["Nov"] = (ordersDataMap["Nov"])!.toInt() + 1;
          break;
        case "12":
          ordersDataMap["Dec"] = (ordersDataMap["Dec"])!.toInt() + 1;
          break;
      }
    }

    ordersDataMap.forEach((key, value) {
      ordersData.add(OrdersData(key, value));
    });

    return ordersData;
  }
}

class OrdersData {
  OrdersData(this.month, this.orders);
  final String month;
  final int orders;
}
