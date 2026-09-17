abstract class LocalDatabaseService {
  Future<void> addData({
    required String boxName,
    required Map<String, dynamic> data,
    required String? key,
  });

  Future<List<Map<String, dynamic>>> getData(String boxName);

  Future<Map<String, dynamic>?> getDatabyKey(
    String boxName,
    String key,
  );

  Future<void> updateData(
    String boxName,
    String key,
    Map<String, dynamic> data,
  );

  Future<void> deleteData(
    String boxName,
    String key,
  );

  Future<void> clearBox(String boxName);
}