import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:instaclone/firebase_options.dart';
import 'package:instaclone/pages/components/loading/loading_screen.dart';
import 'package:instaclone/pages/login/login_page.dart';
import 'package:instaclone/pages/main/mainpage.dart';
import 'package:instaclone/state/auth/models/auth_result.dart';
import 'package:instaclone/state/auth/providers/auth_state_provider.dart';
import 'package:instaclone/state/providers/is_loading_provider.dart';

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
          // take care of displaying the loading screen
          ref.listen<bool>(
            isLoadingProvider,
            (_, isLoading) {
              if (isLoading) {
                LoadingScreen.instance().show(context: context);
              } else {
                LoadingScreen.instance().hide();
              }
            },
          );

          final isLoggedIn =
              ref.watch(authStateProvider).result == AuthResult.success;
          if (isLoggedIn) {
            return const Mainpage();
          } else {
            return const LoginPage();
          }
        },
      ),
    );
  }
}

