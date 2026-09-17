import 'dart:developer';

import 'package:cloud_firestore/cloud_firestore.dart' hide Constant;
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:timezone/data/latest.dart' as tz;
import 'package:timezone/timezone.dart' as tz;

import 'package:ecommerce/cores/Serveces/localdatabaseservice.dart';
import 'package:ecommerce/cores/Serveces/hivedatabaseservice.dart';
import 'package:ecommerce/cores/constant.dart';

class NotificationService {
  // ============================================================
  // FIREBASE MESSAGING
  // ============================================================

  final FirebaseMessaging _messaging =
      FirebaseMessaging.instance;

  // ============================================================
  // LOCAL NOTIFICATIONS
  // ============================================================

  final FlutterLocalNotificationsPlugin
      _localNotifications =
      FlutterLocalNotificationsPlugin();

  // ============================================================
  // FIRESTORE
  // ============================================================

  final FirebaseFirestore _firestore =
      FirebaseFirestore.instance;

  // ============================================================
  // LOCAL DATABASE
  // ============================================================

  final LocalDatabaseService localDatabaseService;

  // ============================================================
  // CART REMINDER ID
  // ============================================================

  int? _cartReminderId;

  NotificationService({
    LocalDatabaseService? localDatabaseService,
  }) : localDatabaseService =
          localDatabaseService ??
              Hivedatabaseservice();

  // ============================================================
  // GET CURRENT USER EMAIL
  // ============================================================

  Future<String?> _getUserEmail() async {
    try {
      final userData =
          await localDatabaseService.getDatabyKey(
        Constant.userBox,
        Constant.userKey,
      );

      if (userData == null) {
        log(
          '❌ No user data found in Hive',
        );

        return null;
      }

      final email =
          userData['email']?.toString();

      log(
        'Hive User Email: $email',
      );

      return email;
    } catch (e, stackTrace) {
      log(
        '❌ Error getting user email: $e',
      );

      log(
        'STACK TRACE: $stackTrace',
      );

      return null;
    }
  }

  // ============================================================
  // INITIALIZE
  // ============================================================

  Future<void> initialize() async {
    log(
      '========== NOTIFICATION INITIALIZE ==========',
    );

    // ----------------------------------------------------------
    // Timezone
    // ----------------------------------------------------------

    tz.initializeTimeZones();

    // ----------------------------------------------------------
    // Local Notifications
    // ----------------------------------------------------------

    const androidSettings =
        AndroidInitializationSettings(
      '@mipmap/ic_launcher',
    );

    const initializationSettings =
        InitializationSettings(
      android: androidSettings,
    );

    await _localNotifications.initialize(
      settings: initializationSettings,
      onDidReceiveNotificationResponse:
          _onNotificationTap,
    );

    // ----------------------------------------------------------
    // Default Android Notification Channel
    // ----------------------------------------------------------

    const androidChannel =
        AndroidNotificationChannel(
      'default_channel',
      'Default Notifications',
      description: 'App notifications',
      importance: Importance.high,
    );

    await _localNotifications
        .resolvePlatformSpecificImplementation<
            AndroidFlutterLocalNotificationsPlugin>()
        ?.createNotificationChannel(
          androidChannel,
        );

    // ----------------------------------------------------------
    // Cart Reminder Channel
    // ----------------------------------------------------------

    const cartReminderChannel =
        AndroidNotificationChannel(
      'cart_reminder_channel',
      'Cart Reminders',
      description:
          'Notifications reminding users about items in their cart',
      importance: Importance.high,
    );

    await _localNotifications
        .resolvePlatformSpecificImplementation<
            AndroidFlutterLocalNotificationsPlugin>()
        ?.createNotificationChannel(
          cartReminderChannel,
        );

    // ----------------------------------------------------------
    // Request Permission
    // ----------------------------------------------------------

    final settings =
        await _messaging.requestPermission(
      alert: true,
      badge: true,
      sound: true,
    );

    log(
      'Notification Permission: '
      '${settings.authorizationStatus}',
    );

    // ----------------------------------------------------------
    // FCM Token
    // ----------------------------------------------------------

    final token =
        await _messaging.getToken();

    log(
      'FCM TOKEN: $token',
    );

    // ----------------------------------------------------------
    // Foreground Messages
    // ----------------------------------------------------------

    FirebaseMessaging.onMessage.listen(
      (RemoteMessage message) async {
        log(
          '========== FOREGROUND NOTIFICATION ==========',
        );

        final title =
            message.notification?.title ?? '';

        final body =
            message.notification?.body ?? '';

        log(
          'TITLE: $title',
        );

        log(
          'BODY: $body',
        );

        // Save notification in Firestore
        await saveNotification(
          notificationId:
              message.messageId,
          title: title,
          body: body,
          type: 'push',
          payload: message.data,
        );

        // Show local notification
        await showLocalNotification(
          message,
        );
      },
    );

    // ----------------------------------------------------------
    // Background Notification
    // ----------------------------------------------------------

    FirebaseMessaging.onMessageOpenedApp.listen(
      (RemoteMessage message) {
        log(
          'Notification clicked from Background',
        );

        handleNotificationTap(
          message,
        );
      },
    );

    // ----------------------------------------------------------
    // Terminated App
    // ----------------------------------------------------------

    final initialMessage =
        await _messaging.getInitialMessage();

    if (initialMessage != null) {
      log(
        'App opened from Terminated state',
      );

      handleNotificationTap(
        initialMessage,
      );
    }

    log(
      '========== NOTIFICATION INITIALIZE DONE ==========',
    );
  }

