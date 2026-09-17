import 'package:ecommerce/feature/Auth/domain/entities/userentityres.dart';

sealed class SigninState {}

final class SigninInitial extends SigninState {}

final class SigninLoading extends SigninState {}

final class SigninSuccess extends SigninState {
  final Userentityres userentityres;

  SigninSuccess({
    required this.userentityres,
  });
}

final class SigninFailure extends SigninState {
  final String errmessege;

  SigninFailure({
    required this.errmessege,
  });
}