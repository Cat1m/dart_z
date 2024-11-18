import 'package:dart_z/core/error/exceptions.dart';
import 'package:dart_z/data/models/post/post_model.dart';
import 'package:dio/dio.dart';
import 'package:retrofit/retrofit.dart';

part 'post_remote_data_source.g.dart';

@RestApi(baseUrl: "https://jsonplaceholder.typicode.com")
abstract class PostRemoteDataSource {
  factory PostRemoteDataSource(Dio dio) = _PostRemoteDataSource;

  @GET("/posts")
  Future<List<PostModel>> getPosts();
}

// lib/core/network/dio_client.dart
class DioClient {
  static Dio getInstance() {
    final dio = Dio(
      BaseOptions(
        baseUrl: 'https://jsonplaceholder.typicode.com',
        headers: {'Content-Type': 'application/json'},
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
