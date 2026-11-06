import 'package:flutter/material.dart';
import '../../controllers/auth_controller.dart';
import '../../utils/form_validators.dart';
import 'register_page.dart';
import 'forgot_password_page.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final _formKey = GlobalKey<FormState>();
  final _idController = TextEditingController();
  final _passwordController = TextEditingController();
  
  bool _obscurePassword = true;
  bool _rememberMe = false;

  void _performLogin() async {
    if (_formKey.currentState!.validate()) {
      final success = await authController.login(
        _idController.text.trim(),
        _passwordController.text,
      );
      if (success && mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('تم تسجيل الدخول بنجاح!'), backgroundColor: Colors.green),
        );
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('تسجيل الدخول')),
      body: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Form(
          key: _formKey,
          child: SingleChildScrollView(
            child: Column(
              children: [
                const Icon(Icons.school, size: 100, color: Colors.blue),
                const SizedBox(height: 30),
                TextFormField(
                  controller: _idController,
                  decoration: const InputDecoration(
                    labelText: 'المعرف الأكاديمي أو البريد',
                    border: OutlineInputBorder(),
                  ),
                  validator: FormValidators.loginIdentifier,
                ),
                const SizedBox(height: 15),
                TextFormField(
                  controller: _passwordController,
                  obscureText: _obscurePassword,
                  decoration: InputDecoration(
                    labelText: 'كلمة المرور',
                    border: const OutlineInputBorder(),
                    suffixIcon: IconButton(
                      icon: Icon(_obscurePassword ? Icons.visibility_off : Icons.visibility),
                      onPressed: () {
                        setState(() { _obscurePassword = !_obscurePassword; });
                      },
                    ),
                  ),
                  validator: FormValidators.loginPassword,
                ),
                const SizedBox(height: 10),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Row(
                      children: [
                        Checkbox(
                          value: _rememberMe,
                          onChanged: (val) => setState(() => _rememberMe = val!),
                        ),
                        const Text('تذكرني'),
                      ],
                    ),
                    TextButton(
                      onPressed: () => Navigator.push(
                        context, MaterialPageRoute(builder: (_) => const ForgotPasswordPage()),
                      ),
                      child: const Text('نسيت كلمة المرور؟'),
                    ),
                  ],
                ),
                const SizedBox(height: 20),
                ListenableBuilder(
                  listenable: authController,
                  builder: (context, child) {
                    return authController.isLoading
                        ? const CircularProgressIndicator()
                        : SizedBox(
                            width: double.infinity,
                            height: 50,
                            child: ElevatedButton(
                              onPressed: _performLogin,
                              child: const Text('تسجيل الدخول'),
                            ),
                          );
                  },
                ),
                const SizedBox(height: 20),
                TextButton(
                  onPressed: () => Navigator.push(
                    context, MaterialPageRoute(builder: (_) => const RegisterPage()),
                  ),
                  child: const Text('ليس لديك حساب؟ إنشاء حساب جديد'),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}