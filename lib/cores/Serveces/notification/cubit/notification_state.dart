import 'package:cloud_firestore/cloud_firestore.dart';

abstract class NotificationState {}

class NotificationInitial extends NotificationState {}

class NotificationLoading extends NotificationState {}

class NotificationLoaded extends NotificationState {
  final List<QueryDocumentSnapshot<Map<String, dynamic>>> notifications;

  NotificationLoaded(this.notifications);

  int get unreadCount {
    return notifications.where((doc) {
      return doc.data()['isRead'] == false;
    }).length;
  }
}

class NotificationError extends NotificationState {
  final String message;

  NotificationError(this.message);
}