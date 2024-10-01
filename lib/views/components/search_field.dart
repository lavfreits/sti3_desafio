import 'package:flutter/material.dart';

import '../../controllers/order_controller.dart';

class SearchField extends StatelessWidget {
  final OrderController controller;
  final TextEditingController textController;

  const SearchField({
    super.key,
    required this.controller,
    required this.textController,
  });

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      controller: textController,
      onChanged: (value) => controller.searchOrders(value),
      decoration: const InputDecoration(
        border: OutlineInputBorder(),
        hintText: "Insira o nome do cliente",
        labelText: "Nome do cliente",
      ),
    );
  }
}
