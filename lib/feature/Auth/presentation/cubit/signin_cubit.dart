import 'package:ecommerce/feature/Auth/domain/Repo/authrepo.dart';
import 'package:ecommerce/feature/Auth/domain/entities/userentitysigninreq.dart';
import 'package:ecommerce/feature/Auth/presentation/cubit/signin_state.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class SigninCubit extends Cubit<SigninState> {
  final Authrepo authrepo;

  SigninCubit({required this.authrepo})
      : super(SigninInitial());

  Future signin(Userentitysigninreq userentitysigninreq) async {
    emit(SigninLoading());

    var result = await authrepo.Signin(userentitysigninreq);

    result.fold(
      (ifleft) => emit(
        SigninFailure(
            errmessege: ifleft.errmessege,
        ),
      ),
      (ifright) => emit(
        SigninSuccess(
          userentityres: ifright,
        ),
      ),
    );
  }
}