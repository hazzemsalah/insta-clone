import 'package:flutter/material.dart';
import 'package:instaclone/state/posts/models/post.dart';

class PostThumbnailview extends StatelessWidget {
  final Post post;
  final VoidCallback onTapped;
  const PostThumbnailview({
    super.key,
    required this.post,
    required this.onTapped,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTapped,
      child: Image.network(
        post.thumbnailUrl,
        fit: BoxFit.cover,
      ),
    );
  }
}
