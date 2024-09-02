import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:instaclone/pages/constants/strings.dart';
import 'package:instaclone/pages/components/rich_text/base_text.dart';
import 'package:instaclone/pages/components/rich_text/rich_text_widget.dart';

class LoginPageSignupLinks extends StatelessWidget {
  const LoginPageSignupLinks({super.key});

  @override
  Widget build(BuildContext context) {
    return RichTextWidget(
      styleForAll: Theme.of(context).textTheme.bodySmall?.copyWith(height: 1.5),
      texts: [
        BaseText.plain(
          text: Strings.dontHaveAnAccount,
          style: Theme.of(context).textTheme.bodyMedium,
        ),
        BaseText.plain(
          text: Strings.signUpOn,
          style: Theme.of(context).textTheme.bodyMedium,
        ),
        BaseText.link(
          text: Strings.facebook,
          onTapped: () {
            launchUrl(
              Uri.parse(Strings.facebookSignupUrl),
            );
          },
        ),
        BaseText.plain(
          text: Strings.orCreateAnAccountOn,
          style: Theme.of(context).textTheme.bodyMedium,
        ),
        BaseText.link(
          text: Strings.google,
          onTapped: () {
            launchUrl(
              Uri.parse(Strings.googleSignupUrl),
            );
          },
        ),
      ],
    );
  }
}
