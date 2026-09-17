import 'package:ecommerce/cores/Serveces/get_it.dart';
import 'package:ecommerce/feature/main/presentation/cubits/Cart_Cubit/cart_cubit.dart';
import 'package:ecommerce/feature/main/presentation/screens/widget/CartBodyBlocBuilder.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class CartBodyBlocProvider extends StatelessWidget {
  const CartBodyBlocProvider({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider<CartCubit>(
      create: (context) => get_it<CartCubit>()..getCart(),
      child: const CartBodyBlocBuilder(),
    );
  }
}