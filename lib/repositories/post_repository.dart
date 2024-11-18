import 'package:dart_z/data/models/post/post_model.dart';
import 'package:dartz/dartz.dart';
import '../../../core/error/failures.dart';

abstract class PostRepository {
  Future<Either<Failure, List<PostModel>>> getPosts();
}
