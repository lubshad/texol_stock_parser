import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class AppTheme {
  static setSystemOverlay() {
    if (kIsWeb) return;
    SystemChrome.setPreferredOrientations([
      DeviceOrientation.portraitUp,
    ]);
    SystemChrome.setSystemUIOverlayStyle(const SystemUiOverlayStyle(
      statusBarColor: Colors.transparent,
      statusBarIconBrightness: Brightness.dark,
      statusBarBrightness: Brightness.light,
    ));
  }

  static ThemeData get theme => ThemeData.light().copyWith(
      platform: TargetPlatform.iOS,
      appBarTheme: const AppBarTheme(centerTitle: false));
}
