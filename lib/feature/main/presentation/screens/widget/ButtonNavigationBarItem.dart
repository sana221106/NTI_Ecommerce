import 'package:ecommerce/feature/main/domain/entities/buttonNavigationbarEntity.dart';
import 'package:ecommerce/feature/main/presentation/screens/widget/Activeitem.dart';
import 'package:ecommerce/feature/main/presentation/screens/widget/inActiveitem.dart';
import 'package:flutter/material.dart';

class ButtonNavigationBarItem extends StatelessWidget {
  final bool isActive;
  final Buttonnavigationbarentity buttonnavigationbarentity;
  const ButtonNavigationBarItem({super.key, required this.isActive, required this.buttonnavigationbarentity});

  @override
  Widget build(BuildContext context) {
    return isActive
        ?  Activeitem(image: buttonnavigationbarentity.Activeimage)
        :  Inactiveitem(image: buttonnavigationbarentity.Inactiveimage);
  }
}