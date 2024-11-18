import 'package:bloc/bloc.dart';
import 'package:dart_z/data/models/post/post_model.dart';
import 'package:dart_z/repositories/post_repository.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'post_event.dart';
part 'post_state.dart';
part 'post_bloc.freezed.dart';

class PostBloc extends Bloc<PostEvent, PostState> {
  final PostRepository repository;

  PostBloc({required this.repository}) : super(const PostState.initial()) {
    on<GetPosts>(_onGetPosts);
  }

  Future<void> _onGetPosts(GetPosts event, Emitter<PostState> emit) async {
    emit(const PostState.loading());
    final failureOrPosts = await repository.getPosts();
    emit(failureOrPosts.fold(
      (failure) => const PostState.error('Something went wrong'),
      (posts) => PostState.loaded(posts),
    ));
  }
}
