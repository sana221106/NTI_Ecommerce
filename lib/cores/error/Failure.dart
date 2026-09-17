import 'package:dio/dio.dart';

class Failure {
  final String errmessege;

  Failure({
    required this.errmessege,
  });
}

class ServerFailure extends Failure {
  ServerFailure( {required super.errmessege});


  factory ServerFailure.fromDioException(DioException dioException) {
    switch (dioException.type) {
      case DioExceptionType.connectionTimeout:
        return ServerFailure(errmessege: 'Connection timeout with API');

      case DioExceptionType.sendTimeout:
        return ServerFailure(errmessege: 'Send timeout with API');

      case DioExceptionType.receiveTimeout:
        return ServerFailure(errmessege: 'Receive timeout with API');

      case DioExceptionType.badCertificate:
        return ServerFailure(errmessege: 'Bad certificate received');

      case DioExceptionType.badResponse:
        final response = dioException.response;

        if (response != null) {
          final data = response.data;

          if (data is Map<String, dynamic>) {
            return ServerFailure.fromResponse(response.statusCode ?? 0, data);
          }
        }

        return ServerFailure(errmessege: 'Bad response from server');

      case DioExceptionType.cancel:
        return ServerFailure(
          errmessege: 'The request was cancelled, please try again!',
        );

      case DioExceptionType.connectionError:
        return ServerFailure(
          errmessege: 'Internet connection failed, please try again!',
        );

      case DioExceptionType.unknown:
        return ServerFailure(errmessege: 'Unexpected error, please try again!');
      case DioExceptionType.transformTimeout:
        return ServerFailure(errmessege: 'Transform timeout with API');
      default:
        throw UnimplementedError();
    }
  }

  factory ServerFailure.fromResponse(
    int statusCode,
    Map<String, dynamic> responseData,
  ) {
    if (statusCode >= 400 && statusCode < 500) {
      final message = responseData['message'];

      return ServerFailure(
        errmessege: message is String
            ? message
            : 'Client error, please check your data.',
      );
    }

    if (statusCode >= 500 && statusCode < 600) {
      return ServerFailure(
        errmessege: 'The server has an error, please try later!',
      );
    }

    return ServerFailure(errmessege: 'Unexpected error, please try again!');
  }
}
