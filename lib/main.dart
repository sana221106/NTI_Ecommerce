import 'package:ecommerce/cores/help_func/ongenerate_routs.dart';
import 'package:ecommerce/cores/utiles/app_theme.dart';
import 'package:ecommerce/feature/Splash/presentationLayer/Screens/Splash.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

void main() {
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
      builder: (context, child) {
        return MaterialApp(
          debugShowCheckedModeBanner: false,
          title: 'Flutter Demo',
          theme: AppTheme.lightTheme,
          initialRoute: Splash.routname,
          onGenerateRoute: Ongeneraterouts,
        );
      },
      child: const Scaffold(body: Center(child: Text('Hello'))),
    );
  }
}
