import 'package:dart_z/core/error/failures.dart';
import 'package:dart_z/core/network/network_info.dart';
import 'package:dart_z/data/data_sources/remote/post_remote_data_source.dart';
import 'package:dart_z/repositories/post_repository_impl.dart';
import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import '../fixtures/test_models.dart';

class MockPostRemoteDataSource extends Mock implements PostRemoteDataSource {}

class MockNetworkInfo extends Mock implements NetworkInfo {}

void main() {
  late PostRepositoryImpl repository;
  late MockPostRemoteDataSource mockRemoteDataSource;
  late MockNetworkInfo mockNetworkInfo;

  setUp(() {
    mockRemoteDataSource = MockPostRemoteDataSource();
    mockNetworkInfo = MockNetworkInfo();
    repository = PostRepositoryImpl(
      remoteDataSource: mockRemoteDataSource,
      networkInfo: mockNetworkInfo,
    );
  });

  group('PostRepository', () {
    group('getPosts', () {
      test(
        'should return posts when device is online and API call is successful',
        () async {
          // arrange
          when(() => mockNetworkInfo.isConnected).thenAnswer((_) async => true);
          when(() => mockRemoteDataSource.getPosts())
              .thenAnswer((_) async => tPostModelList);

          // act
          final result = await repository.getPosts();

          // assert
          verify(() => mockNetworkInfo.isConnected);
          verify(() => mockRemoteDataSource.getPosts());
          expect(result, equals(Right(tPostModelList)));
        },
      );

      test(
        'should return network failure when device has no internet',
        () async {
          // arrange
          when(() => mockNetworkInfo.isConnected)
              .thenAnswer((_) async => false);

          // act
          final result = await repository.getPosts();

          // assert
          verify(() => mockNetworkInfo.isConnected);
          verifyZeroInteractions(mockRemoteDataSource);
          expect(
              result,
              equals(const Left(
                  Failure.serverFailure()))); // hoặc networkFailure tùy bạn
        },
      );
    });
  });
}
