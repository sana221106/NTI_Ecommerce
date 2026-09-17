import 'package:dartz/dartz.dart';
import 'package:dio/dio.dart';
import 'package:ecommerce/cores/Serveces/databaseService.dart';
import 'package:ecommerce/cores/Serveces/endpoints.dart';
import 'package:ecommerce/cores/Serveces/localdatabaseservice.dart';
import 'package:ecommerce/cores/constant.dart';
import 'package:ecommerce/cores/error/Failure.dart';
import 'package:ecommerce/feature/Auth/data/models/usermodelreq.dart';
import 'package:ecommerce/feature/Auth/data/models/usermodelres.dart';
import 'package:ecommerce/feature/Auth/data/models/usermodelsigninreq.dart';
import 'package:ecommerce/feature/Auth/domain/Repo/authrepo.dart';
import 'package:ecommerce/feature/Auth/domain/entities/userentityreq.dart';
import 'package:ecommerce/feature/Auth/domain/entities/userentityres.dart';
import 'package:ecommerce/feature/Auth/domain/entities/userentitysigninreq.dart';

class Authrepoimple extends Authrepo {
  final Databaseservce databaseservce;
  final LocalDatabaseService localDatabaseService;

  Authrepoimple({
    required this.databaseservce,
    required this.localDatabaseService,
  });

  @override
  Future<Either<Failure, Userentityres>> register(
    Userentityreq userentityreq,
  ) async {
    try {
      Usermodelreq usermodelreq =
          Usermodelreq.fromentity(userentityreq);

      var response = await databaseservce.addData(
        endpoints: Endpoints.register,
        body: usermodelreq.tojson(),
      ) as Map<String, dynamic>;

      Usermodelres usermodelres =
          Usermodelres.fromjson(response);

      Userentityres userentityres =
          usermodelres.toentity();

      return Right(userentityres);
    } on DioException catch (e) {
      return Left(ServerFailure.fromDioException(e));
    } catch (e) {
      return Left(
        ServerFailure(errmessege: e.toString()),
      );
    }
  }

  @override
  Future<Either<Failure, Userentityres>> Signin(
    Userentitysigninreq userentitysigninreq,
  ) async {
    try {
      Usermodelsigninreq usermodelsigninreq =
          Usermodelsigninreq.fromentity(
        userentitysigninreq,
      );

      var response = await databaseservce.addData(
        endpoints: Endpoints.signin,
        body: usermodelsigninreq.tojson(),
      ) as Map<String, dynamic>;

      Usermodelres usermodelres =
          Usermodelres.fromjson(response);

      Userentityres userentityres =
          usermodelres.toentity();

      await saveUserData(userentityres);

      return Right(userentityres);
    } on DioException catch (e) {
      return Left(ServerFailure.fromDioException(e));
    } catch (e) {
      return Left(
        ServerFailure(errmessege: e.toString()),
      );
    }
  }

  @override
  Future<Either<Failure, String>> forgetPassword(
    String email,
  ) async {
    try {
      var response = await databaseservce.addData(
        endpoints: Endpoints.forgetPassword,
        body: {'email': email},
      ) as Map<String, dynamic>;

      String message = response['message'];

      return Right(message);
    } on DioException catch (e) {
      return Left(ServerFailure.fromDioException(e));
    } catch (e) {
      return Left(
        ServerFailure(errmessege: e.toString()),
      );
    }
  }

  @override
  Future<Either<Failure, String>> verifyOtp(
    String code,
  ) async {
    try {
      var response = await databaseservce.addData(
        endpoints: Endpoints.verifyOtp,
        body: {'code': code},
      ) as Map<String, dynamic>;

      String message = response['message'];

      return Right(message);
    } on DioException catch (e) {
      return Left(ServerFailure.fromDioException(e));
    } catch (e) {
      return Left(
        ServerFailure(errmessege: e.toString()),
      );
    }
  }

  Future<void> saveUserData(
    Userentityres userentityres,
  ) async {
    try {
      await localDatabaseService.addData(
        boxName: Constant.userBox,
        data: userentityres.toMap(),
        key: Constant.userKey,
      );
    } catch (e) {
      throw Exception(
        "Failed to save user data: $e",
      );
    }
  }
}