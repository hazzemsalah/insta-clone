import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:instaclone/pages/components/dialogs/alert_dialog_model.dart';
import 'package:instaclone/pages/components/dialogs/logout_dialog.dart';
import 'package:instaclone/pages/constants/strings.dart';
import 'package:instaclone/pages/create_new_post/create_new_post_page.dart';
import 'package:instaclone/pages/tabs/home/home_page.dart';
import 'package:instaclone/pages/tabs/search/search_page.dart';
import 'package:instaclone/pages/tabs/users_posts/user_posts_page.dart';
import 'package:instaclone/state/auth/providers/auth_state_provider.dart';
import 'package:instaclone/state/image_upload/helpers/image_picker_helper.dart';
import 'package:instaclone/state/image_upload/models/file_type.dart';
import 'package:instaclone/state/post_settings/providers/post_settings_provider.dart';

class Mainpage extends ConsumerStatefulWidget {
  const Mainpage({super.key});

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _MainPageState();
}

class _MainPageState extends ConsumerState<Mainpage> {
  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 3,
      child: Scaffold(
        appBar: AppBar(
          title: const Text(
            Strings.appName,
          ),
          actions: [
            IconButton(
              icon: const FaIcon(
                FontAwesomeIcons.film,
              ),
              onPressed: () async {
                // pick a video first
                final videoFile =
                    await ImagePickerHelper.pickVideoFromGallery();
                if (videoFile == null) {
                  return;
                }

                ref.refresh(postSettingProvider);

                // go to the screen to create a new post
                if (!mounted) {
                  return;
                }

                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (_) => CreateNewPostPage(
                      fileToPost: videoFile,
                      fileType: FileType.video,
                    ),
                  ),
                );
              },
            ),
            IconButton(
              icon: const Icon(
                Icons.add_a_photo_outlined,
              ),
              onPressed: () async {
                // pick a video first
                final imageFile =
                    await ImagePickerHelper.pickImageFromGallery();
                if (imageFile == null) {
                  return;
                }

                ref.refresh(postSettingProvider);

                // go to the screen to create a new post
                if (!mounted) {
                  return;
                }

                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (_) => CreateNewPostPage(
                      fileToPost: imageFile,
                      fileType: FileType.image,
                    ),
                  ),
                );
              },
            ),
            IconButton(
              icon: const Icon(
                Icons.logout,
              ),
              onPressed: () async {
                final shouldLogOut = await const LogoutDialog()
                    .present(context)
                    .then((value) => value ?? false);
                if (shouldLogOut) {
                  await ref.read(authStateProvider.notifier).logOut();
                } else {}
              },
            ),
          ],
          bottom: const TabBar(tabs: [
            Tab(
              icon: Icon(
                Icons.person,
              ),
            ),
            Tab(
              icon: Icon(
                Icons.search,
              ),
            ),
            Tab(
              icon: Icon(
                Icons.home,
              ),
            ),
          ]),
        ),
        body: const TabBarView(
          children: [
            UserPostsPage(),
            SearchPage(),
            HomePage(),
          ],
        ),
      ),
    );
  }
}

