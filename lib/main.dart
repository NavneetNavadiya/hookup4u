import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:hookup4u/Screens/Splash.dart';
import 'package:hookup4u/subscription/purchase.dart';
import 'package:hookup4u/util/color.dart';
import 'package:in_app_purchase/in_app_purchase.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:firebase_core/firebase_core.dart';
import 'app.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  InAppPurchaseConnection.enablePendingPurchases();
  SystemChrome.setPreferredOrientations([
    DeviceOrientation.portraitDown,
    DeviceOrientation.portraitUp,
  ]).then((_) {
    SharedPreferences.getInstance().then((prefs) {
      sharedPreferences = prefs;
      runApp(MyApp());
    });
  });
}

void configLoading() {
  EasyLoading.instance
    ..displayDuration = const Duration(milliseconds: 2000)
    ..indicatorType = EasyLoadingIndicatorType.doubleBounce
    ..maskType = EasyLoadingMaskType.custom
    ..loadingStyle = EasyLoadingStyle.custom
    ..indicatorSize = 100
    ..radius = 10.0
    ..progressColor = Colors.yellow
    ..backgroundColor = Colors.transparent
    ..indicatorColor = Colors.white
    ..textColor = Colors.yellow
    // ..maskColor = Colors.black.withOpacity(0.5)
    ..userInteractions = false;
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData(
        primaryColor: ColorRes.primaryColor,
      ),
      home: Splash(),
      debugShowCheckedModeBanner: false,
      builder: (BuildContext context, Widget child) {
        /// make sure that loading can be displayed in front of all other widgets
        return FlutterEasyLoading(child: child);
      },
    );
  }
}
