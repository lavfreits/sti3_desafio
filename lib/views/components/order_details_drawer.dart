import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

import '../../models/order.dart';
import 'items_list.dart';
import 'order_details_modal.dart';
import 'payments_list.dart';

class OrderDetailsDrawer extends StatelessWidget {
  final Order? selectedOrder;

  const OrderDetailsDrawer({super.key, this.selectedOrder});

  @override
  Widget build(BuildContext context) {
    if (selectedOrder == null) {
      return const Text("Selecione um pedido para ver os detalhes.");
    }

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text("Detalhes do Pedido", style: TextStyle(fontSize: 20)),
        const SizedBox(height: 10),
        Text("Número: ${selectedOrder!.numero}"),
        Text("Cliente: ${selectedOrder!.nomeCliente}"),
        Text("Email Cliente: ${selectedOrder!.emailCliente}"),
        Text(
          "Data criação: ${DateFormat('dd/MM/yy').format(
            DateTime.parse(selectedOrder!.dataCriacao),
          )}",
        ),
        Text(
          "Data alteração: ${DateFormat('dd/MM/yy').format(
            DateTime.parse(selectedOrder!.dataAlteracao),
          )}",
        ),
        Text("Status: ${selectedOrder!.status}"),
        Text("Desconto: ${selectedOrder!.desconto}"),
        Text("Frete: ${selectedOrder!.frete}"),
        Text("SubTotal: ${selectedOrder!.subTotal}"),
        Text("Total: ${selectedOrder!.valorTotal}"),
        const SizedBox(height: 10),
        ItemsList(order: selectedOrder!),
        const SizedBox(height: 10),
        PaymentsList(order: selectedOrder!),
        const SizedBox(height: 20),
        MaterialButton(
          color: Theme.of(context).colorScheme.primary,
          onPressed: () {
            Navigator.pop(context);

            showModalBottomSheet(
              context: context,
              builder: (context) => OrderDetailsModal(order: selectedOrder!),
            );
          },
          child: const Text(
            "Detalhes",
            style: TextStyle(
              color: Colors.white,
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
      ],
    );
  }
}
