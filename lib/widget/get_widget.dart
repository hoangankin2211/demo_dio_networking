import 'dart:math';

import 'package:dio/dio.dart';
import 'package:dio_networking_demo/main.dart';
import 'package:flutter/material.dart';
import './../index.dart';

class GetWidget extends StatefulWidget {
  const GetWidget({super.key});

  @override
  State<GetWidget> createState() => _GetWidgetState();
}

class _GetWidgetState extends State<GetWidget> {
  bool _isLoadingGet = false;

  String data = "EmptyData";

  final baseUrl = MyApp.baseUrl;

  final TextEditingController getController = TextEditingController(
      text: "https://reqres.in/api/user/${Random().nextInt(20) + 1}");

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(20),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.center,
        mainAxisSize: MainAxisSize.min,
        children: [
          Text(
            "Get Data From '${getController.value.text}'",
            style: const TextStyle(
              color: Colors.black,
              fontSize: 15,
              fontWeight: FontWeight.bold,
            ),
          ),
          TextField(controller: getController),
          Card(
            elevation: 5,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(10),
              side: const BorderSide(width: 0.5),
            ),
            child: Padding(
                padding: const EdgeInsets.all(10),
                child: Center(child: Text(data))),
          ),
          _isLoadingGet
              ? const Center(
                  child: CircularProgressIndicator(),
                )
              : ElevatedButton(
                  style: ElevatedButton.styleFrom(
                      minimumSize: const Size(double.infinity, 40)),
                  onPressed: () async {
                    setState(() {
                      _isLoadingGet = true;
                    });
                    await getMethod();
                    setState(() {
                      _isLoadingGet = false;
                    });
                  },
                  child: const Text(
                    "GET DATA",
                    style: TextStyle(
                        color: Colors.white,
                        fontSize: 12,
                        fontWeight: FontWeight.w500),
                  ),
                )
        ],
      ),
    );
  }

  Future getMethod() async {
    getController.text = "$baseUrl/user/${Random().nextInt(10) + 1}";
    try {
      Response response = await DioService.dio.get(getController.value.text);
      data = response.data.toString();
    } catch (e) {
      data = e.toString();
    }
  }
}
