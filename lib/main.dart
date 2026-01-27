// ignore_for_file: avoid_print

import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:flutter/services.dart';
import 'package:zayed/Binding/InitialBindings.dart';
import 'package:zayed/core/constant/Themes/lightThem.dart';
import 'package:zayed/core/constant/routes.dart';
import 'package:zayed/core/services/notification_service.dart';
import 'package:zayed/core/services/services.dart';
import 'package:zayed/firebase_options.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await initialservices();
  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);
  await NotificationService.init();

  runApp(const MyApp());

  SystemChrome.setSystemUIOverlayStyle(
    const SystemUiOverlayStyle(
      statusBarColor: Colors.transparent,
      statusBarIconBrightness: Brightness.light,
    ),
  );

  // WidgetsBinding.instance.addPostFrameCallback((_) async {
  //   await Future.delayed(const Duration(milliseconds: 800));
  //   if (NotificationService.initialNotificationData != null) {
  //     print("🚀 تنفيذ الإشعار بعد تشغيل GetX بالكامل");
  //     NotificationService.onTapNotification(
  //       NotificationService.initialNotificationData!,
  //     );
  //     NotificationService.initialNotificationData = null;
  //   }
  // });
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});
  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      debugShowCheckedModeBanner: false,
      title: "زايد",
      theme: lightTheme,
      locale: const Locale('ar'),
      supportedLocales: const [Locale('ar')],
      localizationsDelegates: const [
        GlobalMaterialLocalizations.delegate,
        GlobalWidgetsLocalizations.delegate,
        GlobalCupertinoLocalizations.delegate,
      ],
      initialBinding: InitialBindings(),
      defaultTransition: Transition.downToUp,
      transitionDuration: const Duration(milliseconds: 400),
      initialRoute: "/Splash",
      getPages: routes,
    );
  }
}
