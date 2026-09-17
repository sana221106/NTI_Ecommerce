class Userentityres {
  final String token;
  final String message;
  final String name;
  final String email;

  Userentityres({
    required this.token,
    required this.message,
    required this.name,
    required this.email,
  });
  Map<String, dynamic> toMap() {
    return {
      'name': name,
      'email': email,
      'token': token,
    };
  }
}