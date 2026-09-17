
import 'package:ecommerce/feature/Auth/domain/entities/userentitysigninreq.dart';

class Usermodelsigninreq {
final String email;
final String password;

  factory Usermodelsigninreq.fromentity(Userentitysigninreq userentitysigninreq) {
    return Usermodelsigninreq(
      email: userentitysigninreq.email,
      password: userentitysigninreq.password,
    );
  }

  Usermodelsigninreq({required this.email, required this.password});

Map<String, dynamic> tojson(){
    return {
      "email": email,
      "password": password,
    };
  }
}
