import 'package:ecommerce/cores/utiles/app_assets.dart';
import 'package:ecommerce/feature/Splash/presentationLayer/Screens/onboarding.dart';
import 'package:ecommerce/feature/Splash/presentationLayer/Screens/widgets/Splashbody.dart';
import 'package:flutter/material.dart';

class Splash extends StatelessWidget {
  const Splash({super.key});
  static const routname = "splash";
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SplashBody(
        image: AppAssets.Splash,
        screenName: OnboardingScreen.routname,
      ),
    );
  }
}
