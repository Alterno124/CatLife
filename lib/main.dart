import 'package:catage/NewsDetails.dart';
import 'package:catage/SplashScreen.dart';
import 'package:catage/age.dart';
import 'package:catage/age_human.dart';
import 'package:catage/generated/l10n.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:google_mobile_ads/google_mobile_ads.dart';

const AndroidNotificationChannel channel = AndroidNotificationChannel(
  'high_importance_channel', // id
  'High Importance Notifications', // title
  'This channel is used for important notifications.',
  importance: Importance.max, // description
);

final FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin =
    FlutterLocalNotificationsPlugin();

Future<void> _firebaseMessagingBackgroundHandler(RemoteMessage message) async {
  await Firebase.initializeApp();
  print('A bg message just showed up :  ${message.messageId}');
}

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  MobileAds.instance.initialize();
  await Firebase.initializeApp();
  await flutterLocalNotificationsPlugin
      .resolvePlatformSpecificImplementation<
          AndroidFlutterLocalNotificationsPlugin>()
      ?.createNotificationChannel(channel);
  FirebaseMessaging.onBackgroundMessage(_firebaseMessagingBackgroundHandler);
  createData();
  runApp(Main());
}

createData() async {
  print("el token es: ");
  print(FirebaseMessaging.instance.getToken());
  FirebaseApp firebaseApp = await Firebase.initializeApp();
  DocumentReference documentReference = await FirebaseFirestore.instance
      .collection("usuarios")
      .doc(await FirebaseMessaging.instance.getToken());
  Map<String, dynamic> usuario = {
    "token": await FirebaseMessaging.instance.getToken(),
  };
  documentReference.set(usuario).whenComplete(() async {
    print("El codigo es");
    print(await FirebaseMessaging.instance.getToken());
  });
}

class Main extends StatefulWidget {
  @override
  _MainState createState() => _MainState();
}

class _MainState extends State<Main> {
  GlobalKey<NavigatorState> navigatorKey = GlobalKey<NavigatorState>();

  @override
  void initState() {
    super.initState();
    FirebaseMessaging.onMessage.listen((RemoteMessage message) async {
      RemoteNotification notification = message.notification;
      AndroidNotification android = message.notification?.android;
      if (notification != null && android != null) {
        flutterLocalNotificationsPlugin.show(
            notification.hashCode,
            notification.title,
            notification.body,
            NotificationDetails(
              android: AndroidNotificationDetails(
                  channel.id, channel.name, channel.description,
                  priority: Priority.high, importance: Importance.max),
            ));
        /*Navigator.push(navigatorKey.currentState.context,
            MaterialPageRoute(builder: (context) => NewsDetails()));*/
      }
    });

    FirebaseMessaging.onMessageOpenedApp.listen((RemoteMessage message) async {
      print('A new onMessageOpenedApp event was published!');
      RemoteNotification notification = message.notification;
      AndroidNotification android = message.notification?.android;
      /*if (notification != null && android != null) {
        Navigator.push(navigatorKey.currentState.context,
            MaterialPageRoute(builder: (context) => NewsDetails()));
        message.data.forEach((key, value) {
          if (key == "melo") {
            print("la llave es melo");
          }
        });
        /*showDialog(
            context: context,
            builder: (_) {
              return AlertDialog(
                title: Text(notification.title),
                content: SingleChildScrollView(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [Text(notification.body)],
                  ),
                ),
              );
            });*/
      }*/
    });
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      navigatorKey: navigatorKey,
      localizationsDelegates: [
        GlobalMaterialLocalizations.delegate,
        GlobalWidgetsLocalizations.delegate,
        GlobalCupertinoLocalizations.delegate,
        S.delegate,
      ],
      supportedLocales: S.delegate.supportedLocales,
      debugShowCheckedModeBanner: false,
      home: SplashScreen(),
    );
  }
}
