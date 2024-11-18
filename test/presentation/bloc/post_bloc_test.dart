import 'package:bloc_test/bloc_test.dart';
import 'package:dart_z/core/error/failures.dart';
import 'package:dart_z/data/models/post/post_model.dart';
import 'package:dart_z/presentation/bloc/bloc/post_bloc.dart';
import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';

import '../../fixtures/test_models.dart';
import '../../helpers/test_helper.dart';

void main() {
  late PostBloc bloc;
  late MockPostRepository mockPostRepository;

  setUp(() {
    mockPostRepository = MockPostRepository();
    bloc = PostBloc(repository: mockPostRepository);
  });

  tearDown(() {
    bloc.close();
  });

  group('PostBloc', () {
    group('Initial State', () {
      test('should start with Initial state', () {
        expect(bloc.state, equals(const PostState.initial()));
      });
    });

    group('GetPosts Event', () {
      blocTest<PostBloc, PostState>(
        'should emit [Loading, Loaded] when data is gotten successfully',
        build: () {
          when(() => mockPostRepository.getPosts())
              .thenAnswer((_) async => Right(tPostModelList));
          return bloc;
        },
        act: (bloc) => bloc.add(const PostEvent.getPosts()),
        expect: () => [
          const PostState.loading(),
          PostState.loaded(tPostModelList),
        ],
      );

      blocTest<PostBloc, PostState>(
        'should emit [Loading, Error] when getting data fails',
        build: () {
          when(() => mockPostRepository.getPosts())
              .thenAnswer((_) async => const Left(Failure.serverFailure()));
          return bloc;
        },
        act: (bloc) => bloc.add(const PostEvent.getPosts()),
        expect: () => [
          const PostState.loading(),
          const PostState.error('Something went wrong'),
        ],
      );
    });
  });
}
