import 'dart:async';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../notification_service.dart';
import 'notification_state.dart';

class NotificationCubit
    extends Cubit<NotificationState> {
  final NotificationService notificationService;

  StreamSubscription<
          QuerySnapshot<Map<String, dynamic>>>?
      _notificationsSubscription;

  NotificationCubit(
    this.notificationService,
  ) : super(NotificationInitial());

  // ============================================================
  // GET NOTIFICATIONS

  void getNotifications() {
    // Cancel old subscription
    _notificationsSubscription?.cancel();

    emit(NotificationLoading());

    try {
      _notificationsSubscription =
          notificationService
              .getNotifications()
              .listen(
        (snapshot) {
          emit(
            NotificationLoaded(
              snapshot.docs,
            ),
          );
        },
        onError: (error) {
          emit(
            NotificationError(
              error.toString(),
            ),
          );
        },
      );
    } catch (e) {
      emit(
        NotificationError(
          e.toString(),
        ),
      );
    }
  }

  // ============================================================
  // MARK ONE AS READ


  Future<void> markAsRead(
    String notificationId,
  ) async {
    try {
      await notificationService.markAsRead(
        notificationId,
      );
    } catch (e) {
      emit(
        NotificationError(
          e.toString(),
        ),
      );
    }
  }

  // ============================================================
  // MARK ALL AS READ

  Future<void> markAllAsRead() async {
    try {
      await notificationService
          .markAllAsRead();
    } catch (e) {
      emit(
        NotificationError(
          e.toString(),
        ),
      );
    }
  }

  // ============================================================
  // CLOSE


  @override
  Future<void> close() async {
    await _notificationsSubscription
        ?.cancel();

    return super.close();
  }
}