import 'package:flutter/material.dart';

import '../../models/order.dart';

class ItemsList extends StatelessWidget {
  final Order order;

  const ItemsList({super.key, required this.order});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text(
          "Itens:",
          style: TextStyle(fontWeight: FontWeight.bold),
        ),
        ...order.itens.map((item) {
          return Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text("Nome: ${item.nome}"),
              Text("Quantidade: ${item.quantidade}"),
              Text("Valor Unitário: ${item.valorUnitario}"),
              const SizedBox(height: 5),
            ],
          );
        }),
      ],
    );
  }
}
