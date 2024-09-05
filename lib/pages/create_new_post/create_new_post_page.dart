import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:instaclone/pages/components/file_thumbnail_view.dart';
import 'package:instaclone/pages/constants/strings.dart';
import 'package:instaclone/state/auth/providers/user_id_provider.dart';
import 'package:instaclone/state/image_upload/models/file_type.dart';
import 'package:instaclone/state/image_upload/models/thumbnail_request.dart';
import 'package:instaclone/state/image_upload/providers/image_uploader_provider.dart';
import 'package:instaclone/state/post_settings/models/post_setting.dart';
import 'package:instaclone/state/post_settings/providers/post_settings_provider.dart';

class CreateNewPostPage extends StatefulHookConsumerWidget {
  final File fileToPost;
  final FileType fileType;
  const CreateNewPostPage({
    super.key,
    required this.fileToPost,
    required this.fileType,
  });

  @override
  ConsumerState<ConsumerStatefulWidget> createState() =>
      _CreateNewPostPageState();
}

class _CreateNewPostPageState extends ConsumerState<CreateNewPostPage> {
  @override
  Widget build(BuildContext context) {
    final thumbnailRequest = ThumbnailRequest(
      file: widget.fileToPost,
      fileType: widget.fileType,
    );
    final postSettings = ref.watch(postSettingProvider);
    final postController = useTextEditingController();
    final isPostButtonEnabled = useState(false);
    useEffect(
      () {
        void listener() {
          isPostButtonEnabled.value = postController.text.isNotEmpty;
        }

        postController.addListener(listener);

        return () {
          postController.removeListener(listener);
        };
      },
      [postController],
    );
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          Strings.createNewPost,
        ),
        actions: [
          IconButton(
            icon: const Icon(Icons.send),
            onPressed: isPostButtonEnabled.value
                ? () async {
                    final userId = ref.read(userIdProvider);
                    if (userId == null) {
                      return;
                    }
                    final message = postController.text;
                    final isUpladed =
                        await ref.read(imageUploadProvider.notifier).upload(
                              file: widget.fileToPost,
                              fileType: widget.fileType,
                              message: message,
                              postSettings: postSettings,
                              userId: userId,
                            );
                    if (isUpladed && mounted) {
                      Navigator.of(context).pop();
                    }
                  }
                : null,
          ),
        ],
      ),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            //thumbnail
            FileThumbnailview(
              thumbnailRequest: thumbnailRequest,
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: TextField(
                decoration: const InputDecoration(
                  labelText: Strings.pleaseWriteYourMessageHere,
                ),
                autofocus: true,
                maxLines: null,
                controller: postController,
              ),
            ),
            ...PostSetting.values.map(
              (postSetting) => ListTile(
                title: Text(postSetting.title),
                subtitle: Text(postSetting.descreption),
                trailing: Switch(
                  value: postSettings[postSetting] ?? false,
                  onChanged: (isOn) {
                    ref.read(postSettingProvider.notifier).setSetting(
                          postSetting,
                          isOn,
                        );
                  },
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
