class UserModel {
  final String id;
  final String name;
  final String email;

  UserModel({
    required this.id,
    required this.name,
    required this.email,
  });
}

class LoginRequest {
  final String identifier; // المعرف أو البريد
  final String password;

  LoginRequest({required this.identifier, required this.password});
}