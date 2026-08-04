import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter/material.dart';

class SplashBody extends StatefulWidget {
  const SplashBody({super.key, required this.image, required this.screenName});
  final String image;
  final String screenName;

  @override
  State<SplashBody> createState() => _SplashBodyState();
}

class _SplashBodyState extends State<SplashBody> {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.all(16.r),
      child: Center(child: Image.asset(widget.image)),
    );
    
  }

  @override
  void initState() {
    super.initState();
    wherenavigate();
  }

  void wherenavigate() {
    Future.delayed(Duration(seconds: 3), () {
      Navigator.pushNamed(context, widget.screenName);
    });
  }
}
