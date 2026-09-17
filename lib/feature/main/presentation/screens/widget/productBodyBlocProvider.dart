import 'package:ecommerce/cores/Serveces/get_it.dart';
import 'package:ecommerce/feature/main/data/repo/mainrepo.dart';
import 'package:ecommerce/feature/main/presentation/cubits/Product_Cubit/product_cubit.dart';
import 'package:ecommerce/feature/main/presentation/screens/widget/productScreen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class ProductBodyBlocProvider extends StatelessWidget {
  const ProductBodyBlocProvider({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider<ProductCubit>(
      create: (context) => ProductCubit(
        mainrepo: get_it<Mainrepo>(),
      )..getProductData(),

      // مهم جدًا
      child: Productscreen(),
    );
  }
}