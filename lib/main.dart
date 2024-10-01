import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';
import 'package:hive/hive.dart';
import 'package:path_provider/path_provider.dart' as path_provider;

import 'controllers/order_controller.dart';
import 'controllers/report_controller.dart';
import 'services/order_repository.dart';
import 'services/order_service.dart';
import 'views/pages/home_page.dart';
import 'views/pages/orders_page.dart';
import 'views/pages/report_page.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();

  final appDocumentDirectory =
      await path_provider.getApplicationDocumentsDirectory();

  Hive.init(appDocumentDirectory.path);

  await setup();

  runApp(const MyApp());
}

Future<void> setup() async {
  final getIt = GetIt.instance;

  getIt.registerSingleton<OrderService>(OrderService());
  getIt.registerSingleton<Box<String>>(await Hive.openBox<String>('box'));

  getIt.registerSingleton<OrderRepository>(
    OrderRepository(
      getIt.get<Box<String>>(),
      getIt.get<OrderService>(),
    ),
  );

  getIt.registerSingleton<OrderController>(
    OrderController(
      getIt.get<OrderRepository>(),
    ),
  );

  getIt.registerSingleton<ReportController>(
    ReportController(
      getIt.get<OrderRepository>(),
    ),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'STi3 Desafio',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: const Color(0xFF00464F)),
        useMaterial3: true,
      ),
      debugShowCheckedModeBanner: false,
      initialRoute: '/',
      routes: {
        '/': (context) => const HomePage(),
        '/orders': (context) => const OrdersPage(),
        '/reports': (context) => const ReportPage(),
      },
    );
  }
}
