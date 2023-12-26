import 'package:flutter/material.dart';
import 'package:travel/Widgets/drawer_wedget.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      drawer: drawer(context),
      body: const Center(
        child: Text("Home Page"),
      ),
    );
  }
}
