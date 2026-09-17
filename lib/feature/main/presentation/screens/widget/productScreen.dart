import 'package:ecommerce/cores/Serveces/notification/cubit/notification_cubit.dart';
import 'package:ecommerce/cores/Serveces/notification/notification_service.dart';
import 'package:ecommerce/feature/main/presentation/screens/widget/productBody.dart';
import 'package:ecommerce/feature/main/presentation/screens/widget/notificationbutton.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class Productscreen extends StatelessWidget {
  const Productscreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) {
        final cubit = NotificationCubit(NotificationService());
        cubit.getNotifications();
        return cubit;
      },
      child: Scaffold(
         appBar: AppBar(
  automaticallyImplyLeading: false,

  title: const Text(
    'المنتجات',
    style: TextStyle(
      fontFamily: 'Cairo',
      fontSize: 24,
      fontWeight: FontWeight.w700,
      color: Color(0xFF000000),
    ),
  ),

  centerTitle: true,

  leading: Padding(
    padding: const EdgeInsets.only(left: 16),
    child: Notificationbutton(),
  ),
),

        body: const Productbody(),
      ),
    );
  }
}