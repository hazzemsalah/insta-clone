import 'package:flutter/foundation.dart' show immutable;

@immutable
class Constants {
  static const allowLikesTilte = 'Allow likes';
  static const allowLikesDescription =
      'By allowing likes, users be able to like button on your post ..';
  static const allowLikeStorageKey = 'allow_likes';
  static const allowCommentsTitle = 'Allow comments';
  static const allowCommentsDescription =
      'By allowing comments, users will be able to comment on your post ..';
  static const allowCommentsStorageKey = 'allow_comments';
  const Constants._();
}
