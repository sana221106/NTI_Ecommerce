import 'package:flutter/material.dart';

enum SnackbarType { success, error, warning, info }

void BuildSnakBar(
  BuildContext context,
  String message, {
  SnackbarType type = SnackbarType.info,
  int durationInSeconds = 5,
}) {

  final backgroundColor = _getSnackbarColor(type);
  final icon = _getSnackbarIcon(type);

  final snackBar = SnackBar(
    content: Row(
      children: [
        Icon(icon, color: Colors.white),
        const SizedBox(width: 10),
        Expanded(
          child: Text(
            message,
            style: const TextStyle(color: Colors.white, fontSize: 16),
          ),
        ),
      ],
    ),
    duration: Duration(seconds: durationInSeconds),
    behavior: SnackBarBehavior.floating,
    backgroundColor: backgroundColor,
    elevation: 6,
    shape: RoundedRectangleBorder(
      borderRadius: BorderRadius.circular(12),
    ),
    margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 10),
  );

  // إغلاق أي Snackbar مفتوح قبل عرض الجديد
  ScaffoldMessenger.of(context).clearSnackBars();
  ScaffoldMessenger.of(context).showSnackBar(snackBar);
}

Color _getSnackbarColor(SnackbarType type) {
  switch (type) {
    case SnackbarType.success:
      return Colors.green;
    case SnackbarType.error:
      return Colors.red;
    case SnackbarType.warning:
      return Colors.orange;
    case SnackbarType.info:
      return Colors.blueGrey;
    default:
      return Colors.blueGrey;
  }
}

IconData _getSnackbarIcon(SnackbarType type) {
  switch (type) {
    case SnackbarType.success:
      return Icons.check_circle;
    case SnackbarType.error:
      return Icons.error;
    case SnackbarType.warning:
      return Icons.warning_amber_rounded;
    case SnackbarType.info:
    default:
      return Icons.info;
  }
}