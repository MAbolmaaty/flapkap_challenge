import 'dart:convert';

import 'package:flapkapchallenge/models/order_item.dart';
import 'package:flutter/services.dart';

class FetchData {
  Future<List<OrderItem>> getOrders() async {
    final dataString = await _loadJson('assets/data/orders.json');

    List<OrderItem> orders;

    var data = await jsonDecode(dataString) as List;
    orders = data.map((orderItem) => OrderItem.fromJson(orderItem)).toList();

    return orders;
  }

  Future<String> _loadJson(String path) async {
    return rootBundle.loadString(path);
  }
}
