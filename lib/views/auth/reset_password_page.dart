import 'package:flutter/material.dart';
import '../../controllers/auth_controller.dart';
import '../../utils/form_validators.dart';

class ResetPasswordPage extends StatefulWidget {
  const ResetPasswordPage({super.key});

  @override
  State<ResetPasswordPage> createState() => _ResetPasswordPageState();
}

class _ResetPasswordPageState extends State<ResetPasswordPage> {
  final _formKey = GlobalKey<FormState>();
  final _otpController = TextEditingController();
  final _newPasswordController = TextEditingController();
  final _confirmPasswordController = TextEditingController();

  void _resetPassword() async {
    if (_formKey.currentState!.validate()) {
      final success = await authController.resetPassword(
        _otpController.text.trim(),
        _newPasswordController.text,
      );

      if (success && mounted) {
        showDialog(
          context: context,
          barrierDismissible: false,
          builder: (ctx) => AlertDialog(
            title: const Text('نجاح'),
            content: const Text('تم تحديث كلمة المرور بنجاح. يمكنك الآن تسجيل الدخول.'),
            actions: [
              TextButton(
                onPressed: () {
                  Navigator.pop(ctx); // إغلاق النافذة
                  Navigator.pop(context); // العودة لشاشة تسجيل الدخول
                },
                child: const Text('موافق'),
              )
            ],
          ),
        );
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('تعيين كلمة المرور الجديدة')),
      body: Form(
        key: _formKey,
        child: ListView(
          padding: const EdgeInsets.all(20.0),
          children: [
            TextFormField(
              controller: _otpController,
              keyboardType: TextInputType.number,
              decoration: const InputDecoration(
                labelText: 'رمز التحقق (OTP)',
                border: OutlineInputBorder(),
              ),
              validator: FormValidators.otp,
            ),
            const SizedBox(height: 15),
            TextFormField(
              controller: _newPasswordController,
              obscureText: true,
              decoration: const InputDecoration(
                labelText: 'كلمة المرور الجديدة',
                border: OutlineInputBorder(),
              ),
              validator: FormValidators.strongPassword,
            ),
            const SizedBox(height: 15),
            TextFormField(
              controller: _confirmPasswordController,
              obscureText: true,
              decoration: const InputDecoration(
                labelText: 'تأكيد كلمة المرور الجديدة',
                border: OutlineInputBorder(),
              ),
              validator: (val) => FormValidators.confirmPassword(val, _newPasswordController.text),
            ),
            const SizedBox(height: 30),
            ListenableBuilder(
              listenable: authController,
              builder: (context, child) {
                return authController.isLoading
                    ? const Center(child: CircularProgressIndicator())
                    : SizedBox(
                        height: 50,
                        child: ElevatedButton(
                          onPressed: _resetPassword,
                          child: const Text('تحديث كلمة المرور'),
                        ),
                      );
              },
            ),
          ],
        ),
      ),
    );
  }
}