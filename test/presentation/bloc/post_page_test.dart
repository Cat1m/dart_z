import 'package:dart_z/injection.dart';
import 'package:dart_z/main.dart';
import 'package:dart_z/presentation/bloc/bloc/post_bloc.dart';
import 'package:dart_z/presentation/pages/post_pages.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';

import '../../fixtures/test_models.dart';
import '../../widget_test.dart';

void main() {
  late MockPostBloc mockPostBloc;

  setUp(() {
    mockPostBloc = MockPostBloc();
    getIt.registerFactory<PostBloc>(() => mockPostBloc);
  });

  tearDown(() {
    getIt.reset();
  });

  group('PostsPage', () {
    testWidgets('should show loading indicator when state is loading',
        (tester) async {
      // arrange
      when(() => mockPostBloc.state).thenReturn(const PostState.loading());

      // act
      await tester.pumpWidget(const MyApp());
      await tester.pump();

      // assert
      expect(find.byType(CircularProgressIndicator), findsOneWidget);
    });

    testWidgets('should show error message when state is error',
        (tester) async {
      // arrange
      when(() => mockPostBloc.state)
          .thenReturn(const PostState.error('Error message'));

      // act
      await tester.pumpWidget(const MyApp());
      await tester.pump();

      // assert
      expect(find.text('Error message'), findsOneWidget);
    });

    testWidgets('should show list of posts when state is loaded',
        (tester) async {
      // arrange
      when(() => mockPostBloc.state)
          .thenReturn(PostState.loaded(tPostModelList));

      // act
      await tester.pumpWidget(const MyApp());
      await tester.pump();

      // assert
      expect(find.byType(PostListWidget), findsOneWidget);
      expect(find.byType(ListTile), findsNWidgets(tPostModelList.length));
    });
  });
}
