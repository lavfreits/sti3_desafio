import 'dart:convert';

import 'package:hive/hive.dart';

import '../models/order.dart';
import 'order_service.dart';

class OrderRepository {
  final OrderService _orderService;
  final Box<String> _orderBox;

  OrderRepository(this._orderBox, this._orderService);

  Future<List<Order>> getOrders() async {
    String? ordersJson = _orderBox.get('orders');

    if (ordersJson == null) {
      List<Order> orders = await _orderService.fetchOrders();

      await saveOrders(orders);

      return orders;
    } else {
      return _decodeOrdersFromJson(ordersJson);
    }
  }

  Future<void> saveOrders(List<Order> orders) async {
    String ordersJson = _encodeOrdersToJson(orders);

    await _orderBox.put('orders', ordersJson);
  }

  Future<void> clearOrders() async {
    await _orderBox.delete('orders');
  }

  List<Order> filterOrdersByCustomerName(String customerName) {
    String? ordersJson = _orderBox.get('orders');
    if (ordersJson == null) return [];

    List<Order> orders = _decodeOrdersFromJson(ordersJson);
    return orders
        .where((order) => order.nomeCliente
            .toLowerCase()
            .contains(customerName.toLowerCase()))
        .toList();
  }

  List<Order> _decodeOrdersFromJson(String ordersJson) {
    List<dynamic> ordersDecoded = json.decode(ordersJson);

    return ordersDecoded.map((orderJson) => Order.fromJson(orderJson)).toList();
  }

  String _encodeOrdersToJson(List<Order> orders) {
    return json.encode(orders.map((order) => order.toJson()).toList());
  }
}
