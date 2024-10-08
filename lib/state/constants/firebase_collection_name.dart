import 'package:flutter/foundation.dart' show immutable;
import 'package:flutter/widgets.dart';

@immutable
class FirebaseCollectionName {
  static const thumbnails = "thumnails";
  static const comments = "comments";
  static const likes = "likes";
  static const posts = "posts";
  static const users = "users";

  const FirebaseCollectionName._();
}
