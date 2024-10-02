import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';

import '../../controllers/report_controller.dart';

class ReportPage extends StatefulWidget {
  const ReportPage({super.key});

  @override
  State<ReportPage> createState() => _ReportPageState();
}

class _ReportPageState extends State<ReportPage> {
  String selectedOption = 'Produtos mais vendidos';
  final reportController = GetIt.instance.get<ReportController>();
  late Future<void> future;

  @override
  void initState() {
    super.initState();

    future = reportController.fetchOrders();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Relatórios'),
      ),
      body: FutureBuilder(
        future: future,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          }

          if (snapshot.hasError) {
            return const Center(child: Text('Erro! Tente novamente'));
          }

          return Column(
            children: [
              DropdownButton<String>(
                value: selectedOption,
                onChanged: (value) {
                  if (value != null) {
                    setState(() {
                      selectedOption = value;
                    });
                  }
                },
                items: const [
                  DropdownMenuItem(
                    value: 'Produtos mais vendidos',
                    child: Text('Produtos mais vendidos'),
                  ),
                  DropdownMenuItem(
                    value: 'Totalização de formas de pagamento por dia',
                    child: Text('Totalização de formas de pagamento por dia'),
                  ),
                ],
              ),
              Expanded(
                child: SingleChildScrollView(
                  child: Column(
                    children: [
                      if (selectedOption == 'Produtos mais vendidos')
                        DataTable(
                          columns: const [
                            DataColumn(
                              label: Text(
                                'Produto',
                                overflow: TextOverflow.ellipsis,
                              ),
                            ),
                            DataColumn(
                              label: Text(
                                'Quantidade',
                                overflow: TextOverflow.ellipsis,
                              ),
                            ),
                            DataColumn(
                              label: Text(
                                'Valor Médio',
                                overflow: TextOverflow.ellipsis,
                              ),
                            ),
                          ],
                          rows: reportController.topSellingProducts.map(
                            (product) {
                              return DataRow(
                                cells: [
                                  DataCell(
                                    Text(
                                      product.productName,
                                      overflow: TextOverflow.fade,
                                    ),
                                  ),
                                  DataCell(
                                    Text(
                                      product.quantity.toString(),
                                    ),
                                  ),
                                  DataCell(
                                    Text(
                                      product.averageValue.toStringAsFixed(2),
                                    ),
                                  ),
                                ],
                              );
                            },
                          ).toList(),
                        ),
                      if (selectedOption ==
                          'Totalização de formas de pagamento por dia')
                        DataTable(
                          columns: const [
                            DataColumn(
                              label: Text('Data'),
                            ),
                            DataColumn(
                              label: Text(
                                'Forma de Pagamento',
                                overflow: TextOverflow.ellipsis,
                              ),
                            ),
                            DataColumn(
                              label: Text('Valor'),
                            ),
                          ],
                          rows: reportController.paymentTotalByDay.map(
                            (payment) {
                              return DataRow(
                                cells: [
                                  DataCell(
                                    Text(
                                      payment.date,
                                      overflow: TextOverflow.ellipsis,
                                    ),
                                  ),
                                  DataCell(
                                    Text(
                                      payment.paymentMethod,
                                      overflow: TextOverflow.ellipsis,
                                    ),
                                  ),
                                  DataCell(
                                    Text(
                                      payment.totalValue.toStringAsFixed(2),
                                    ),
                                  ),
                                ],
                              );
                            },
                          ).toList(),
                        ),
                    ],
                  ),
                ),
              ),
            ],
          );
        },
      ),
    );
  }
}
