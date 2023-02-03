import 'package:dio/dio.dart';

class DioService {
  static final Dio dio = Dio();
  final baseUrl = "https://reqres.in/api";
}
