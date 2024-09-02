import 'package:flutter/foundation.dart' show immutable, VoidCallback;
import 'package:flutter/material.dart';
import 'package:instaclone/pages/components/rich_text/base_text.dart';

@immutable
class LinkText extends BaseText {
  final VoidCallback onTapped;
  const LinkText({
    required super.text,
    required this.onTapped,
    super.style,
  });
}
