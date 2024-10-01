import 'package:flutter/material.dart';

import '../../controllers/order_controller.dart';
import '../../models/order.dart';
import 'order_details_modal.dart';
import 'order_row.dart';

class OrdersList extends StatelessWidget {
  final OrderController controller;
  final void Function(BuildContext, Order) onOrderTap;

  const OrdersList({
    super.key,
    required this.controller,
    required this.onOrderTap,
  });

  @override
  Widget build(BuildContext context) {
    return ListenableBuilder(
      listenable: controller,
      builder: (_, __) {
        if (controller.isLoading) {
          return const Center(child: CircularProgressIndicator());
        }

        if (controller.orders.isEmpty) {
          return const Center(child: Text("Nenhum pedido encontrado"));
        }

        return Column(
          children: controller.orders.map(
            (order) {
              return GestureDetector(
                onTap: () => onOrderTap(context, order),
                onDoubleTap: () => showModalBottomSheet(
                  context: context,
                  builder: (context) => OrderDetailsModal(order: order),
                ),
                child: OrderRow(order: order),
              );
            },
          ).toList(),
        );
      },
    );
  }
}
