import 'package:instaclone/state/post_settings/constants/constants.dart';

enum PostSetting {
  allowLikes(
    title: Constants.allowLikesTilte,
    descreption: Constants.allowLikesDescription,
    storageKey: Constants.allowLikeStorageKey,
  ),

  allowComments(
    title: Constants.allowCommentsTitle,
    descreption: Constants.allowCommentsDescription,
    storageKey: Constants.allowCommentsStorageKey,
  );

  final String title;
  final String descreption;
  final String storageKey;

  const PostSetting({
    required this.title,
    required this.descreption,
    required this.storageKey,
  });
}
