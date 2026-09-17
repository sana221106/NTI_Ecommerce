import 'package:ecommerce/cores/Serveces/notification/notification_service.dart';
import 'package:flutter/material.dart';

class notificationicon extends StatelessWidget {
  final BuildContext context;

  const notificationicon(this.context, {super.key});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: double.infinity,
      height: 50,
      child: ElevatedButton.icon(
        onPressed: () async {
          try {
            await NotificationService().showTestLocalNotification();

            if (context.mounted) {
              ScaffoldMessenger.of(context).showSnackBar(
                const SnackBar(
                  content: Text('تم إرسال Local Notification بنجاح '),
                ),
              );
            }
          } catch (e) {
            if (context.mounted) {
              ScaffoldMessenger.of(
                context,
              ).showSnackBar(SnackBar(content: Text('حدث خطأ: $e')));
            }
          }
        },
        icon: const Icon(Icons.notifications_active),
        label: const Text(
          'Test Local Notification',
          style: TextStyle(
            fontFamily: 'Cairo',
            fontSize: 15,
            fontWeight: FontWeight.w600,
          ),
        ),
      ),
    );
  }
}
