import 'package:awesome_notifications/awesome_notifications.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:pos/src/controllers/customer_api_controller/customer_api_controller.dart';
import 'package:pos/src/controllers/customer_api_controller/items_api_controllers/items_api_controller.dart';
import 'package:pos/src/controllers/home_controllers.dart';
import 'package:pos/src/controllers/invoice_controllers/invoice_controller.dart';
import 'package:pos/src/controllers/login_api_controllers/login_api_controller.dart';
import 'package:pos/src/controllers/recent_order_controller.dart';
import 'package:pos/src/views/home_view/home_view.dart';
import 'package:pos/src/views/splash_view/splash_screen_view.dart';

Future main() async{
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();

  AwesomeNotifications().initialize(
  // set the icon to null if you want to use the default app icon
  null,
  [
    NotificationChannel(
        channelGroupKey: 'basic_channel_group',
        channelKey: 'basic_channel',
        channelName: 'Basic notifications',
        channelDescription: 'Notification channel for basic tests',
        defaultColor: Color(0xFF9D50DD),
        importance:NotificationImportance.High,
        playSound: true,
        ledColor: Colors.white)
  ],
  // Channel groups are only visual and are not required
  channelGroups: [
    NotificationChannelGroup(
        channelGroupKey: 'basic_channel_group',
        channelGroupName: 'Basic group')
  ],
  debug: true
);

AwesomeNotifications().isNotificationAllowed().then((isAllowed) {
  if (!isAllowed) {
    // This is just a basic example. For real apps, you must show some
    // friendly dialog box before call the request method.
    // This is very important to not harm the user experience
    AwesomeNotifications().requestPermissionToSendNotifications();
  }
});

firebaseNotification();

  FirebaseMessaging.onMessage.listen((RemoteMessage message) {
  print('Got a message whilst in the foreground!');
  print('Message data: ${message.data}');

  if (message.notification != null) {
    print('Message also contained a notification: ${message.notification}');

     AwesomeNotifications().createNotification(
                  content: NotificationContent(
                  id: 10,
                  channelKey: 'basic_channel',
                  title: message.notification!.title,
                  body: message.notification!.body,
                  actionType: ActionType.Default
               ),
              );
  }
});

  Get.put(HomeController());
  Get.put(RecentOrderController());
  Get.put(LoginApiController());
  Get.put(CustomerApiController());
  Get.put(CreateItemsApiController());
  Get.put(InvoiceController());
  runApp(const MyApp());
}

firebaseNotification()async{
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

print('User granted permission: ${settings.authorizationStatus}');
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      title: 'POS',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: SplashScreenView(),
    );
  }
}
