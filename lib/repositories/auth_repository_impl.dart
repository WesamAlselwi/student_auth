import 'auth_repository.dart';
import '../models/user_model.dart';

class AuthRepositoryImpl implements AuthRepository {
  @override
  Future<UserModel> login(LoginRequest request) async {
    await Future.delayed(const Duration(seconds: 2)); // محاكاة الاتصال بالشبكة
    if (request.identifier == 'error') throw Exception('فشل تسجيل الدخول');
    return UserModel(id: '123', name: 'طالب تجريبي', email: 'student@univ.edu');
  }

  @override
  Future<bool> register(UserModel user, String password) async {
    await Future.delayed(const Duration(seconds: 2));
    return true; // محاكاة نجاح الإنشاء
  }

  @override
  Future<bool> sendPasswordResetCode(String identifier) async {
    await Future.delayed(const Duration(seconds: 2));
    return true; 
  }

  @override
  Future<bool> resetPassword(String otp, String newPassword) async {
    await Future.delayed(const Duration(seconds: 2));
    return true;
  }
}