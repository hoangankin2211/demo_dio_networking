import 'package:flutter/material.dart';
import './widget/index_widget.dart';

class DashboardScreen extends StatefulWidget {
  const DashboardScreen({super.key});

  @override
  State<DashboardScreen> createState() => _DashboardScreenState();
}

class _DashboardScreenState extends State<DashboardScreen> {
  final List<Widget> widgets = [
    const GetWidget(),
    const PostWidget(),
  ];
  int _currentIndex = 0;
  void _opTapNavigationBar(int index) {
    setState(() {
      _currentIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      bottomNavigationBar: BottomNavigationBar(
        unselectedItemColor: Colors.grey,
        selectedItemColor: Colors.blue,
        elevation: 5,
        items: const [
          BottomNavigationBarItem(icon: Icon(Icons.widgets), label: "GET"),
          BottomNavigationBarItem(icon: Icon(Icons.widgets), label: "POST"),
        ],
        currentIndex: _currentIndex,
        onTap: _opTapNavigationBar,
      ),
      body: Center(child: widgets[_currentIndex]),
    );
  }
}