  // ============================================================
  // SAVE NOTIFICATION
  // ============================================================

  Future<void> saveNotification({
    required String title,
    required String body,
    required String type,
    String? notificationId,
    Map<String, dynamic>? payload,
  }) async {
    try {
      final email =
          await _getUserEmail();

      if (email == null ||
          email.isEmpty) {
        log(
          '❌ Cannot save notification: user email not found',
        );

        return;
      }

      final docId =
          notificationId ??
          DateTime.now()
              .millisecondsSinceEpoch
              .toString();

      final notificationRef =
          _firestore
              .collection('users')
              .doc(email)
              .collection('notifications')
              .doc(docId);

      await notificationRef.set({
        'id': notificationRef.id,
        'title': title,
        'body': body,
        'type': type,
        'isRead': false,
        'createdAt':
            FieldValue.serverTimestamp(),
        'payload':
            payload ?? {},
      });

      log(
        '✅ Notification saved successfully',
      );

      log(
        'User: $email',
      );

      log(
        'Notification ID: ${notificationRef.id}',
      );
    } catch (e, stackTrace) {
      log(
        '❌ Error saving notification: $e',
      );

      log(
        'STACK TRACE: $stackTrace',
      );
    }
  }

  // ============================================================
  // GET NOTIFICATIONS
  // ============================================================

  Stream<
      QuerySnapshot<
          Map<String, dynamic>>>
      getNotifications() async* {
    final email =
        await _getUserEmail();

    if (email == null ||
        email.isEmpty) {
      throw Exception(
        'User data not found',
      );
    }

    log(
      'Getting notifications for: $email',
    );

    yield* _firestore
        .collection('users')
        .doc(email)
        .collection('notifications')
        .orderBy(
          'createdAt',
          descending: true,
        )
        .snapshots();
  }

  // ============================================================
  // MARK ONE NOTIFICATION AS READ
  // ============================================================

