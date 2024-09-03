import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:instaclone/pages/components/dialogs/alert_dialog_model.dart';
import 'package:instaclone/pages/components/dialogs/logout_dialog.dart';
import 'package:instaclone/pages/constants/strings.dart';
import 'package:instaclone/pages/tabs/users_posts/user_posts_page.dart';
import 'package:instaclone/state/auth/providers/auth_state_provider.dart';

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
              onPressed: () async {},
            ),
            IconButton(
              icon: const Icon(
                Icons.add_a_photo_outlined,
              ),
              onPressed: () async {},
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
            UserPostsView(),
            UserPostsView(),
            UserPostsView(),
          ],
        ),
      ),
    );
  }
}
