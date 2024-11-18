import 'package:dart_z/core/network/network_info.dart';
import 'package:dart_z/data/data_sources/remote/post_remote_data_source.dart';
import 'package:dart_z/repositories/post_repository.dart';
import 'package:mocktail/mocktail.dart';
import 'package:internet_connection_checker/internet_connection_checker.dart';

class MockPostRemoteDataSource extends Mock implements PostRemoteDataSource {}

class MockNetworkInfo extends Mock implements NetworkInfo {}

class MockInternetConnectionChecker extends Mock
    implements InternetConnectionChecker {}

class MockPostRepository extends Mock implements PostRepository {}
