import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';

import '../../controllers/order_controller.dart';
import '../../models/order.dart';
import '../components/order_details_drawer.dart';
import '../components/orders_list.dart';
import '../components/search_field.dart';

class OrdersPage extends StatefulWidget {
  const OrdersPage({super.key});

  @override
  State<OrdersPage> createState() => _OrdersPageState();
}

class _OrdersPageState extends State<OrdersPage> {
  final OrderController controller = GetIt.instance.get<OrderController>();
  final textController = TextEditingController();
  Order? selectedOrder;
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();

  @override
  void initState() {
    super.initState();
    Future.microtask(() => controller.getOrders());
  }

  void _showOrderDetails(BuildContext context, Order order) {
    setState(() {
      selectedOrder = order;
    });
    _scaffoldKey.currentState?.openDrawer();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: _scaffoldKey,
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.primary,
        title: const Text(
          "Pedidos",
          style: TextStyle(
            color: Colors.white,
            fontWeight: FontWeight.bold,
          ),
        ),
        iconTheme: const IconThemeData(color: Colors.white, size: 28),
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: () => Navigator.of(context).pop(),
        ),
      ),
      drawer: Drawer(
        child: SafeArea(
          child: Padding(
            padding: const EdgeInsets.all(20),
            child: OrderDetailsDrawer(selectedOrder: selectedOrder),
          ),
        ),
      ),
      body: GestureDetector(
        onTap: () => FocusScope.of(context).unfocus(),
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(20),
          child: Column(
            children: [
              MaterialButton(
                onPressed: () => controller.getOrders(),
                color: Theme.of(context).colorScheme.inversePrimary,
                child: const Text(
                  "Consultar",
                  style: TextStyle(fontWeight: FontWeight.bold),
                ),
              ),
              const SizedBox(height: 20),
              SearchField(
                controller: controller,
                textController: textController,
              ),
              const SizedBox(height: 20),
              Container(
                color: Theme.of(context).colorScheme.inversePrimary,
                child: const Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text("Número"),
                    Text("Data"),
                    Text("Cliente"),
                    Text("Status"),
                    Text(
                      "Total",
                      textAlign: TextAlign.right,
                    ),
                  ],
                ),
              ),
              OrdersList(
                controller: controller,
                onOrderTap: _showOrderDetails,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
