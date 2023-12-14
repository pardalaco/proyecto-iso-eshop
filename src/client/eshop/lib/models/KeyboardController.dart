// ignore_for_file: file_names

import 'package:flutter_keyboard_visibility/flutter_keyboard_visibility.dart';
import 'dart:async';
import 'dart:developer' as dev;

class KeyboardController {
  late StreamSubscription<bool> subscription;
  bool keyboardOpen = false;

  KeyboardController() {
    subscription = KeyboardVisibilityController().onChange.listen((isVisible) {
      keyboardOpen = isVisible;
      dev.log(isVisible ? "VISIBLE" : "OCULTO");
    });
  }

  void destroy() {
    subscription.cancel();
  }
}
