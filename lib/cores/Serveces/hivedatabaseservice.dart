import 'package:hive/hive.dart';
import 'package:uuid/uuid.dart';

import 'package:ecommerce/cores/Serveces/localdatabaseservice.dart';
import 'package:hive_flutter/hive_flutter.dart';

final Uuid _uuid = Uuid();

class Hivedatabaseservice extends LocalDatabaseService {
  Future<Box> _getBox(String boxName) async {
    if (!Hive.isBoxOpen(boxName)) {
      return await Hive.openBox(boxName);
    }

    return Hive.box(boxName);
  }

  @override
  Future<void> addData({
    required String boxName,
    required Map<String, dynamic> data,
    required String? key,
  }) async {
    final box = await _getBox(boxName);

    final finalKey = key ?? _uuid.v4();

    await box.put(finalKey, data);
  }

  @override
  Future<void> clearBox(String boxName) async {
    final box = await _getBox(boxName);
    await box.clear();
  }

  @override
  Future<void> deleteData(
    String boxName,
    String key,
  ) async {
    final box = await _getBox(boxName);
    await box.delete(key);
  }

  @override
  Future<List<Map<String, dynamic>>> getData(
    String boxName,
  ) async {
    final box = await _getBox(boxName);

    return box.values
        .map((e) => Map<String, dynamic>.from(e))
        .toList();
  }

  @override
  Future<Map<String, dynamic>?> getDatabyKey(
    String boxName,
    String key,
  ) async {
    final box = await _getBox(boxName);

    final data = box.get(key);

    return data != null
        ? Map<String, dynamic>.from(data)
        : null;
  }

  @override
  Future<void> updateData(
    String boxName,
    String key,
    Map<String, dynamic> data,
  ) async {
    final box = await _getBox(boxName);

    await box.put(key, data);
  }
}