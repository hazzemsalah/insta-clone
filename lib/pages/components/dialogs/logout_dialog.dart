import 'package:flutter/foundation.dart' show immutable;
import 'package:instaclone/pages/components/constants/strings.dart';
import 'package:instaclone/pages/components/dialogs/alert_dialog_model.dart';

@immutable
class LogoutDialog extends AlertDialogModel<bool>{
  const LogoutDialog()
      : super(
          title: Strings.logOut,
          message: Strings.areYouSureYouWantToLogOutTheApp,
          buttons: const {
            Strings.cancel: false,
            Strings.logOut: true,
          },
        );
}
