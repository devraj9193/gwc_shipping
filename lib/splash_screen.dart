import 'dart:async';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:shipping_app/screens/dashboard_screens/dashboard_screen.dart';
import 'package:shipping_app/screens/dashboard_screens/notification_screen.dart';
import 'package:shipping_app/utils/gwc_apis.dart';
import 'package:shipping_app/widgets/background_widget.dart';
import 'package:shipping_app/utils/constants.dart';
import 'package:shipping_app/widgets/will_pop_widget.dart';
import 'package:sizer/sizer.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'screens/login_screens/shipping_login.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({Key? key}) : super(key: key);

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  final PageController _pageController = PageController(initialPage: 0);
  int _currentPage = 0;
  Timer? _timer;
  static final _notificationsPlugin = FlutterLocalNotificationsPlugin();
  final SharedPreferences _pref = GwcApi.preferences!;

  String loginStatus = "";
  String deviceToken = "";
  bool isLogin = false;

  getPref() async {
    setState(() {
      isLogin = _pref.getBool(GwcApi.isLogin) ?? false;
    });
    print("_pref.getBool(AppConfig.isLogin): ${_pref.getBool(GwcApi.isLogin)}");
    print("isLogin: $isLogin");
    // SharedPreferences preferences = await SharedPreferences.getInstance();
    // setState(() {
    //   loginStatus = preferences.getString(AppConfig().bearerToken)!;
    //   print("Token: $loginStatus");
    // });
  }

  @override
  void initState() {
    getPref();
    requestPermission();
    getToken();
    initInfo();
    _timer = Timer.periodic(const Duration(seconds: 3), (Timer timer) {
      if (_currentPage < 1) {
        _currentPage++;
      } else {
        _currentPage = 1;
      }

      _pageController.animateToPage(
        _currentPage,
        duration: const Duration(milliseconds: 350),
        curve: Curves.easeIn,
      );
    });
    super.initState();
  }

  @override
  void dispose() {
    _timer?.cancel();
    super.dispose();
  }

  initInfo() {
    var initializationSettings = const InitializationSettings(
      android: AndroidInitializationSettings("@mipmap/ic_launcher"),
      iOS: DarwinInitializationSettings(
        requestAlertPermission: true,
        requestBadgePermission: true,
        requestSoundPermission: true,
        defaultPresentAlert: true,
        defaultPresentBadge: true,
        defaultPresentSound: true,
      ),
    );
    _notificationsPlugin.initialize(
      initializationSettings,
      // onDidReceiveNotificationResponse: onDidReceiveNotificationResponse,
    );

    FirebaseMessaging.onMessage.listen((RemoteMessage message) async {
      print("---Firebase Message---");
      print(
          "onMessage: ${message.notification?.title}/${message.notification?.body}");
      BigTextStyleInformation bigTextStyleInformation = BigTextStyleInformation(
        message.notification!.body.toString(),
        htmlFormatBigText: true,
        contentTitle: message.notification!.title.toString(),
        htmlFormatContentTitle: true,
      );
      AndroidNotificationDetails androidPlatformChannelSpecifics =
          AndroidNotificationDetails(
        "gwc",
        "gwc",
        importance: Importance.high,
        styleInformation: bigTextStyleInformation,
        priority: Priority.high,
        playSound: true,
      );
      NotificationDetails platformChannelSpecifics = NotificationDetails(
        android: androidPlatformChannelSpecifics,
        iOS: const DarwinNotificationDetails(),
      );
      await _notificationsPlugin.show(0, message.notification?.title,
          message.notification?.body, platformChannelSpecifics,
          payload: message.data['title']);
    });

    FirebaseMessaging.onMessageOpenedApp.listen(
      (message) async {
        print("FirebaseMessaging.onMessageOpenedApp.listen");
        if (message.notification != null) {
          print(
              "message.notification!.title : ${message.data["title"].toString()}");
          print(message.notification!.body);
          print(message.toMap());
          print("message.data22 ${message.data['notification_type']}");
          await Navigator.push(
            context,
            MaterialPageRoute<void>(
              builder: (context) => const NotificationScreen(),
            ),
          );
        }
      },
    );
  }

  void onDidReceiveNotificationResponse(
      NotificationResponse notificationResponse) async {
    final String? payload = notificationResponse.payload;
    if (notificationResponse.payload != null) {
      debugPrint('notification payload: $payload');
    }
    await Navigator.push(
      context,
      MaterialPageRoute<void>(
        builder: (context) => const NotificationScreen(),
      ),
    );
  }

  void requestPermission() async {
    FirebaseMessaging messaging = FirebaseMessaging.instance;

    NotificationSettings settings = await messaging.requestPermission(
      alert: true,
      announcement: false,
      badge: true,
      carPlay: false,
      criticalAlert: false,
      provisional: false,
      sound: true,
    );

    if (settings.authorizationStatus == AuthorizationStatus.authorized) {
      print("User Granted Permission");
    } else if (settings.authorizationStatus ==
        AuthorizationStatus.provisional) {
      print("User Granted Provisional Permission");
    } else {
      print("User declined or has not accepted Permission");
    }
  }

  void getToken() async {
    await FirebaseMessaging.instance.getToken().then((value) {
      setState(() {
        deviceToken = value!;
        print("Device Token is : $deviceToken");
      });
    });
    SharedPreferences preferences = await SharedPreferences.getInstance();
    preferences.setString("device_token", deviceToken);
  }

  @override
  Widget build(BuildContext context) {
    return WillPopWidget(
      child: Scaffold(
        body: Stack(
          children: <Widget>[
            PageView(
              physics: const NeverScrollableScrollPhysics(),
              onPageChanged: (int page) {
                setState(() {
                  _currentPage = page;
                });
              },
              controller: _pageController,
              children: <Widget>[
                splashImage(),
                (isLogin) ? const DashboardScreen() : const ShippingLogin(),
              ],
            ),
          ],
        ),
      ),
    );
  }

  splashImage1() {
    return LayoutBuilder(builder: (context, constraints) {
      return Stack(
        fit: StackFit.expand,
        children: [
          Container(
            color: gSecondaryColor,
            child: const Image(
              image: AssetImage("assets/images/Group 2657.png"),
              fit: BoxFit.cover,
            ),
          ),
          const Center(
            child: Image(
              image: AssetImage("assets/images/Gut wellness logo green.png"),
            ),
          ),
        ],
      );
    });
  }

  splashImage() {
    return BackgroundWidget(
      assetName: 'assets/images/Group 2657.png',
      child: Center(
        child: Image(
          image: const AssetImage("assets/images/Gut wellness logo green.png"),
          height: 15.h,
        ),
        // SvgPicture.asset(
        //     "assets/images/splash_screen/Splash screen Logo.svg"),
      ),
    );
  }
}
