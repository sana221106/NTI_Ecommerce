import 'package:ecommerce/feature/Auth/domain/Repo/authrepo.dart';
import 'package:ecommerce/feature/Auth/presentation/cubit/verify_state.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class verifyCubit extends Cubit<verifyState> {
  final Authrepo authrepo;

  verifyCubit({required this.authrepo})
      : super(verifyInitial());

  Future verify({required String code}) async {
    emit(verifyLoading());

    var result = await authrepo.verifyOtp(code);

    result.fold(
      (ifleft) => emit(
        verifyFailure(
            errmessege: ifleft.errmessege,
        ),
      ),
      (ifright) => emit(
        verifySuccess(
          message: ifright,
        ),
      ),
    );
  }
}