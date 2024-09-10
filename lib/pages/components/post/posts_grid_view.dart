import 'package:flutter/material.dart';
import 'package:instaclone/pages/components/post/post_thumnail_view.dart';
import 'package:instaclone/pages/post_details/post_details_page.dart';
import 'package:instaclone/state/posts/models/post.dart';

class PostsGridView extends StatelessWidget {
  final Iterable<Post> posts;
  const PostsGridView({
    super.key,
    required this.posts,
  });

  @override
  Widget build(BuildContext context) {
    return GridView.builder(
      padding: const EdgeInsets.all(8),
      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 3,
        mainAxisSpacing: 8.0,
        crossAxisSpacing: 8.0,
      ),
      itemCount: posts.length,
      itemBuilder: (context, index) {
        final post = posts.elementAt(index);
        return PostThumbnailview(
          post: post,
          onTapped: () {
            //Navigato to the post details page
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => PostDetailsPage(post: post),
              ),
            );
          },
        );
      },
    );
  }
}
