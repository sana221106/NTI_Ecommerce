import 'package:dartz/dartz.dart';
import 'package:ecommerce/cores/error/Failure.dart';
import 'package:ecommerce/feature/Auth/domain/entities/userentityreq.dart';
import 'package:ecommerce/feature/Auth/domain/entities/userentityres.dart';
import 'package:ecommerce/feature/Auth/domain/entities/userentitysigninreq.dart';

abstract class Authrepo {
  Future<Either<Failure, Userentityres>> register(
    Userentityreq userentityreq,
  );

  Future<Either<Failure, Userentityres>> Signin(
    Userentitysigninreq userentitysigninreq,
  );
  Future<Either<Failure, String>> forgetPassword(
    String email,
  );
  Future<Either<Failure, String>> verifyOtp(
    String code,
  );
}