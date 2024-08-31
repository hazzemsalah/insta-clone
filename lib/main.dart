import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:instaclone/firebase_options.dart';
import 'package:instaclone/pages/components/loading/loading_screen.dart';
import 'package:instaclone/state/auth/models/auth_result.dart';
import 'package:instaclone/state/auth/providers/auth_state_provider.dart';
import 'dart:developer' as devtools show log;

extension Log on Object {
  void log() => devtools.log(toString());
}

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  runApp(
    const ProviderScope(
      child: MyApp(),
    ),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData(
        brightness: Brightness.dark,
        primarySwatch: Colors.blueGrey,
        indicatorColor: Colors.blueGrey,
      ),
      darkTheme: ThemeData.dark(),
      debugShowCheckedModeBanner: false,
      home: Consumer(
        builder: (context, ref, child) {
          final isLoggedIn =
              ref.watch(authStateProvider).result == AuthResult.success;
          isLoggedIn.log();
          if (isLoggedIn) {
            return const MainPage();
          } else {
            return const LoginPage();
          }
        },
      ),
    );
  }
}

// for when you already logged in
class MainPage extends StatelessWidget {
  const MainPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: const Text('Main Page'),
        ),
        body: Consumer(
          builder: (context, ref, child) {
            return TextButton(
              onPressed: () async {
                await ref.read(authStateProvider.notifier).logOut();
              },
              child: const Text(
                "Logout",
              ),
            );
          },
        ));
  }
}

// for when you are not logged in
class LoginPage extends ConsumerWidget {
  const LoginPage({
    super.key,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Login Page'),
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          TextButton(
            onPressed: ref.read(authStateProvider.notifier).lofInWithGoogle,
            child: const Text(
              "Sign In with Google",
            ),
          ),
          TextButton(
            onPressed: ref.read(authStateProvider.notifier).lofInWithFacebook,
            child: const Text(
              "Sign In with Facebook",
            ),
          ),
        ],
      ),
    );
  }
}
