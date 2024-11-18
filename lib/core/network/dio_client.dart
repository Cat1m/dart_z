import 'package:dio/dio.dart';
import '../error/exceptions.dart';

class DioClient {
  static Dio getInstance() {
    final dio = Dio(
      BaseOptions(
        baseUrl: 'https://jsonplaceholder.typicode.com',
        headers: {'Content-Type': 'application/json'},
        connectTimeout: const Duration(seconds: 5),
        receiveTimeout: const Duration(seconds: 3),
      ),
    );

    dio.interceptors.add(
      InterceptorsWrapper(
        onError: (error, handler) {
          if (error.type == DioExceptionType.badResponse) {
            throw ServerException();
          }
          return handler.next(error);
        },
      ),
    );

    return dio;
  }
}
