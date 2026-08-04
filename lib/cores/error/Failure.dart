import 'package:dio/dio.dart';

class Failure {
  final String errmessege;

  Failure({required this.errmessege});

}
class firebaseAuth extends Failure{
  firebaseAuth({required super.errmessege});

}
class ServerFailure extends Failure {
  ServerFailure({required super.errmessege});

  factory ServerFailure.fromDioException(DioException dioException) {
    switch (dioException.type) {
      case DioExceptionType.connectionTimeout:
        return ServerFailure(errmessege: 'Connction time outTime with api');
      case DioExceptionType.sendTimeout:
        return ServerFailure(errmessege: 'Send messege fail with api');
      case DioExceptionType.receiveTimeout:
        return ServerFailure(errmessege: 'Receive messege fail with api');
      case DioExceptionType.badCertificate:
        return ServerFailure(errmessege: 'Bad certificate received');
      case DioExceptionType.badResponse:
        return ServerFailure.fromResponse(
            dioException.response!.statusCode!, dioException.response!.data);
      case DioExceptionType.cancel:
        return ServerFailure(
            errmessege: 'the reust was cancelled ,please try again!');
      case DioExceptionType.connectionError:
        return ServerFailure(
            errmessege: 'the internet connection fail,please try again!');
      case DioExceptionType.unknown:
        return ServerFailure(errmessege: 'Unexpected error ,please try again!');
      default:
        return ServerFailure(
            errmessege: 'Oops ther was an error ,please try again!');
    }
  }

  factory ServerFailure.fromResponse(
      int satatusCode, Map<String, dynamic> responsData) {
    if (satatusCode >=400 && satatusCode < 500) {
      return ServerFailure(errmessege: responsData['msg']);
    } else if (satatusCode >=500&& satatusCode < 600) {
      return ServerFailure(
          errmessege: 'the Server has an error ,please try later!');
    } else {
      return ServerFailure(errmessege: 'Unexpected error ,please try again!');
    }
  }
}
