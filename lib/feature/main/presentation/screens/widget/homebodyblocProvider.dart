import 'package:ecommerce/cores/Serveces/get_it.dart';
import 'package:ecommerce/feature/main/data/repo/mainrepo.dart';
import 'package:ecommerce/feature/main/presentation/cubits/Home_Cubit/home_cubit.dart';
import 'package:ecommerce/feature/main/presentation/screens/widget/homeBody.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class HomeBodyBlocProvider extends StatelessWidget {
  const HomeBodyBlocProvider({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider<HomeCubit>(
      create: (context) => HomeCubit(
        mainrepo: get_it<Mainrepo>(),
      )..getProducts(),

      child: const Homebody(),
    );
  }
}