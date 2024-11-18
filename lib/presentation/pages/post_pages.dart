import 'package:dart_z/data/models/post/post_model.dart';
import 'package:dart_z/presentation/bloc/bloc/post_bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class PostsPage extends StatelessWidget {
  const PostsPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Posts'),
      ),
      body: BlocBuilder<PostBloc, PostState>(
        builder: (context, state) {
          return state.when(
            initial: () {
              context.read<PostBloc>().add(const PostEvent.getPosts());
              return const Center(child: Text('Initial State'));
            },
            loading: () => const Center(child: CircularProgressIndicator()),
            loaded: (posts) => PostListWidget(posts: posts),
            error: (message) => Center(child: Text(message)),
          );
        },
      ),
    );
  }
}

class PostListWidget extends StatelessWidget {
  final List<PostModel> posts;

  const PostListWidget({Key? key, required this.posts}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      itemCount: posts.length,
      itemBuilder: (context, index) {
        final post = posts[index];
        return ListTile(
          title: Text(post.title),
          subtitle: Text(post.body),
        );
      },
    );
  }
}
