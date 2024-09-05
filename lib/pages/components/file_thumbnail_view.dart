import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:instaclone/pages/components/animations/loading_animation_page.dart';
import 'package:instaclone/pages/components/animations/small_error_animation_page.dart';
import 'package:instaclone/state/image_upload/models/thumbnail_request.dart';
import 'package:instaclone/state/image_upload/providers/thumbnail_provider.dart';

class FileThumbnailview extends ConsumerWidget {
  final ThumbnailRequest thumbnailRequest;
  const FileThumbnailview({
    super.key,
    required this.thumbnailRequest,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final thumbnail = ref.watch(thumbnailProvider(thumbnailRequest));
    return thumbnail.when(
      data: (imageWithAspectRatio) {
        return AspectRatio(
          aspectRatio: imageWithAspectRatio.aspectRatio,
          child: imageWithAspectRatio.image,
        );
      },
      loading: () {
        return const LoadingAnimationPage();
      },
      error: (error, stackTrace) {
        return const SmallErrorAnimationPage();
      },
    );
  }
}
