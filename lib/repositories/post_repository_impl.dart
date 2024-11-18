import 'package:dart_z/data/data_sources/remote/post_remote_data_source.dart';
import 'package:dart_z/data/models/post/post_model.dart';
import 'package:dartz/dartz.dart';
import '../../../core/error/exceptions.dart';
import '../../../core/error/failures.dart';
import '../../../core/network/network_info.dart';

import './post_repository.dart';

class PostRepositoryImpl implements PostRepository {
  final PostRemoteDataSource remoteDataSource;
  final NetworkInfo networkInfo;

  PostRepositoryImpl({
    required this.remoteDataSource,
    required this.networkInfo,
  });

  @override
  Future<Either<Failure, List<PostModel>>> getPosts() async {
    if (await networkInfo.isConnected) {
      try {
        final remotePosts = await remoteDataSource.getPosts();
        return Right(remotePosts);
      } on ServerException {
        return const Left(Failure.serverFailure());
      }
    } else {
      return const Left(Failure.serverFailure());
    }
  }
}
