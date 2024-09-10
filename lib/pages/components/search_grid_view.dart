import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:instaclone/pages/components/animations/data_not_found_animatoin_page.dart';
import 'package:instaclone/pages/components/animations/empty_contents_with_text_animation_page.dart';
import 'package:instaclone/pages/components/animations/error_animation_page.dart';
import 'package:instaclone/pages/components/post/post_sliver_grid_view.dart';
import 'package:instaclone/pages/constants/strings.dart';
import 'package:instaclone/state/posts/providers/posts_by_search_term_provider.dart';

class SearchGridView extends ConsumerWidget {
  final String searchTerm;
  const SearchGridView({
    super.key,
    required this.searchTerm,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    if (searchTerm.isEmpty) {
      return const SliverToBoxAdapter(
        child: EmptyContentsWithTextAnimationPage(
          text: Strings.enterYourSearchTerm,
        ),
      );
    }
    final posts = ref.watch(
      postsBySearchTermProvider(
        searchTerm,
      ),
    );

    return posts.when(
      data: (posts) {
        if (posts.isEmpty) {
          return const SliverToBoxAdapter(
            child: DataNotFoundAnimatoinPage(),
          );
        } else {
          return PostsSliverGridView(
            posts: posts,
          );
        }
      },
      error: (error, stackTrace) {
        return const SliverToBoxAdapter(
          child: ErrorAnimationPage(),
        );
      },
      loading: () {
        return const SliverToBoxAdapter(
          child: Center(
            child: CircularProgressIndicator(),
          ),
        );
      },
    );
  }
}
