import 'package:dio/dio.dart';
import 'package:ecommerce/cores/Serveces/databaseService.dart';
import 'package:ecommerce/cores/Serveces/endpoints.dart';


class Apiserver extends DatabaseservceApi {
  final Dio dio;
 
  Apiserver({required this.dio,});
   @override
  Future<dynamic> getData({required String endpoints, String? token}) async {
    Map<String, dynamic> header = {};
    if (token != null) {
        header.addAll({"token": token});
      }
    var response = await dio.get(
      "${Endpoints.BaseUrl}${Endpoints.endpoints}",
      options: Options(headers: header),
    );
    return response.data;
  }
  @override
  Future<dynamic> addData({required String endpoints, String? token, required Map<String,dynamic> body}) async {
    Map<String, dynamic> header = {};
    if (token != null) {
      header.addAll({"token": token });
    }
    var response = await dio.post(
      "${Endpoints.BaseUrl}${Endpoints.endpoints}",data: body,
      options: Options(headers: header),
    );
    return response.data;
  }
  // @override
  // Future<dynamic> patch({required String endpoints, String? token, required Map<String,dynamic> body}) async {
  //   Map<String, dynamic> header = {};
  //   if (token != null) {
  //     header.addAll({"Authorization": "Bearer $token"});
  //   }
  //   var response = await dio.patch(
  //     "$baseurl$endpoints",data: body,
  //     options: Options(headers: header),
  //   );
  //   return response.data;
  // }
  @override
  Future<dynamic> updateData({required String endpoints, String? token, required Map<String,dynamic> body}) async {
    Map<String, dynamic> header = {};
    if (token != null) {
      header.addAll({"token": token });
    }
    var response = await dio.put(
      "${Endpoints.BaseUrl}${Endpoints.endpoints}",data: body,
      options: Options(headers: header),
    );
    return response.data;
  }
  @override
  Future<dynamic> deleteData({required String endpoints, String? token,  Map<String,dynamic>? body}) async {
    Map<String, dynamic> header = {};
    if (token != null) {
      header.addAll({"token": token});
    }
    var response = await dio.delete(
      "${Endpoints.BaseUrl}${Endpoints.endpoints}",data: body,
      options: Options(headers: header),
    );
    return response.data;
  }
  
}
