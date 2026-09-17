import 'package:ecommerce/feature/Auth/domain/entities/userentityres.dart';

class Usermodelres {
  final String token;
  final String message;
  final String name;
  final String email;

  Usermodelres({
    required this.token,
    required this.message,
    required this.name,
    required this.email,
  });

  factory Usermodelres.fromjson(Map<String, dynamic> json) {
    return Usermodelres(
      token: json['token'],
      message: json['message'],
      name: json['user']['name'],
      email: json['user']['email'],
    );
  }

  Userentityres toentity() {
    return Userentityres(
      token: token,
      message: message,
      name: name,
      email: email,
    );
  }
}