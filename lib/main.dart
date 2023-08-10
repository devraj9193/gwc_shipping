import 'dart:io';

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:shipping_app/splash_screen.dart';
import 'package:shipping_app/utils/gwc_apis.dart';
import 'package:sizer/sizer.dart';
import 'package:get/get.dart';
import 'package:device_preview/device_preview.dart' hide DeviceType;
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:upgrader/upgrader.dart';
import 'package:store_redirect/store_redirect.dart';

import 'model/internet_connection/dependency_injecion.dart';

Future<void> backgroundHandler(RemoteMessage message) async {
  print(message.data.toString());
  print(message.notification);
}

// Future<void> main() async {
//   WidgetsFlutterBinding.ensureInitialized();
//   await Firebase.initializeApp();
//   await FirebaseMessaging.instance.getInitialMessage();
//   FirebaseMessaging.onBackgroundMessage(backgroundHandler);
// await Upgrader.clearSavedSettings();
//
// DependencyInjection.init();
//   runApp(const MyApp());
// }

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  await FirebaseMessaging.instance.getInitialMessage();
  GwcApi.preferences = await SharedPreferences.getInstance();
  FirebaseMessaging.onBackgroundMessage(backgroundHandler);
  SystemChrome.setSystemUIOverlayStyle(
    const SystemUiOverlayStyle(statusBarColor: Colors.transparent),
  );
  await Upgrader.clearSavedSettings();

  DependencyInjection.init();
  runApp(
    DevicePreview(
      enabled: !kReleaseMode,
      builder: (context) => const MyApp(), // Wrap your app
    ),
  );
}

class MyApp extends StatefulWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  @override
  Widget build(BuildContext context) {
    const appCastURL =
        'https://github.com/devraj9193/gwc_shipping/blob/master/test/AppCast.xml';
    final cfg = AppcastConfiguration(url: appCastURL, supportedOS: ['android']);

    SystemChrome.setPreferredOrientations(
        [DeviceOrientation.landscapeLeft, DeviceOrientation.landscapeRight]);

    return Sizer(builder:
        (BuildContext context, Orientation orientation, DeviceType deviceType) {
      if (deviceType == DeviceType.tablet) {}
      return GetMaterialApp(
        debugShowCheckedModeBanner: false,
        home: UpgradeAlert(
          upgrader: Upgrader(
            appcastConfig: cfg,
            durationUntilAlertAgain: const Duration(days: 1),
            dialogStyle: Platform.isIOS
                ? UpgradeDialogStyle.cupertino
                : UpgradeDialogStyle.material,
            shouldPopScope: () => true,
            messages: UpgraderMessages(code: 'en'),
            onIgnore: () {
              SystemNavigator.pop();
              throw UnsupportedError('_');
            },
            onUpdate: () {
              launchURL();
              return true;
            },
            onLater: () {
              SystemNavigator.pop();
              throw UnsupportedError('_');
            },
          ),
          child: SplashScreen(),
        ),
      );
    });
  }

  launchURL() async {
    StoreRedirect.redirect(
      androidAppId: "com.fembuddy.gwc_shipping",
      // iOSAppId: "284882215",
    );
  }
}
