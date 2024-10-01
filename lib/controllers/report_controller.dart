import 'package:flutter/material.dart';

import '../models/order.dart';
import '../services/order_repository.dart';

class ReportController extends ChangeNotifier {
  final OrderRepository _orderRepository;
  List<Order> _orders = [];

  ReportController(this._orderRepository);

  List<Order> get orders => _orders;

  Future<void> fetchOrders() async {
    _orders = await _orderRepository.getOrders();
    notifyListeners();
  }

  List<Map<String, dynamic>> get topSellingProducts =>
      _calculateTopSellingProducts();

  List<Map<String, dynamic>> get paymentTotalByDay =>
      _calculatePaymentTotalByDay();

  List<Map<String, dynamic>> _calculateTopSellingProducts() {
    final productCounts = <String, int>{};
    final productValues = <String, double>{};

    for (var order in _orders) {
      _aggregateProductData(order, productCounts, productValues);
    }

    return _mapProductDataToResults(productCounts, productValues);
  }

  void _aggregateProductData(
    Order order,
    Map<String, int> productCounts,
    Map<String, double> productValues,
  ) {
    for (var item in order.itens) {
      final quantity = int.parse(item.quantidade);
      final value = double.parse(item.valorUnitario) * quantity;

      productCounts[item.nome] = (productCounts[item.nome] ?? 0) + quantity;
      productValues[item.nome] = (productValues[item.nome] ?? 0) + value;
    }
  }

  List<Map<String, dynamic>> _mapProductDataToResults(
      Map<String, int> productCounts, Map<String, double> productValues) {
    return productCounts.entries.map((entry) {
      final productName = entry.key;
      final quantity = entry.value;
      final averageValue = productValues[productName]! / quantity;

      return {
        'produto': productName,
        'quantidade': quantity,
        'valorMédio': averageValue.toStringAsFixed(2),
      };
    }).toList();
  }

  List<Map<String, dynamic>> _calculatePaymentTotalByDay() {
    final paymentsByDay = <String, Map<String, double>>{};

    for (var order in _orders) {
      _aggregatePaymentData(order, paymentsByDay);
    }

    return _mapPaymentDataToResults(paymentsByDay);
  }

  void _aggregatePaymentData(
    Order order,
    Map<String, Map<String, double>> paymentsByDay,
  ) {
    for (var payment in order.pagamentos) {
      final date = _formatOrderDate(order.dataCriacao);

      paymentsByDay.putIfAbsent(date, () => {});

      paymentsByDay[date]![payment.nome] =
          (paymentsByDay[date]![payment.nome] ?? 0) +
              double.parse(payment.valor);
    }
  }

  String _formatOrderDate(String dateString) {
    return dateString.split('T')[0]; // retorna a data no formato YYYY-MM-DD
  }

  List<Map<String, dynamic>> _mapPaymentDataToResults(
    Map<String, Map<String, double>> paymentsByDay,
  ) {
    final result = <Map<String, dynamic>>[];

    paymentsByDay.forEach((date, paymentData) {
      paymentData.forEach(
        (paymentMethod, total) {
          result.add({
            'data': date,
            'forma de pagamento': paymentMethod,
            'valor': total.toStringAsFixed(2),
          });
        },
      );
    });

    return result;
  }
}
