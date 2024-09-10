import 'package:flutter/material.dart';
import 'package:instaclone/pages/components/post/post_thumnail_view.dart';
import 'package:instaclone/pages/post_details/post_details_page.dart';
import 'package:instaclone/state/posts/models/post.dart';

class PostsSliverGridView extends StatelessWidget {
  final Iterable<Post> posts;
  const PostsSliverGridView({
    super.key,
    required this.posts,
  });

  @override
  Widget build(BuildContext context) {
    return SliverGrid(
      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 3,
        mainAxisSpacing: 8.0,
        crossAxisSpacing: 8.0,
      ),
      delegate: SliverChildBuilderDelegate(
        childCount: posts.length,
        (context, index) {
          final post = posts.elementAt(index);
          return PostThumbnailview(
            post: post,
            onTapped: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => PostDetailsPage(
                    post: post,
                  ),
                ),
              );
            },
          );
        },
      ),
    );
  }
}