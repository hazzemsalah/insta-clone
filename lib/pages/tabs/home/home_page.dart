import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:instaclone/pages/components/animations/empty_contents_with_text_animation_page.dart';
import 'package:instaclone/pages/components/animations/error_animation_page.dart';
import 'package:instaclone/pages/components/animations/loading_animation_page.dart';
import 'package:instaclone/pages/components/post/posts_grid_view.dart';
import 'package:instaclone/pages/constants/strings.dart';
import 'package:instaclone/state/posts/providers/all_posts_provider.dart';

class HomePage extends ConsumerWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final posts = ref.watch(allPostsProvider);
    return RefreshIndicator(
      onRefresh: () {
        ref.refresh(allPostsProvider);
        return Future.delayed(
          const Duration(seconds: 1),
        );
      },
      child: posts.when(
        data: (posts) {
          if (posts.isEmpty) {
            return const EmptyContentsWithTextAnimationPage(
              text: Strings.noPostAvailable,
            );
          } else {
            return PostsGridView(
              posts: posts,
            );
          }
        },
        error: (error, stackTrace) {
          return const ErrorAnimationPage();
        },
        loading: () {
          return const LoadingAnimationPage();
        },
      ),
    );
  }
}
