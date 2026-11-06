import 'package:flutter/material.dart';
import 'package:student_auth/repositories/auth_repository_impl.dart';
import '../repositories/auth_repository.dart';
import '../models/user_model.dart';

class AuthController extends ChangeNotifier {
  final AuthRepository repository;
  
  bool isLoading = false;
  String? errorMessage;
  UserModel? currentUser;

  AuthController(this.repository);

  void _setLoading(bool value) {
    isLoading = value;
    notifyListeners();
  }

  Future<bool> login(String identifier, String password) async {
    _setLoading(true);
    errorMessage = null;
    try {
      final request = LoginRequest(identifier: identifier, password: password);
      currentUser = await repository.login(request);
      _setLoading(false);
      return true;
    } catch (e) {
      errorMessage = e.toString();
      _setLoading(false);
      return false;
    }
  }

  Future<bool> register(UserModel user, String password) async {
    _setLoading(true);
    errorMessage = null;
    try {
      final success = await repository.register(user, password);
      _setLoading(false);
      return success;
    } catch (e) {
      errorMessage = e.toString();
      _setLoading(false);
      return false;
    }
  }

  Future<bool> sendPasswordResetCode(String identifier) async {
    _setLoading(true);
    try {
      final success = await repository.sendPasswordResetCode(identifier);
      _setLoading(false);
      return success;
    } catch (e) {
      _setLoading(false);
      return false;
    }
  }

  Future<bool> resetPassword(String otp, String newPassword) async {
    _setLoading(true);
    try {
      final success = await repository.resetPassword(otp, newPassword);
      _setLoading(false);
      return success;
    } catch (e) {
      _setLoading(false);
      return false;
    }
  }
}

// كائن عالمي بسيط لتمثيل حقن الاعتماديات (Dependency Injection) دون حزم
final authController = AuthController(AuthRepositoryImpl());