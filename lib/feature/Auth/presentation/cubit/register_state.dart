part of 'register_cubit.dart';

@immutable
sealed class RegisterState {}

final class RegisterInitial extends RegisterState {}
final class RegisterLoading extends RegisterState {}
final class RegisterSuccess extends RegisterState {
  final Userentityres userentityres;
  RegisterSuccess({required this.userentityres});
}
final class RegisterFailure extends RegisterState {
  final String errmessege;
  RegisterFailure({required this.errmessege});
}
