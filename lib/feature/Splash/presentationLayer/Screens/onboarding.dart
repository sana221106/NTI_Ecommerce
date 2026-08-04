import 'package:ecommerce/cores/utiles/app_assets.dart';
import 'package:ecommerce/cores/widgets/CustomButton.dart';
import 'package:ecommerce/feature/Auth/presentation/Screens/signin.dart';
import 'package:ecommerce/feature/Splash/presentationLayer/Screens/widgets/onboardingbody.dart';
import 'package:flutter/material.dart';
import 'package:introduction_screen/introduction_screen.dart';

class OnboardingScreen extends StatelessWidget {
  const OnboardingScreen({super.key});

  static const String routname = "onboarding";

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: IntroductionScreen(
        pages: [
          PageViewModel(
            title: "",
            bodyWidget: const SplashBody(image: AppAssets.onboarding1),
          ),
          PageViewModel(
            title: "",
            bodyWidget: Column(
              children: [
                const SplashBody(image: AppAssets.onboarding2),
                CustomButton(
                  title: "ابدا الان",
                  onPressed: () {
                    Navigator.pushReplacementNamed(context, Signin.routname);
                  },
                ),
              ],
            ),
          ),
        ],

        showSkipButton: false,
        showNextButton: false,
        showDoneButton: false,

        // done: const Text(
        //   "Done",
        //   style: TextStyle(fontWeight: FontWeight.bold, color: Colors.green),
        // ),

        // onDone: () {
        //   Navigator.pushReplacementNamed(context, Signin.routname);
        // },

        dotsDecorator: const DotsDecorator(
          size: Size(10, 10),
          activeSize: Size(10, 10),
          color: Colors.grey,
          activeColor: Colors.green,
          spacing: EdgeInsets.symmetric(horizontal: 4),
        ),
      ),
    );
  }
}
