import 'package:dart_z/data/data_sources/remote/post_remote_data_source.dart';
import 'package:dart_z/presentation/bloc/bloc/post_bloc.dart';
import 'package:dart_z/repositories/post_repository.dart';
import 'package:dart_z/repositories/post_repository_impl.dart';
import 'package:get_it/get_it.dart';
import 'package:injectable/injectable.dart';
import 'package:internet_connection_checker/internet_connection_checker.dart';
import 'package:dio/dio.dart';
import 'core/network/network_info.dart';

final getIt = GetIt.instance;

@InjectableInit()
Future<void> configureDependencies() async {
  // External
  getIt.registerLazySingleton(() => InternetConnectionChecker());

  // Dio với setup
  getIt.registerLazySingleton<Dio>(() => DioClient.getInstance());

  // Core
  getIt.registerLazySingleton<NetworkInfo>(
    () => NetworkInfoImpl(getIt()),
  );

  // Data sources
  getIt.registerLazySingleton<PostRemoteDataSource>(
    () => PostRemoteDataSource(getIt()),
  );

  // Repository
  getIt.registerLazySingleton<PostRepository>(
    () => PostRepositoryImpl(
      remoteDataSource: getIt(),
      networkInfo: getIt(),
    ),
  );

  // BLoC
  getIt.registerFactory(
    () => PostBloc(repository: getIt()),
  );
}
