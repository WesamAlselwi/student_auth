import 'package:flutter/material.dart';
import '../../controllers/auth_controller.dart';
import '../../utils/form_validators.dart';
import 'reset_password_page.dart';

class ForgotPasswordPage extends StatefulWidget {
  const ForgotPasswordPage({super.key});

  @override
  State<ForgotPasswordPage> createState() => _ForgotPasswordPageState();
}

class _ForgotPasswordPageState extends State<ForgotPasswordPage> {
  final _formKey = GlobalKey<FormState>();
  final _identifierController = TextEditingController();

  void _sendCode() async {
    if (_formKey.currentState!.validate()) {
      final success = await authController.sendPasswordResetCode(_identifierController.text.trim());
      
      if (success && mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('تم إرسال رمز التحقق بنجاح'), backgroundColor: Colors.green),
        );
        Navigator.pushReplacement(
          context, MaterialPageRoute(builder: (_) => const ResetPasswordPage()),
        );
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('استعادة كلمة المرور')),
      body: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Form(
          key: _formKey,
          child: Column(
            children: [
              const Card(
                color: Colors.blueAccent,
                child: Padding(
                  padding: EdgeInsets.all(16.0),
                  child: Text(
                    'أدخل بريدك الجامعي أو رقمك الأكاديمي، وسنرسل لك رمز تحقق (OTP) لاستعادة حسابك.',
                    style: TextStyle(color: Colors.white, fontSize: 16),
                    textAlign: TextAlign.center,
                  ),
                ),
              ),
              const SizedBox(height: 30),
              TextFormField(
                controller: _identifierController,
                decoration: const InputDecoration(
                  labelText: 'البريد أو الرقم الأكاديمي',
                  border: OutlineInputBorder(),
                ),
                validator: FormValidators.loginIdentifier,
              ),
              const SizedBox(height: 30),
              ListenableBuilder(
                listenable: authController,
                builder: (context, child) {
                  return authController.isLoading
                      ? const CircularProgressIndicator()
                      : SizedBox(
                          width: double.infinity,
                          height: 50,
                          child: ElevatedButton(
                            onPressed: _sendCode,
                            child: const Text('إرسال رمز التحقق'),
                          ),
                        );
                },
              ),
              const SizedBox(height: 15),
              TextButton(
                onPressed: () => Navigator.pop(context),
                child: const Text('العودة لتسجيل الدخول'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}