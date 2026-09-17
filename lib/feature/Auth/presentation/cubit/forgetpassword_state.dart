

sealed class forgetpassState {}

final class forgetpassInitial extends forgetpassState {}

final class forgetpassLoading extends forgetpassState {}

final class forgetpassSuccess extends forgetpassState {
  final String message;

  forgetpassSuccess({
    required this.message,
  });
}

final class forgetpassFailure extends forgetpassState {
  final String errmessege;

  forgetpassFailure({
     required this.errmessege,
  });
}