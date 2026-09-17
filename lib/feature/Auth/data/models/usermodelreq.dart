import 'package:ecommerce/feature/Auth/domain/entities/userentityreq.dart';


class Usermodelreq {
  final String name;
  final String email;
  final String phone;
  final String password;
  final String repassword;

  Usermodelreq({
    required this.name,
    required this.email,
    required this.phone,
    required this.password,
    required this.repassword,
  });

  factory Usermodelreq.fromentity(Userentityreq userentityreq) {
    return Usermodelreq(
      name: userentityreq.name,
      email: userentityreq.email,
      phone: userentityreq.phone,
      password: userentityreq.password,
      repassword: userentityreq.repassword,
    );
  }

Map<String, dynamic> tojson() {
  return {
    "name": name,
    "email": email,
    "phone": phone,
    "password": password,
    "rePassword": repassword,
  };
}
}
