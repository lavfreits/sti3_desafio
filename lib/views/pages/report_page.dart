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

  @override
  Widget build(BuildContext context) {
    final reportController = GetIt.instance.get<ReportController>();

    return Scaffold(
      appBar: AppBar(
        title: const Text('Relatórios'),
      ),
      body: FutureBuilder(
        future: reportController.fetchOrders(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
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
                                      product['produto'],
                                      overflow: TextOverflow.fade,
                                    ),
                                  ),
                                  DataCell(
                                    Text(
                                      product['quantidade'].toString(),
                                    ),
                                  ),
                                  DataCell(
                                    Text(
                                      product['valorMédio'],
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
                                      payment['data'],
                                      overflow: TextOverflow.ellipsis,
                                    ),
                                  ),
                                  DataCell(
                                    Text(
                                      payment['forma de pagamento'],
                                      overflow: TextOverflow.ellipsis,
                                    ),
                                  ),
                                  DataCell(
                                    Text(
                                      payment['valor'],
                                      overflow: TextOverflow.ellipsis,
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
