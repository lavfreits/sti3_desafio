import 'package:flutter/material.dart';

import '../models/order.dart';
import '../services/order_repository.dart';

class OrderController extends ChangeNotifier {
  final OrderRepository _orderRepository;

  List<Order> orders = [];
  bool _isLoading = false;
  bool isError = false;

  OrderController(this._orderRepository);

  bool get isLoading => _isLoading;

  Future<void> getOrders() async {
    _setLoadingState(true);
    isError = false;

    try {
      orders = await _orderRepository.getOrders();
    } catch (e) {
      debugPrint('Error fetching orders: $e');
      isError = true;
    } finally {
      _setLoadingState(false);
    }
  }

  Future<void> searchOrders(String customerName) async {
    isError = false;

    _setLoadingState(true);

    try {
      orders = customerName.isEmpty
          ? await _orderRepository.getOrders()
          : _orderRepository.filterOrdersByCustomerName(customerName);
    } catch (e) {
      debugPrint('Error searching orders: $e');
      isError = true;
    } finally {
      _setLoadingState(false);
    }
  }

  void _setLoadingState(bool value) {
    _isLoading = value;
    notifyListeners();
  }
}
