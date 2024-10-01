import 'package:flutter/material.dart';

import '../../models/order.dart';

class PaymentsList extends StatelessWidget {
  final Order order;

  const PaymentsList({super.key, required this.order});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text(
          "Pagamentos:",
          style: TextStyle(fontWeight: FontWeight.bold),
        ),
        ...order.pagamentos.map((payment) {
          return Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text("Parcela: ${payment.parcela}"),
              Text("Valor: ${payment.valor}"),
              Text("Nome: ${payment.nome}"),
              const SizedBox(height: 5),
            ],
          );
        }),
      ],
    );
  }
}
