import 'dart:convert';

import 'package:http/http.dart' as http;

import '../models/order.dart';

class OrderService {
  final String apiUrl = 'https://desafiotecnicosti3.azurewebsites.net/pedido';

  Future<List<Order>> fetchOrders() async {
    final response = await http.get(Uri.parse(apiUrl));

    if (response.statusCode == 200) {
      List<dynamic> data = jsonDecode(response.body);

      return data.map((json) => Order.fromJson(json)).toList();
    } else {
      throw Exception('Failed to load orders');
    }
  }
}
