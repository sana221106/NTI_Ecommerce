import 'package:ecommerce/cores/utiles/app_colors.dart';
import 'package:ecommerce/feature/main/domain/entities/buttonNavigationbarEntity.dart';
import 'package:ecommerce/feature/main/presentation/screens/widget/ButtonNavigationBarItem.dart';
import 'package:flutter/material.dart';

class customBottomNavigationBar extends StatefulWidget {
  final ValueChanged<int>indexChanged;
  const customBottomNavigationBar({super.key, required this.indexChanged});

  @override
  State<customBottomNavigationBar> createState() => _customBottomNavigationBarState();
}

class _customBottomNavigationBarState extends State<customBottomNavigationBar> {
  int selectedIndex = 0;
  
  @override
  Widget build(BuildContext context) {
    List<Buttonnavigationbarentity> items = [
      Buttonnavigationbarentity(
          Activeimage: "assets/images/SelectedHome.png",
          Inactiveimage: "assets/images/unselectedHome.png",
          name: "الرئيسية"),
      Buttonnavigationbarentity(
          Activeimage: "assets/images/SelectedProduct.png",
          Inactiveimage: "assets/images/unselectedproduct.png",
          name: "المنتجات"),
      Buttonnavigationbarentity(
          Activeimage: "assets/images/SelectedCart.png",
          Inactiveimage: "assets/images/unselectedcart.png",
          name: "سله التسوق"),
      Buttonnavigationbarentity(
          Activeimage: "assets/images/unselectedaccount - Copy.png",
          Inactiveimage: "assets/images/unselectedaccount.png",
          name: "الملف الشخصي"),
    ];
    return Container(
      width: 430,
      height: 56,
      clipBehavior: Clip.antiAlias,
      decoration: ShapeDecoration(
        color:  AppColors.primaryColor,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(0)),
      ),
      child: Row(children: 
        items.asMap().entries.map((e) {
          var index = e.key;
          var entity = e.value;
          return Expanded(
            child: GestureDetector(
              onTap: () {
                widget.indexChanged(index);
                selectedIndex = index;
                setState(() {
                });
              },
              child: ButtonNavigationBarItem(
                isActive: index == selectedIndex,
                buttonnavigationbarentity: entity,
              ),
            ),
          );
        }).toList()
    ),
    );
  }
}


