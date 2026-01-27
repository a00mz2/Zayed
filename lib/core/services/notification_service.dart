// ignore_for_file: avoid_print, unused_local_variable

import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:get/get.dart';
import 'package:zayed/core/services/services.dart';
import 'package:zayed/modules/Agent/Controller/HomeControllerAgent.dart';
import 'package:zayed/modules/Agent/Controller/MainControlIerAgent.dart';
import 'package:zayed/modules/Influencer/controller/HomeControllerInfluencer.dart';

class NotificationService {
  static final FlutterLocalNotificationsPlugin _local =
      FlutterLocalNotificationsPlugin();

  /// ✳️ تخزين بيانات الإشعار في حال فتح التطبيق من حالة مغلقة (terminated)
  static Map<String, dynamic>? initialNotificationData;

  //───────────────────────────────────────────────
  // 🟢 التهيئة الأساسية للنظام بالكامل
  //───────────────────────────────────────────────
  static Future<void> init() async {
    await Firebase.initializeApp();

    // طلب إذن المستخدم للإشعارات (مطلوب في Android 13+)
    await FirebaseMessaging.instance.requestPermission();

    // إعداد الإشعارات المحلية (للعرض داخل التطبيق)
    const androidInit = AndroidInitializationSettings('@mipmap/ic_launcher');
    const settings = InitializationSettings(android: androidInit);

    // ✅ عند الضغط على الإشعار (من النظام المحلي)
    await _local.initialize(
      settings,
      onDidReceiveNotificationResponse: (details) {
        if (details.payload != null && details.payload!.isNotEmpty) {
          final data = _parsePayload(details.payload!);
          onTapNotification(data);
        } else {
          print("❌ لم يتم العثور على بيانات عند الضغط على الإشعار");
        }
      },
    );

    // ✅ عند استقبال إشعار أثناء فتح التطبيق (foreground)
    FirebaseMessaging.onMessage.listen((message) {
      final notification = message.notification;
      final android = message.notification?.android;
      final data = message.data;

      if (notification != null && android != null) {
        // عرض الإشعار محليًا
        _local.show(
          notification.hashCode,
          notification.title,
          notification.body,
          const NotificationDetails(
            android: AndroidNotificationDetails(
              'default_channel',
              'App Notifications',
              importance: Importance.max,
              priority: Priority.high,
              playSound: true,
            ),
          ),
          payload: data.isNotEmpty ? data.toString() : '',
        );

        // تنفيذ دالة عند استلام الإشعار داخل التطبيق
        onReceiveNotification(data);
      }
    });

    // ✅ عند الضغط على الإشعار والتطبيق بالخلفية
    FirebaseMessaging.onMessageOpenedApp.listen((message) {
      if (message.data.isNotEmpty) {
        onTapNotification(message.data);
      }
    });

    // ✅ عند فتح التطبيق من إشعار وهو مغلق (terminated)
    final initialMessage = await FirebaseMessaging.instance.getInitialMessage();
    if (initialMessage != null && initialMessage.data.isNotEmpty) {
      print("🚀 التطبيق فُتح من إشعار (terminated)");
      initialNotificationData = initialMessage.data;
    }

    // 💤 استقبال الإشعارات بالخلفية فقط (للتسجيل)
    FirebaseMessaging.onBackgroundMessage(_backgroundHandler);
  }

  //───────────────────────────────────────────────
  // 🔹 معالج الإشعارات في الخلفية
  //───────────────────────────────────────────────
  static Future<void> _backgroundHandler(RemoteMessage message) async {
    await Firebase.initializeApp();
    print('📩 إشعار بالخلفية: ${message.notification?.title}');
  }

  //───────────────────────────────────────────────
  // 🔹 تحويل الـ payload النصي إلى Map
  //───────────────────────────────────────────────
  static Map<String, dynamic> _parsePayload(String payload) {
    final clean = payload.replaceAll(RegExp(r'[\{\}]'), '');
    final pairs = clean.split(', ');
    final Map<String, dynamic> data = {};
    for (var pair in pairs) {
      final kv = pair.split(':');
      if (kv.length == 2) {
        data[kv[0].trim()] = kv[1].trim();
      }
    }
    return data;
  }

  //───────────────────────────────────────────────
  // 🟢 عند استلام إشعار جديد أثناء التشغيل (foreground)
  //───────────────────────────────────────────────
  static void onReceiveNotification(Map<String, dynamic> data) {
    print("📩 تم استلام إشعار جديد:");
    data.forEach((k, v) => print("➡️ $k : $v"));

    // مثال: تحديث عداد الإشعارات في MainController

    if (myServices.sharedPreferences.getString("role") == "agent") {
      final MainControllerAgent mainController =
          Get.isRegistered<MainControllerAgent>()
          ? Get.find<MainControllerAgent>()
          : Get.put(MainControllerAgent());
      mainController.getNnreadCountNotifications();

      final HomeControllerAgent walletController =
          Get.isRegistered<HomeControllerAgent>()
          ? Get.find<HomeControllerAgent>()
          : Get.put(HomeControllerAgent());

      walletController.getDataWallet();
    } else if (myServices.sharedPreferences.getString("role") == "influencer") {
      final HomeControllerInfluencer walletController =
          Get.isRegistered<HomeControllerInfluencer>()
          ? Get.find<HomeControllerInfluencer>()
          : Get.put(HomeControllerInfluencer());
    }
  }

  //───────────────────────────────────────────────
  // 🟡 عند ضغط المستخدم على الإشعار
  // (سواء من النظام، الخلفية، أو بعد الإغلاق)
  //───────────────────────────────────────────────
  static Future<void> onTapNotification(Map<String, dynamic> data) async {
    print("🖱️ تم الضغط على الإشعار:");
    data.forEach((k, v) => print("➡️ $k : $v"));

    // ننتظر قليلاً حتى يجهز GetX بالكامل
    await Future.delayed(const Duration(milliseconds: 500));

    final type = data['type'];
    Get.toNamed('/Notifications');
  }
}
