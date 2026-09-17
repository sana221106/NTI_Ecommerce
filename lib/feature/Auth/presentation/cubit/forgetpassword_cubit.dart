import 'package:ecommerce/feature/Auth/domain/Repo/authrepo.dart';
import 'package:ecommerce/feature/Auth/presentation/cubit/forgetpassword_state.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class forgetpassCubit extends Cubit<forgetpassState> {
  final Authrepo authrepo;

  forgetpassCubit({required this.authrepo})
      : super(forgetpassInitial());

  Future forgetpass({required String email}) async {
    emit(forgetpassLoading());

    var result = await authrepo.forgetPassword(email);

    result.fold(
      (ifleft) => emit(
        forgetpassFailure(errmessege:
          ifleft.errmessege,
        ),
      ),
      (ifright) => emit(
        forgetpassSuccess(
          message: ifright,
        ),
      ),
    );
  }
}