import 'package:dart_z/core/error/exceptions.dart';
import 'package:dart_z/data/data_sources/remote/post_remote_data_source.dart';
import 'package:dart_z/data/models/post/post_model.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:dio/dio.dart';

class MockDio extends Mock implements Dio {
  @override
  BaseOptions get options => BaseOptions(
        baseUrl: 'https://jsonplaceholder.typicode.com',
      );
}

void main() {
  late PostRemoteDataSource dataSource;
  late MockDio mockDio;

  setUp(() {
    mockDio = MockDio();
    dataSource = PostRemoteDataSource(mockDio);
    registerFallbackValue(RequestOptions(path: ''));
  });

  group('PostRemoteDataSource', () {
    group('getPosts', () {
      final tPostList = [
        const PostModel(
          id: 1,
          userId: 1,
          title: 'test title',
          body: 'test body',
        )
      ];

      test('should return list of PostModel when the response code is 200',
          () async {
        // arrange
        when(() => mockDio.fetch<List<dynamic>>(any())).thenAnswer(
          (_) async => Response(
            data: [
              {'id': 1, 'userId': 1, 'title': 'test title', 'body': 'test body'}
            ],
            statusCode: 200,
            requestOptions: RequestOptions(path: '/posts'),
          ),
        );

        // act
        final result = await dataSource.getPosts();

        // assert
        expect(result, equals(tPostList));
      });

      test('should throw ServerException when response code is not 200',
          () async {
        // arrange
        when(() => mockDio.fetch<List<dynamic>>(any())).thenThrow(
          DioException(
            response: Response(
              statusCode: 404,
              requestOptions: RequestOptions(path: '/posts'),
            ),
            requestOptions: RequestOptions(path: '/posts'),
            type: DioExceptionType.badResponse,
          ),
        );

        // act & assert
        expect(
          () async => await dataSource.getPosts(),
          throwsA(isA<DioException>()),
        );
      });
    });
  });
}