  Future<void> markAsRead(
    String notificationId,
  ) async {
    try {
      final email =
          await _getUserEmail();

      if (email == null ||
          email.isEmpty) {
        return;
      }

      await _firestore
          .collection('users')
          .doc(email)
          .collection('notifications')
          .doc(notificationId)
          .update({
        'isRead': true,
      });

      log(
        '✅ Notification marked as read',
      );
    } catch (e, stackTrace) {
      log(
        '❌ Error marking notification as read: $e',
      );

      log(
        'STACK TRACE: $stackTrace',
      );

      rethrow;
    }
  }

  // ============================================================
  // MARK ALL NOTIFICATIONS AS READ
  // ============================================================

  Future<void> markAllAsRead() async {
    try {
      final email =
          await _getUserEmail();

      if (email == null ||
          email.isEmpty) {
        return;
      }

      final snapshot =
          await _firestore
              .collection('users')
              .doc(email)
              .collection('notifications')
              .where(
                'isRead',
                isEqualTo: false,
              )
              .get();

      final batch =
          _firestore.batch();

      for (final doc
          in snapshot.docs) {
        batch.update(
          doc.reference,
          {
            'isRead': true,
          },
        );
      }

      await batch.commit();

      log(
        '✅ All notifications marked as read',
      );
    } catch (e, stackTrace) {
      log(
        '❌ Error marking all notifications as read: $e',
      );

      log(
        'STACK TRACE: $stackTrace',
      );

      rethrow;
    }
  }

  // ============================================================
  // SHOW LOCAL NOTIFICATION
  // ============================================================

  Future<void> showLocalNotification(
    RemoteMessage message,
  ) async {
    final notification =
        message.notification;

    if (notification == null) {
      return;
    }

    const androidDetails =
        AndroidNotificationDetails(
      'default_channel',
      'Default Notifications',
      channelDescription:
          'App notifications',
      importance: Importance.high,
      priority: Priority.high,
      playSound: true,
    );

    const notificationDetails =
        NotificationDetails(
      android: androidDetails,
    );

    await _localNotifications.show(
      id: notification.hashCode,
      title: notification.title,
      body: notification.body,
      notificationDetails:
          notificationDetails,
      payload:
          message.data.toString(),
    );
  }

  // ============================================================
  // CART REMINDER
  // ============================================================

  Future<void> scheduleCartReminder() async {
    try {
      // Cancel previous cart reminder
      if (_cartReminderId != null) {
        await _localNotifications.cancel(
          id: _cartReminderId!,
        );
      }

      // Generate new notification ID
      _cartReminderId =
          DateTime.now()
              .millisecondsSinceEpoch
              .remainder(
                2147483647,
              );

      const androidDetails =
          AndroidNotificationDetails(
        'cart_reminder_channel',
        'Cart Reminders',
        channelDescription:
            'Notifications reminding users about items in their cart',
        importance: Importance.high,
        priority: Priority.high,
        playSound: true,
      );

      const notificationDetails =
          NotificationDetails(
        android: androidDetails,
      );

      final scheduledTime =
          tz.TZDateTime.now(
        tz.local,
      ).add(
        const Duration(
          hours: 2,
        ),
      );

      await _localNotifications
          .zonedSchedule(
        id: _cartReminderId!,
        title: '🛒 لا تنسي سلة التسوق',
        body:
            'لديك منتجات في سلة التسوق. أكمل طلبك الآن!',
        scheduledDate: scheduledTime,
        notificationDetails:
            notificationDetails,
        androidScheduleMode:
            AndroidScheduleMode
                .inexactAllowWhileIdle,
        payload:
            'cart_reminder',
      );

      await saveNotification(
        notificationId:
            _cartReminderId!.toString(),
        title:
            '🛒 لا تنسي سلة التسوق',
        body:
            'لديك منتجات في سلة التسوق. أكمل طلبك الآن!',
        type: 'cart_reminder',
        payload: {
          'type': 'cart_reminder',
          'scheduledTime':
              scheduledTime
                  .toIso8601String(),
        },
      );

      log(
        '✅ Cart reminder scheduled successfully',
      );

      log(
        'Reminder time: $scheduledTime',
      );

      log(
        'Reminder ID: $_cartReminderId',
      );
    } catch (e, stackTrace) {
      log(
        '❌ Error scheduling cart reminder: $e',
      );

      log(
        'STACK TRACE: $stackTrace',
      );
    }
  }

