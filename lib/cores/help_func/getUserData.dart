import 'dart:developer';

import 'package:ecommerce/cores/constant.dart';
import 'package:ecommerce/feature/Auth/domain/entities/userentityres.dart';
import 'package:hive/hive.dart';

Future<Userentityres?> getUserData() async {
  try {
    if (!Hive.isBoxOpen(Constant.userBox)) {
      await Hive.openBox(Constant.userBox);
    }

    final userBox = Hive.box(Constant.userBox);

    final rawData = userBox.get(Constant.userKey);

    if (rawData == null) {
      log('No user data found in Hive');
      return null;
    }

    final data = Map<dynamic, dynamic>.from(rawData);
    log('✅ USER DATA FOUND IN HIVE');
    log('NAME: ${data['name']}');
    log('EMAIL: ${data['email']}');

    final userentityres = Userentityres(
      token: data['token'] ?? '',
      message: data['message'] ?? '',
      name: data['name'] ?? '',
      email: data['email'] ?? '',
    );

    return userentityres;
  } catch (e) {
    log('Error getting user data from Hive: $e');
    return null;
  }
}
