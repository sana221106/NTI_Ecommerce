import 'package:ecommerce/cores/Serveces/get_it.dart';
import 'package:ecommerce/feature/main/presentation/cubits/Cart_Cubit/cart_cubit.dart';
import 'package:ecommerce/feature/main/presentation/cubits/Location_Cubit/location_cubit.dart';
import 'package:ecommerce/feature/main/presentation/cubits/Payment_Cubit/payment_cubit.dart';
import 'package:ecommerce/feature/main/presentation/screens/widget/CartBodyBlocBuilder.dart';
import 'package:ecommerce/feature/main/presentation/screens/widget/customButtomNavigationBar.dart';
import 'package:ecommerce/feature/main/presentation/screens/widget/homebodyblocProvider.dart';
import 'package:ecommerce/feature/main/presentation/screens/widget/productBodyBlocProvider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class Mainscreen extends StatefulWidget {
  const Mainscreen({super.key});

  static const String routname = "Home";

  @override
  State<Mainscreen> createState() => _MainscreenState();
}

class _MainscreenState extends State<Mainscreen> {
  int selectedIndex = 0;

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        // =========================
        // Cart
        // =========================
        BlocProvider<CartCubit>(
          create: (context) => get_it<CartCubit>()..getCart(),
        ),

        // =========================
        // Location
        // =========================
        BlocProvider<LocationCubit>(
          create: (context) => LocationCubit(),
        ),

        // =========================
        // Payment
        // =========================
        BlocProvider<PaymentCubit>(
          create: (context) => get_it<PaymentCubit>(),
        ),
      ],
      child: Scaffold(
        bottomNavigationBar: customBottomNavigationBar(
          indexChanged: (index) {
            setState(() {
              selectedIndex = index;
            });
          },
        ),
        body: IndexedStack(
          index: selectedIndex,
          children: const [
            // Home
            HomeBodyBlocProvider(),

            // Products / Categories
            ProductBodyBlocProvider(),

            // Cart
            CartBodyBlocBuilder(),

            // Profile
            Center(
              child: Text("Profile Screen"),
            ),
          ],
        ),
      ),
    );
  }
}