import '../models/user_model.dart';

abstract class AuthRepository {
  Future<UserModel> login(LoginRequest request);
  Future<bool> register(UserModel user, String password);
  Future<bool> sendPasswordResetCode(String identifier);
  Future<bool> resetPassword(String otp, String newPassword);
}