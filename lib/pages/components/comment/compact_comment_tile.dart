import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:instaclone/pages/components/animations/small_error_animation_page.dart';
import 'package:instaclone/pages/components/rich_two_parts_text.dart';
import 'package:instaclone/state/comments/models/comment.dart';
import 'package:instaclone/state/user_info/providers/user_info_model_provider.dart';

class CompactCommentTile extends ConsumerWidget {
  final Comment comment;
  const CompactCommentTile({
    super.key,
    required this.comment,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final userInfo = ref.watch(
      userInfoModelProvider(
        comment.fromUserId,
      ),
    );
    return userInfo.when(
      data: (userInfo) {
        return RichTwoPartsText(
          leftPart: userInfo.displayName,
          rightPart: comment.comment,
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
    );
  }
}

class SmallErrorAnimationView {
  const SmallErrorAnimationView();
}