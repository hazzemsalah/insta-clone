import 'package:flutter/material.dart';
import 'package:instaclone/pages/components/animations/empty_contents_animation_page.dart';

class EmptyContentsWithTextAnimationPage extends StatelessWidget {
  final String text;
  const EmptyContentsWithTextAnimationPage({super.key, required this.text});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(32),
            child: Text(
              text,
              style: Theme.of(context)
                  .textTheme
                  .titleLarge
                  ?.copyWith(color: Colors.white54),
            ),
          ),
          const EmptyContentsAnimationPage(),
        ],
      ),
    );
  }
}
