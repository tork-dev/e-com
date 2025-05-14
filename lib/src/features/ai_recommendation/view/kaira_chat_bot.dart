import 'package:flutter/material.dart';
import 'package:kirei/src/features/web_view/web_view.dart';
import 'package:kirei/src/utils/local_storage/storage_utility.dart';
import '../../../utils/local_storage/local_storage_keys.dart';

class AppKairaChatBot extends StatelessWidget {
  const AppKairaChatBot({super.key});

  @override
  Widget build(BuildContext context) {
    return WebViewScreen(
        url: "${AppLocalStorage().readData(LocalStorageKeys.appUrl)}/chat",
        title: "Chat with kaira",
      bodyPadding: 0,
    );
  }
}

