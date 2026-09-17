sealed class verifyState {}

final class verifyInitial extends verifyState {}

final class verifyLoading extends verifyState {}

final class verifySuccess extends verifyState {
  final String message;

  verifySuccess({required this.message});
}

final class verifyFailure extends verifyState {
  final String errmessege;

  verifyFailure({required this.errmessege});
}
