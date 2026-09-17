import 'package:ecommerce/cores/help_func/getUserData.dart';
import 'package:ecommerce/cores/help_func/getLocation.dart';
import 'package:ecommerce/cores/utiles/app_assets.dart';
import 'package:ecommerce/feature/Splash/presentationLayer/Screens/onboarding.dart';
import 'package:ecommerce/feature/main/presentation/screens/mainScreen.dart';
import 'package:flutter/material.dart';

class Splash extends StatefulWidget {
  const Splash({super.key});

  static const routname = "splash";

  @override
  State<Splash> createState() => _SplashState();
}

class _SplashState extends State<Splash> {
  @override
  void initState() {
    super.initState();

    checkUser();
    getLocation();
  }

  // ============================================================
  // GET USER LOCATION


  Future<void> getLocation() async {
    try {
      final position = await getUserLocation();

      print('📍 Latitude: ${position.latitude}');
      print('📍 Longitude: ${position.longitude}');
    } catch (e) {
      print('❌ Location Error: $e');
    }
  }

  // ============================================================
  // CHECK USER


  Future<void> checkUser() async {
    await Future.delayed(const Duration(seconds: 3));

   final user = await getUserData();

    if (!mounted) return;

    if (user != null) {

      Navigator.pushReplacementNamed(context, Mainscreen.routname);
    } else {
   
      Navigator.pushReplacementNamed(context, OnboardingScreen.routname);
    }
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(body: Center(child: Image.asset(AppAssets.Splash)));
  }
}
