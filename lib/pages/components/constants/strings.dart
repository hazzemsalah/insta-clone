import 'package:flutter/foundation.dart' show immutable;

@immutable
class Strings {
  static const allowLikesTilte = 'Allow likes';
  static const allowLikesDescription =
      'By allowing likes, users be able to like button on your post ..';
  static const allowLikeStorageKey = 'allow_likes';
  static const allowCommentsTitle = 'Allow comments';
  static const allowCommentsDescription =
      'By allowing comments, users will be able to comment on your post ..';
  static const allowCommentsStorageKey = 'allow_comments';

  static const comment = 'comment';
  static const loading = 'Loading...';
  static const people = 'people';
  static const likedThis = 'liked this';

  static const delete = 'Delete';
  static const ateYouSureYouWantToDeleteThis =
      'Are you sure you want to delete this?';

  static const logOut = 'Log out';
  static const areYouSureYouWantToLogOutTheApp =
      'Are you sure that you want to log out of the app?';
  static const cancel = 'Cancel';

  const Strings._();
}
