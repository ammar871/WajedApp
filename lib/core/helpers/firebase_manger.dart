import 'package:awesome_notifications/awesome_notifications.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:wajed_app/core/helpers/helper_functions.dart';
import '../utils/app_model.dart';
import 'notification_controller.dart';

  @pragma('vm:entry-point')
  Future<void> _firebaseMessagingBackgroundHandler(
      RemoteMessage message) async {
    await Firebase.initializeApp();
  }

class FCMManger {
  late FirebaseMessaging messaging;

 // * constractor
  FCMManger() {
    messaging = FirebaseMessaging.instance;
  }

  // * init firebase
  // Future initFirebase() async {
   
  // }

 

  /// * init firebase messaging

  Future<void> initFCM() async {
  //  await initFirebase();
    NotificationSettings settings = await  messaging.requestPermission(
      alert: true,
      announcement: false,
      badge: true,
      carPlay: false,
      criticalAlert: false,
      provisional: false,
      sound: true,
    );

    debugPrint('User granted permission: ${settings.authorizationStatus}');
    FirebaseMessaging.onBackgroundMessage(_firebaseMessagingBackgroundHandler);
    FirebaseMessaging.onMessageOpenedApp;
    initLocalNotification();
  }

  /// * open page when tap notification
  Future<void> openPage(String route) async {}


  Future getMessagesFCM() async {
    await opnedMessage();
    FirebaseMessaging.onMessage.listen((RemoteMessage message) {
      RemoteNotification? notification = message.notification;
      //  AndroidNotification? android = message.notification?.android;

      // NotifyAowsome(notification!.title!,notification.body!);
      if (notification != null && !kIsWeb) {
       pushLocalNotification(title: notification.title!, body: notification.body!);
      }
    });
  }

  /// * get fcm token
  Future getFCMToken()async {
    // if (Platform.isIOS) {
    //   FirebaseMessaging.instance.requestPermission(
    //     alert: true,
    //     announcement: false,
    //     badge: true,
    //     carPlay: false,
    //     criticalAlert: false,
    //     provisional: false,
    //     sound: true,
    //   );
    // }

    FirebaseMessaging.instance.getToken().then((token) {
      AppModel.deviceToken = token!;
     
    });
  }

 
 Future opnedMessage() async{
   /// OPEN app when is closed
    FirebaseMessaging.instance.getInitialMessage().then((message) {
      // debugPrint("${message!.notification!.title!}===============> opened");
      // handelNotificationInBackground(message);
      // pushPageRoutName(context, notyUser);
    });

  /// when click notification is background
 FirebaseMessaging.onMessageOpenedApp.listen((message) {
      // debugPrint("${message.notification!.title!}===============> opened");
      // handelNotificationInBackground(message);
      // pushPageRoutName(context, notyUser);
    });

  }

  /// when click notification is background
//  Future opnedMessageWhenAppBackground()async {
//     FirebaseMessaging.onMessageOpenedApp.listen((message) {
//       debugPrint("${message.notification!.title!}===============> opened");
//       // handelNotificationInBackground(message);
//       // pushPageRoutName(context, notyUser);
//     });
//   }

  // * LOCAL notifications
  /// * init local
  void initLocalNotification() {
    AwesomeNotifications().initialize(null, [
      NotificationChannel(
          channelKey: AppModel.alertChannelKey,
          channelName: AppModel.alertChannelName,
          channelDescription: AppModel.alertChannelDesc,
          defaultColor: Colors.transparent,
          ledColor: Colors.blue,
          channelShowBadge: true,
          importance: NotificationImportance.High,
          playSound: true,
          // soundSource:"resource://raw/alerm"
          // enableLights:true,
          enableVibration: true)
    ]);
  }

  /// * PUSH local Notification
  void pushLocalNotification({title, body}) {
    debugPrint(
        "noty  pushed================================================================>");
    AwesomeNotifications().createNotification(
        content: NotificationContent(
      id: createUniqueId(),
      color: Colors.blue,
      channelKey: AppModel.alertChannelKey,
      title: title,
      body: body,

      // notificationLayout: NotificationLayout.BigPicture,
      // largeIcon: "asset://assets/images/logo_final.png"
    ));
  }

  /// * lestin notifications
  listenNotification() {
    AwesomeNotifications().setListeners(
        onActionReceivedMethod: NotificationController.onActionReceivedMethod,
        onNotificationCreatedMethod:
            NotificationController.onNotificationCreatedMethod,
        onNotificationDisplayedMethod:
            NotificationController.onNotificationDisplayedMethod,
        onDismissActionReceivedMethod:
            NotificationController.onDismissActionReceivedMethod);
  }
}
