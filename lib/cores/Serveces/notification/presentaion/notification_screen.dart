import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../cubit/notification_cubit.dart';
import '../cubit/notification_state.dart';
import '../notification_service.dart';

class NotificationScreen
    extends StatelessWidget {
  const NotificationScreen({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) {
        final cubit =
            NotificationCubit(
          NotificationService(),
        );

        cubit.getNotifications();

        return cubit;
      },
      child: const _NotificationView(),
    );
  }
}

class _NotificationView
    extends StatelessWidget {
  const _NotificationView();

  @override
  Widget build(BuildContext context) {
    return Directionality(
      textDirection:
          TextDirection.rtl,
      child: Scaffold(
        backgroundColor:
            const Color(0xFFF9FAFA),

        // ========================================================
        // APP BAR
        // ========================================================

        appBar: AppBar(
          backgroundColor:
              Colors.white,
          elevation: 0,
          centerTitle: true,

          leading: IconButton(
            onPressed: () {
              Navigator.pop(context);
            },
            icon: const Icon(
              Icons.arrow_back_ios_new,
              size: 20,
              color:
                  Color(0xFF0C0D0D),
            ),
          ),

          title: Text(
            'الإشعارات',
            style: TextStyle(
              color:
                  const Color(0xFF0C0D0D),
              fontSize: 18,
              fontFamily: 'Cairo',
              fontWeight:
                  FontWeight.w700,
            ),
          ),

          actions: [
            BlocBuilder<
                NotificationCubit,
                NotificationState>(
              builder:
                  (context, state) {
                if (state
                        is NotificationLoaded &&
                    state.unreadCount >
                        0) {
                  return TextButton(
                    onPressed: () {
                      context
                          .read<
                              NotificationCubit>()
                          .markAllAsRead();
                    },
                    child: Text(
                      'قراءة الكل',
                      style: TextStyle(
                        color:
                            const Color(
                                0xFF0D6B46),
                        fontSize: 12,
                        fontFamily:
                            'Cairo',
                        fontWeight:
                            FontWeight.w600,
                      ),
                    ),
                  );
                }

                return const SizedBox(
                  width: 8,
                );
              },
            ),
          ],
        ),

        // ========================================================
        // BODY
        // ========================================================

        body: BlocBuilder<
            NotificationCubit,
            NotificationState>(
          builder:
              (context, state) {
            // ----------------------------------------------------
            // LOADING
            // ----------------------------------------------------

            if (state
                is NotificationLoading) {
              return const Center(
                child:
                    CircularProgressIndicator(
                  color:
                      Color(0xFF0D6B46),
                ),
              );
            }

            // ----------------------------------------------------
            // ERROR
            // ----------------------------------------------------

            if (state
                is NotificationError) {
              return Center(
                child: Padding(
                  padding:
                      const EdgeInsets.all(
                    24,
                  ),
                  child: Column(
                    mainAxisSize:
                        MainAxisSize.min,
                    children: [
                      const Icon(
                        Icons.error_outline,
                        size: 50,
                        color:
                            Colors.redAccent,
                      ),

                      const SizedBox(
                        height: 12,
                      ),

                      Text(
                        'حدث خطأ',
                        style:
                            TextStyle(
                          fontSize: 18,
                          fontFamily:
                              'Cairo',
                          fontWeight:
                              FontWeight.bold,
                        ),
                      ),

                      const SizedBox(
                        height: 8,
                      ),

                      Text(
                        state.message,
                        textAlign:
                            TextAlign.center,
                        style:
                            TextStyle(
                          color: Colors
                              .grey
                              .shade700,
                          fontFamily:
                              'Cairo',
                          fontSize: 13,
                        ),
                      ),
                    ],
                  ),
                ),
              );
            }

            // ----------------------------------------------------
            // LOADED
            // ----------------------------------------------------

            if (state
                is NotificationLoaded) {
              final notifications =
                  state.notifications;

              // --------------------------------------------------
              // EMPTY
              // --------------------------------------------------

              if (notifications
                  .isEmpty) {
                return Center(
                  child: Column(
                    mainAxisSize:
                        MainAxisSize.min,
                    children: [
                      Container(
                        width: 80,
                        height: 80,
                        decoration:
                            const BoxDecoration(
                          color:
                              Color(0xFFF1F9F2),
                          shape:
                              BoxShape.circle,
                        ),
                        child:
                            const Icon(
                          Icons
                              .notifications_none_outlined,
                          size: 40,
                          color:
                              Color(0xFF0D6B46),
                        ),
                      ),

                      const SizedBox(
                        height: 16,
                      ),

                      Text(
                        'لا توجد إشعارات',
                        style:
                            TextStyle(
                          color:
                              const Color(
                                  0xFF0C0D0D),
                          fontSize: 17,
                          fontFamily:
                              'Cairo',
                          fontWeight:
                              FontWeight.w700,
                        ),
                      ),

                      const SizedBox(
                        height: 5,
                      ),

                      Text(
                        'لا توجد إشعارات جديدة حالياً',
                        style:
                            TextStyle(
                          color:
                              const Color(
                                  0xFF949D9E),
                          fontSize: 13,
                          fontFamily:
                              'Cairo',
                        ),
                      ),
                    ],
                  ),
                );
              }

              // --------------------------------------------------
              // LIST
              // --------------------------------------------------

              return ListView.builder(
                padding:
                    const EdgeInsets
                        .symmetric(
                  horizontal: 16,
                  vertical: 14,
                ),
                itemCount:
                    notifications.length,
                itemBuilder:
                    (context, index) {
                  final doc =
                      notifications[index];

                  final data =
                      doc.data();

                  final title =
                      data['title']
                              ?.toString() ??
                          '';

                  final body =
                      data['body']
                              ?.toString() ??
                          '';

                  final isRead =
                      data['isRead'] ==
                          true;

                  return _NotificationItem(
                    title: title,
                    body: body,
                    isRead: isRead,
                    onTap: () {
                      if (!isRead) {
                        context
                            .read<
                                NotificationCubit>()
                            .markAsRead(
                              doc.id,
                            );
                      }
                    },
                  );
                },
              );
            }

            return const SizedBox
                .shrink();
          },
        ),
      ),
    );
  }
}

