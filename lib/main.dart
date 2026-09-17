import 'package:ecommerce/cores/Serveces/get_it.dart';
import 'package:ecommerce/cores/Serveces/notification/notification_service.dart';
import 'package:ecommerce/cores/help_func/ongenerate_routs.dart';
import 'package:ecommerce/cores/utiles/app_theme.dart';

import 'package:ecommerce/feature/Splash/presentationLayer/Screens/Splash.dart';

import 'package:ecommerce/firebase_options.dart';

import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:hive_flutter/hive_flutter.dart';

Future<void> firebaseMessagingBackgroundHandler(RemoteMessage message) async {
  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);

  print('Handling a background message: ${message.messageId}');
}

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();

  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);

  await Hive.initFlutter();

  FirebaseMessaging.onBackgroundMessage(firebaseMessagingBackgroundHandler);

  setupget_it();

  await get_it<NotificationService>().initialize();

  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return ScreenUtilInit(
      designSize: const Size(375, 812),
      minTextAdapt: true,
      splitScreenMode: true,
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'E-Commerce',
        theme: AppTheme.lightTheme,
        initialRoute: Splash.routname,
        onGenerateRoute: Ongeneraterouts,
      ),
    );
  }
}
