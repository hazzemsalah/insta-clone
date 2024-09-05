import 'dart:io';
import 'package:flutter/foundation.dart' show immutable;
import 'package:instaclone/state/image_upload/models/file_type.dart';

@immutable
class ThumbnailRequest {
  final File file;
  final FileType fileType;

  const ThumbnailRequest({
    required this.file,
    required this.fileType,
  });

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is ThumbnailRequest &&
          runtimeType == other.runtimeType &&
          other.file == file &&
          other.fileType == fileType;

  @override
  int get hashCode => Object.hashAll(
        [
          runtimeType,
          file,
          fileType,
        ],
      );
}
