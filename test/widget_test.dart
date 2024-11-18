// test/data/datasources/post_remote_data_source_test.dart

import 'package:bloc_test/bloc_test.dart';
import 'package:dart_z/core/error/exceptions.dart';
import 'package:dart_z/data/data_sources/remote/post_remote_data_source.dart';
import 'package:dart_z/data/models/post/post_model.dart';
import 'package:dart_z/injection.dart';
import 'package:dart_z/main.dart';
import 'package:dart_z/presentation/bloc/bloc/post_bloc.dart';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';

class MockPostBloc extends MockBloc<PostEvent, PostState> implements PostBloc {}

void main() {
  late MockPostBloc mockPostBloc;

  setUp(() async {
    mockPostBloc = MockPostBloc();
    getIt.registerFactory<PostBloc>(() => mockPostBloc);
  });

  tearDown(() {
    getIt.reset();
  });

  testWidgets('shows loading indicator when state is loading', (tester) async {
    when(() => mockPostBloc.state).thenReturn(const PostState.loading());

    await tester.pumpWidget(const MyApp());
    await tester.pump();

    expect(find.byType(CircularProgressIndicator), findsOneWidget);
  });
}
