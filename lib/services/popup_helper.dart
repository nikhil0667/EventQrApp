import 'package:flutter/material.dart';

class PopupHelper {
  static final GlobalKey<NavigatorState> navigatorKey =
      GlobalKey<NavigatorState>();

  static void showTokenNotFoundError() {
    print("hi");
    navigatorKey.currentState?.overlay?.insert(
      OverlayEntry(
        builder: (context) => AlertDialog(
          title: const Text('Token not found'),
          content: const Text('Please login to access this feature.'),
          actions: [
            TextButton(
              onPressed: () {
                navigatorKey.currentState?.pop(); // Close the dialog
                // Navigate to login screen or handle authentication logic
              },
              child: const Text('OK'),
            ),
          ],
        ),
      ),
    );
  }
}
