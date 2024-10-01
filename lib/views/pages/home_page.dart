import 'package:flutter/material.dart';

class HomePage extends StatelessWidget {
  const HomePage({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      endDrawer: Drawer(
        child: ListView(
          children: [
            DrawerHeader(
              decoration: BoxDecoration(
                color: Theme.of(context).colorScheme.primary,
              ),
              child: Image.asset("assets/sti3_logo.png"),
            ),
            ListTile(
              title: const Text("Home"),
              onTap: () {
                Navigator.of(context).pop();
              },
            ),
            ListTile(
              title: const Text("Pedidos"),
              onTap: () {
                Navigator.of(context).pushNamed("/orders");
              },
            ),
            ListTile(
              title: const Text("Relatórios"),
              onTap: () {
                Navigator.of(context).pushNamed("/reports");
              },
            ),
          ],
        ),
      ),
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.primary,
        title: const Text(
          "STi3 Desafio",
          style: TextStyle(
            color: Colors.white,
            fontWeight: FontWeight.bold,
          ),
        ),
        iconTheme: const IconThemeData(
          color: Colors.white,
          size: 28,
        ),
      ),
      body: Container(
        color: Theme.of(context).colorScheme.inversePrimary,
        alignment: Alignment.center,
        child: Image.asset("assets/sti3_logo.png"),
      ),
    );
  }
}
