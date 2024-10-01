import 'package:flutter/material.dart';

import '../../models/order.dart';
import 'items_list.dart';
import 'payments_list.dart';

class OrderDetailsModal extends StatelessWidget {
  final Order order;

  const OrderDetailsModal({super.key, required this.order});

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Padding(
        padding: const EdgeInsets.all(20),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              "Detalhes dos Itens e Parcelas",
              style: TextStyle(fontSize: 20),
            ),
            Text("Desconto: ${order.desconto}"),
            Text("Total: ${order.valorTotal}"),
            const SizedBox(height: 10),
            ItemsList(order: order),
            const SizedBox(height: 10),
            PaymentsList(order: order),
            const SizedBox(height: 20),
            ElevatedButton(
              onPressed: () => Navigator.of(context).pop(),
              child: const Text("Fechar"),
            ),
          ],
        ),
      ),
    );
  }
}
