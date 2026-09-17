import 'package:ecommerce/cores/Serveces/get_it.dart';
import 'package:ecommerce/cores/Serveces/notification/cubit/notification_cubit.dart';
import 'package:ecommerce/cores/Serveces/notification/notification_service.dart';
import 'package:ecommerce/cores/utiles/app_assets.dart';
import 'package:ecommerce/cores/utiles/app_styleText.dart';
import 'package:ecommerce/feature/main/presentation/cubits/Home_Cubit/home_cubit.dart';
import 'package:ecommerce/feature/main/presentation/screens/location_screen.dart';
import 'package:ecommerce/feature/main/presentation/screens/widget/GridCustomForHomeBlocBuilder.dart';
import 'package:ecommerce/feature/main/presentation/screens/widget/SearchField.dart';
import 'package:ecommerce/feature/main/presentation/screens/widget/imageSlider.dart';
import 'package:ecommerce/feature/main/presentation/screens/widget/notificationbutton.dart';
import 'package:ecommerce/feature/main/presentation/screens/widget/productsectionHeader.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class Homebody extends StatefulWidget {
  const Homebody({super.key});

  @override
  State<Homebody> createState() => _HomebodyState();
}

class _HomebodyState extends State<Homebody> {
  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) {
        final cubit = NotificationCubit(get_it<NotificationService>());

        cubit.getNotifications();

        return cubit;
      },
      child: const _HomeView(),
    );
  }
}

class _HomeView extends StatelessWidget {
  const _HomeView();

  @override
  Widget build(BuildContext context) {
    return Directionality(
      textDirection: TextDirection.rtl,
      child: CustomScrollView(
        slivers: [
          SliverToBoxAdapter(
            child: Padding(
              padding: const EdgeInsets.only(left: 16, right: 16, top: 70),
              child: Column(
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Image.asset(
                            AppAssets.person,
                            width: 42,
                            height: 42,
                            fit: BoxFit.cover,
                          ),

                          const SizedBox(width: 8),

                          Column(
                            crossAxisAlignment: CrossAxisAlignment.end,
                            children: [
                              Text(
                                'صباح الخير...!',
                                style: AppStyletext.normal15,
                              ),

                              const SizedBox(height: 2),

                              Text('أحمد مصطفي', style: AppStyletext.Bold19),
                            ],
                          ),
                        ],
                      ),

                      Notificationbutton(),
                    ],
                  ),

                  const SizedBox(height: 22),

                  SearchField(
                    onChanged: (value) {
                      context.read<HomeCubit>().searchProducts(value);
                    },
                  ),
                  // ElevatedButton.icon(
                  //   onPressed: () {
                  //     Navigator.push(
                  //       context,
                  //       MaterialPageRoute(
                  //         builder: (_) => const LocationScreen(),
                  //       ),
                  //     );
                  //   },
                  //   icon: const Icon(Icons.location_on),
                  //   label: const Text('Delivery Location'),
                  // ),
                  // const SizedBox(height: 20),

                  ImageSlider(),

                  const SizedBox(height: 20),

                  productsectionHeader(),

                  const SizedBox(height: 10),
                ],
              ),
            ),
          ),

          GridCustomForHomeBlocBuilder(),
        ],
      ),
    );
  }
}
