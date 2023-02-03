import 'dart:convert';
import 'dart:math';

import 'package:dio/dio.dart';
import 'package:flutter/material.dart';

import '../index.dart';
import '../main.dart';

class PostWidget extends StatefulWidget {
  const PostWidget({super.key});

  @override
  State<PostWidget> createState() => PostWidgetState();
}

class PostWidgetState extends State<PostWidget> {
  final Dio dio = Dio();

  bool _isLoadingGet = false;

  String data = "Empty Data";

  String? randomUser;

  Future<void> postMethod({required User user}) async {
    try {
      Response response = await dio.post(
        '${MyApp.baseUrl}/users',
        data: user.toJson(),
      );
      randomUser =
          'id: ${user.data.id}\nEmail: ${user.data.email}\nFirstname: ${user.data.firstName}\nLastname: ${user.data.lastName}';
      data = response.data.toString();
    } catch (e) {
      print('Error creating user: $e');
    }
  }

  Future<void> getMethod() async {
    try {
      Response response = await DioService.dio
          .get('${MyApp.baseUrl}/user/${Random().nextInt(10) + 1}');
      data = response.data.toString();
    } catch (e) {
      data = e.toString();
    }
  }

  User _generateRandomUserData() {
    int id = Random().nextInt(10);
    return User(
      Data(
        id: id,
        avatar: 'avatar_$id',
        email: 'email_$id',
        firstName: 'firstName_$id',
        lastName: 'lastName_$id',
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(20),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.center,
        mainAxisSize: MainAxisSize.min,
        children: [
          const Text(
            "Data Post",
            style: TextStyle(
              color: Colors.black,
              fontSize: 15,
              fontWeight: FontWeight.bold,
            ),
          ),
          Card(
            elevation: 5,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(10),
              side: const BorderSide(width: 0.5),
            ),
            child: Padding(
              padding: const EdgeInsets.all(10),
              child: Center(child: Text(randomUser ?? 'null')),
            ),
          ),
          const Text(
            "Data Response",
            style: TextStyle(
              color: Colors.black,
              fontSize: 15,
              fontWeight: FontWeight.bold,
            ),
          ),
          Card(
            elevation: 5,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(10),
              side: const BorderSide(width: 0.5),
            ),
            child: Padding(
              padding: const EdgeInsets.all(10),
              child: Center(child: Text(data)),
            ),
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
                    await postMethod(user: _generateRandomUserData());
                    setState(() {
                      _isLoadingGet = false;
                    });
                  },
                  child: const Text(
                    "POST DATA",
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 12,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                )
        ],
      ),
    );
  }
}
