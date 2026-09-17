import 'package:ecommerce/cores/Serveces/notification/cubit/notification_cubit.dart';
import 'package:ecommerce/cores/Serveces/notification/cubit/notification_state.dart';
import 'package:ecommerce/cores/Serveces/notification/presentaion/notification_screen.dart';
import 'package:ecommerce/cores/utiles/app_colors.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class Notificationbutton extends StatelessWidget {
  const Notificationbutton({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<NotificationCubit, NotificationState>(
      builder: (context, state) {
        int unreadCount = 0;

        if (state is NotificationLoaded) {
          unreadCount = state.unreadCount;
        }

        return Padding(
          padding: const EdgeInsets.only(top: 5),
          child: Stack(
            clipBehavior: Clip.none,
            children: [
              Material(
                color: const Color(0xFFF1F9F2),
                shape: const CircleBorder(),
                child: InkWell(
                  customBorder: const CircleBorder(),
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (_) => const NotificationScreen(),
                      ),
                    );
                  },
                  child: const SizedBox(
                    width: 42,
                    height: 42,
                    child: Center(
                      child: Icon(
                        Icons.notifications_none_outlined,
                        size: 23,
                         color: AppColors.greenButton,
                      ),
                    ),
                  ),
                ),
              ),
              if (unreadCount > 0)
                Positioned(
                  top: -4,
                  right: -4,
                  child: Container(
                    constraints: const BoxConstraints(
                      minWidth: 18,
                      minHeight: 18,
                    ),
                    padding: const EdgeInsets.symmetric(horizontal: 4),
                    decoration: const BoxDecoration(
                      color: Colors.red,
                      shape: BoxShape.circle,
                    ),
                    child: Center(
                      child: Text(
                        unreadCount > 99 ? '99+' : unreadCount.toString(),
                        style: const TextStyle(
                          color: Colors.white,
                          fontSize: 9,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                  ),
                ),
            ],
          ),
        );
      },
    );
  }
}
