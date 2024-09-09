import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:instaclone/enums/date_sorting.dart';
import 'package:instaclone/pages/components/animations/error_animation_page.dart';
import 'package:instaclone/pages/components/animations/small_error_animation_page.dart';
import 'package:instaclone/pages/components/comment/compact_comment_column.dart';
import 'package:instaclone/pages/components/dialogs/alert_dialog_model.dart';
import 'package:instaclone/pages/components/dialogs/delete_dialog.dart';
import 'package:instaclone/pages/components/likes/like_button.dart';
import 'package:instaclone/pages/components/likes/likes_counts_view.dart';
import 'package:instaclone/pages/components/post/post_date_view.dart';
import 'package:instaclone/pages/components/post/post_display_name_message_view.dart';
import 'package:instaclone/pages/components/post/post_image_or_video_view.dart';
import 'package:instaclone/pages/constants/strings.dart';
import 'package:instaclone/pages/post_comments/post_comments_page.dart';
import 'package:instaclone/state/comments/models/post_comments_request.dart';
import 'package:instaclone/state/posts/models/post.dart';
import 'package:instaclone/state/posts/providers/can_current_user_delete_post_provider.dart';
import 'package:instaclone/state/posts/providers/delete_post_provider.dart';
import 'package:instaclone/state/posts/providers/specific_post_with_comments_provider.dart';
import 'package:share_plus/share_plus.dart';

class PostDetailsPage extends ConsumerStatefulWidget {
  final Post post;
  const PostDetailsPage({
    super.key,
    required this.post,
  });

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _PostDetailsPage();
}

class _PostDetailsPage extends ConsumerState<PostDetailsPage> {
  @override
  Widget build(BuildContext context) {
    final request = RequestForPostAndComments(
      postId: widget.post.postId,
      limit: 3,
      sortByCreatedAt: true,
      dateSorting: DateSorting.oldestOnTon,
    );

    // get the actual post together with comments
    final postWithComments = ref.watch(
      specificPostWithCommentsProvider(
        request,
      ),
    );

    // can we delete this post ??
    final canDeletePost = ref.watch(
      canCurrentUserDeletePostProvider(
        widget.post,
      ),
    );

    return Scaffold(
      appBar: AppBar(
        title: const Text(
          Strings.postDetails,
        ),
        actions: [
          // share button is always displayed
          postWithComments.when(
            data: (postWithComments) {
              return IconButton(
                icon: const Icon(Icons.share),
                onPressed: () {
                  final url = postWithComments.post.fileUrl;
                  Share.share(
                    url,
                    subject: Strings.checkOutThisPost,
                  );
                },
              );
            },
            error: (error, stackTrace) {
              return const SmallErrorAnimationPage();
            },
            loading: () {
              return const Center(
                child: CircularProgressIndicator(),
              );
            },
          ),
          // delete button only appears if we can delete the post
          if (canDeletePost.value ?? false)
            IconButton(
              icon: const Icon(Icons.delete),
              onPressed: () async {
                final shouldDeletePost = await const DeleteDialog(
                  titleOfObjectToDelete: Strings.post,
                ).present(context).then(
                      (shouldDelete) => shouldDelete ?? false,
                    );
                if (shouldDeletePost) {
                  await ref.read(deletePostProvider.notifier).deletePost(
                        post: widget.post,
                      );
                  if (mounted) {
                    Navigator.of(context).pop();
                  }
                }
              },
            ),
        ],
      ),
      body: postWithComments.when(
        data: (postWithComments) {
          final postId = postWithComments.post.postId;
          return SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                PostImageOrVideoView(
                  post: postWithComments.post,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    // like button if post allows likes
                    if (postWithComments.post.allowsLikes)
                      LikeButton(
                        postId: postId,
                      ),
                    // comment button if post allows comments
                    if (postWithComments.post.allowsComments)
                      IconButton(
                        icon: const Icon(
                          Icons.mode_comment_outlined,
                        ),
                        onPressed: () {
                          Navigator.of(context).push(
                            MaterialPageRoute(
                              builder: (context) =>
                                  PostCommentsPage(postId: postId),
                            ),
                          );
                        },
                      ),
                  ],
                ),
                // post details ( show divider at bottom)
                PostDisplayNameAndMessageView(
                  post: postWithComments.post,
                ),
                PostDateView(
                  dateTime: postWithComments.post.createdAt,
                ),
                const Padding(
                  padding: EdgeInsets.all(8.0),
                  child: Divider(
                    color: Colors.white70,
                  ),
                ),
                CompactCommentsColumn(
                  comments: postWithComments.comments,
                ),

                // adding likes counter of post allows likes
                if (postWithComments.post.allowsLikes)
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Row(
                      children: [
                        LikesCountView(
                          postId: postId,
                        ),
                      ],
                    ),
                  ),
                // add spacing to bottom of screen
                const SizedBox(height: 100)
              ],
            ),
          );
        },
        error: (error, stackTrace) {
          return const ErrorAnimationPage();
        },
        loading: () {
          return const Center(
            child: CircularProgressIndicator(),
          );
        },
      ),
    );
  }
}
