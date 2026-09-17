import 'package:ecommerce/feature/Auth/presentation/Screens/forgetpass.dart';
import 'package:ecommerce/feature/Auth/presentation/Screens/signin.dart';
import 'package:ecommerce/feature/Auth/presentation/Screens/signup.dart';
import 'package:ecommerce/feature/Auth/presentation/Screens/verifyScreen.dart';
import 'package:ecommerce/feature/Splash/presentationLayer/Screens/Splash.dart';

import 'package:ecommerce/feature/Splash/presentationLayer/Screens/onboarding.dart';
import 'package:ecommerce/feature/main/presentation/screens/mainScreen.dart';
import 'package:flutter/material.dart';

Route<dynamic>Ongeneraterouts(RouteSettings setting){
  switch(setting.name){

    case Splash.routname:
      return MaterialPageRoute(builder: (context)=>Splash());
    case OnboardingScreen.routname:
      return MaterialPageRoute(builder: (context)=>OnboardingScreen());
    case Signin.routname:
      return MaterialPageRoute(builder: (context)=>Signin());
    case Signup.routname:
      return MaterialPageRoute(builder: (context)=>Signup());
    case Mainscreen.routname:
      return MaterialPageRoute(builder: (context)=>Mainscreen());
    case forgetpass.routname:
      return MaterialPageRoute(builder: (context)=>forgetpass());
    case verifyscreen.routname:
      return MaterialPageRoute(builder: (context)=>verifyscreen());

    default:return MaterialPageRoute(builder: (context)=>PageNotFound());
  }
}
class PageNotFound extends StatelessWidget{
  const PageNotFound({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(child: Text("Page Not Found"),),
    );
  }

}

