import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

import '../../models/order.dart';

class OrderRow extends StatelessWidget {
  final Order order;

  const OrderRow({super.key, required this.order});

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        SizedBox(
          width: 50,
          child: Text(
            order.id.toString(),
            maxLines: 2,
          ),
        ),
        Text(
          DateFormat('dd/MM/yy').format(
            DateTime.parse(order.dataCriacao),
          ),
        ),
        Text(order.nomeCliente),
        Text(order.status),
        Text(order.valorTotal.toString(), textAlign: TextAlign.right),
      ],
    );
  }
}