  // ============================================================
  // CANCEL CART REMINDER
  // ============================================================

  Future<void> cancelCartReminder() async {
    if (_cartReminderId == null) {
      return;
    }

    await _localNotifications.cancel(
      id: _cartReminderId!,
    );

    log(
      '✅ Cart reminder cancelled',
    );

    _cartReminderId = null;
  }

  // ============================================================
  // TEST LOCAL NOTIFICATION
  // ============================================================

  Future<void>
      showTestLocalNotification() async {
    const androidDetails =
        AndroidNotificationDetails(
      'default_channel',
      'Default Notifications',
      channelDescription:
          'App notifications',
      importance: Importance.high,
      priority: Priority.high,
      playSound: true,
    );

    const notificationDetails =
        NotificationDetails(
      android: androidDetails,
    );

    final id =
        DateTime.now()
            .millisecondsSinceEpoch
            .toString();

    final localNotificationId =
        int.parse(
      id.substring(
        id.length - 8,
      ),
    );

    await _localNotifications.show(
      id: localNotificationId,
      title: '🛒 Cart Reminder',
      body:
          'You have items waiting in your cart!',
      notificationDetails:
          notificationDetails,
    );

    await saveNotification(
      notificationId: id,
      title: '🛒 Cart Reminder',
      body:
          'You have items waiting in your cart!',
      type: 'local',
    );

    log(
      '✅ Test local notification shown and saved',
    );
  }

  // ============================================================
  // SCHEDULE TEST NOTIFICATION
  // ============================================================

  Future<void>
      scheduleTestLocalNotification() async {
    const androidDetails =
        AndroidNotificationDetails(
      'default_channel',
      'Default Notifications',
      channelDescription:
          'App notifications',
      importance: Importance.high,
      priority: Priority.high,
      playSound: true,
    );

    const notificationDetails =
        NotificationDetails(
      android: androidDetails,
    );

    final scheduledTime =
        tz.TZDateTime.now(
      tz.local,
    ).add(
      const Duration(
        seconds: 10,
      ),
    );

    final id =
        DateTime.now()
            .millisecondsSinceEpoch
            .toString();

    final localNotificationId =
        int.parse(
      id.substring(
        id.length - 8,
      ),
    );

    await _localNotifications
        .zonedSchedule(
      id: localNotificationId,
      title: '🛒 Cart Reminder',
      body:
          'You have items waiting in your cart!',
      scheduledDate: scheduledTime,
      notificationDetails:
          notificationDetails,
      androidScheduleMode:
          AndroidScheduleMode
              .inexactAllowWhileIdle,
    );

    await saveNotification(
      notificationId: id,
      title: '🛒 Cart Reminder',
      body:
          'You have items waiting in your cart!',
      type: 'scheduled',
      payload: {
        'scheduledTime':
            scheduledTime
                .toIso8601String(),
      },
    );

    log(
      '✅ Notification scheduled',
    );
  }

  // ============================================================
  // LOCAL NOTIFICATION TAP
  // ============================================================

  void _onNotificationTap(
    NotificationResponse response,
  ) {
    log(
      'Local Notification Clicked',
    );

    log(
      'Payload: ${response.payload}',
    );
  }

  // ============================================================
  // FCM NOTIFICATION TAP
  // ============================================================

  void handleNotificationTap(
    RemoteMessage message,
  ) {
    log(
      'FCM Notification Clicked',
    );

    log(
      'Title: ${message.notification?.title}',
    );

    log(
      'Body: ${message.notification?.body}',
    );

    log(
      'Data: ${message.data}',
    );
  }
}