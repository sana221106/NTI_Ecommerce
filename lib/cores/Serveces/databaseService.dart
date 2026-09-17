abstract class Databaseservce {
  Future<dynamic> getData({required String endpoints, String? token});
  Future<dynamic> addData({
    required String endpoints,
    String? token,
    required Map<String, dynamic> body,
  });
  // Future<dynamic> patch({
  //   required String endpoints,
  //   String? token,
  //   required Map<String, dynamic> body,
  // });
  Future<dynamic> updateData({
    required String endpoints,
    String? token,
    required Map<String, dynamic> body,
  });
  Future<dynamic> deleteData({
    required String endpoints,
    String? token,
    Map<String, dynamic>? body,
  });
}
