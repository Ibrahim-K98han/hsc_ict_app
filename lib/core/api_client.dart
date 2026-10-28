import 'package:dio/dio.dart';

class ApiClient {
  // Android emulator থেকে আপনার PC-র localhost = 10.0.2.2
  // আসল ফোনে পরীক্ষা করলে এখানে PC-র IP বসাবেন (নিচে দেখুন)
  static const String baseUrl = 'http://192.168.0.103:8000/api';

  final Dio dio = Dio(
    BaseOptions(
      baseUrl: baseUrl,
      connectTimeout: const Duration(seconds: 10),
      receiveTimeout: const Duration(seconds: 20),
      headers: {'Accept': 'application/json'},
    ),
  );
}
