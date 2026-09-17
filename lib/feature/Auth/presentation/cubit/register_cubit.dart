import 'package:bloc/bloc.dart';
import 'package:ecommerce/feature/Auth/domain/Repo/authrepo.dart';
import 'package:ecommerce/feature/Auth/domain/entities/userentityreq.dart';
import 'package:ecommerce/feature/Auth/domain/entities/userentityres.dart';
import 'package:meta/meta.dart';

part 'register_state.dart';

class RegisterCubit extends Cubit<RegisterState> {
  final Authrepo authrepo;

  RegisterCubit({required this.authrepo}) : super(RegisterInitial());

  Future<void> register(Userentityreq userentityreq) async {
    emit(RegisterLoading());

    var result = await authrepo.register(userentityreq);

    result.fold(
      (ifleft) => emit(RegisterFailure(errmessege: ifleft.errmessege)),
      (ifright) => emit(RegisterSuccess(userentityres: ifright)),
    );
  }
}
