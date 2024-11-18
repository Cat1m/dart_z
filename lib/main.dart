import 'package:dart_z/presentation/bloc/bloc/post_bloc.dart';
import 'package:dart_z/presentation/pages/post_pages.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'injection.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await configureDependencies();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Clean Architecture Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: BlocProvider(
        create: (_) => getIt<PostBloc>(),
        child: const PostsPage(),
      ),
    );
  }
}
