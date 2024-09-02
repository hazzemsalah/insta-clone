import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:instaclone/pages/constants/app_colors.dart';
import 'package:instaclone/pages/constants/strings.dart';
import 'package:instaclone/pages/login/divider_with_margins.dart';
import 'package:instaclone/pages/login/facebook_button.dart';
import 'package:instaclone/pages/login/google_button.dart';
import 'package:instaclone/pages/login/login_page_signup_links.dart';
import 'package:instaclone/state/auth/providers/auth_state_provider.dart';

class LoginPage extends ConsumerWidget {
  const LoginPage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: const Text(
          Strings.appName,
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              const SizedBox(height: 40.0),
              Text(
                Strings.welcomeToAppName,
                textAlign:TextAlign.center,
                style: Theme.of(context).textTheme.displayMedium,
              ),
              const SizedBox(height: 10),
              const DividerWithMargins(),
              const SizedBox(height: 10),
              Text(
                Strings.logIntoYourAccount,
                style: Theme.of(context)
                    .textTheme
                    .bodyMedium
                    ?.copyWith(height: 1.5),
              ),
              const SizedBox(height: 20),
              TextButton(
                style: TextButton.styleFrom(
                  backgroundColor: AppColors.loginButtonColor,
                  foregroundColor: AppColors.loginButtonTextColor,
                ),
                onPressed:
                    ref.read(authStateProvider.notifier).lofInWithFacebook,
                child: const FacebookButton(),
              ),
              const SizedBox(height: 20),
              TextButton(
                style: TextButton.styleFrom(
                  backgroundColor: AppColors.loginButtonColor,
                  foregroundColor: AppColors.loginButtonTextColor,
                ),
                onPressed: ref.read(authStateProvider.notifier).logInWithGoogle,
                child: const GoogleButton(),
              ),
              const SizedBox(height: 10),
              const DividerWithMargins(),
              const LoginPageSignupLinks(),
            ],
          ),
        ),
      ),
    );
  }
}