// ====================================================================
// NOTIFICATION ITEM
// ====================================================================

class _NotificationItem
    extends StatelessWidget {
  final String title;
  final String body;
  final bool isRead;
  final VoidCallback onTap;

  const _NotificationItem({
    required this.title,
    required this.body,
    required this.isRead,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: AnimatedContainer(
        duration:
            const Duration(
          milliseconds: 200,
        ),
        margin:
            const EdgeInsets.only(
          bottom: 10,
        ),
        padding:
            const EdgeInsets.all(14),
        decoration: BoxDecoration(
          color: isRead
              ? Colors.white
              : const Color(
                  0xFFF1F9F2,
                ),
          borderRadius:
              BorderRadius.circular(14),
          border: Border.all(
            color: isRead
                ? const Color(
                    0xFFECEEEE,
                  )
                : const Color(
                    0xFFDDEFE5,
                  ),
          ),
        ),
        child: Row(
          crossAxisAlignment:
              CrossAxisAlignment.start,
          children: [
            // ======================================================
            // ICON
            // ======================================================

            Container(
              width: 46,
              height: 46,
              decoration:
                  BoxDecoration(
                color: isRead
                    ? const Color(
                        0xFFF2F3F3,
                      )
                    : const Color(
                        0xFFE3F3E9,
                      ),
                shape:
                    BoxShape.circle,
              ),
              child: Icon(
                isRead
                    ? Icons
                        .notifications_none_outlined
                    : Icons
                        .notifications_active_outlined,
                color: isRead
                    ? const Color(
                        0xFF949D9E,
                      )
                    : const Color(
                        0xFF0D6B46,
                      ),
                size: 24,
              ),
            ),

            const SizedBox(
              width: 12,
            ),

            // ======================================================
            // TEXT
            // ======================================================

            Expanded(
              child: Column(
                crossAxisAlignment:
                    CrossAxisAlignment
                        .end,
                children: [
                  Text(
                    title,
                    textAlign:
                        TextAlign.right,
                    style:
                        TextStyle(
                      color:
                          const Color(
                              0xFF0C0D0D),
                      fontSize: 15,
                      fontFamily:
                          'Cairo',
                      fontWeight: isRead
                          ? FontWeight
                              .w500
                          : FontWeight
                              .w700,
                    ),
                  ),

                  const SizedBox(
                    height: 5,
                  ),

                  Text(
                    body,
                    textAlign:
                        TextAlign.right,
                    style:
                        TextStyle(
                      color:
                          const Color(
                              0xFF707879),
                      fontSize: 13,
                      fontFamily:
                          'Cairo',
                      fontWeight:
                          FontWeight.w400,
                      height: 1.5,
                    ),
                  ),
                ],
              ),
            ),

            const SizedBox(
              width: 8,
            ),

            // ======================================================
            // UNREAD DOT
            // ======================================================

            if (!isRead)
              Container(
                width: 8,
                height: 8,
                margin:
                    const EdgeInsets.only(
                  top: 6,
                ),
                decoration:
                    const BoxDecoration(
                  color:
                      Color(0xFF0D6B46),
                  shape:
                      BoxShape.circle,
                ),
              ),
          ],
        ),
      ),
    );
  }
}