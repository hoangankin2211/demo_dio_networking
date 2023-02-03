import 'package:dio_networking_demo/app.dart';
import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  static const baseUrl = "https://reqres.in/api";

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo Dio Networking',
      theme: ThemeData(primarySwatch: Colors.blue),
      home: const DashboardScreen(),
    );
  }
}
