import 'package:flutter/material.dart';
import '../../controllers/auth_controller.dart';
import '../../models/user_model.dart';
import '../../utils/form_validators.dart';

class RegisterPage extends StatefulWidget {
  const RegisterPage({super.key});

  @override
  State<RegisterPage> createState() => _RegisterPageState();
}

class _RegisterPageState extends State<RegisterPage> {
  final _formKey = GlobalKey<FormState>();
  final _nameController = TextEditingController();
  final _academicIdController = TextEditingController();
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();
  final _confirmPasswordController = TextEditingController();
  
  bool _acceptedTerms = false;
  bool _obscurePass = true;

  void _performRegister() async {
    if (!_acceptedTerms) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('يجب الموافقة على اللوائح والشروط'), backgroundColor: Colors.red),
      );
      return;
    }

    if (_formKey.currentState!.validate()) {
      final user = UserModel(
        id: _academicIdController.text.trim(),
        name: _nameController.text.trim(),
        email: _emailController.text.trim(),
      );
      
      final success = await authController.register(user, _passwordController.text);
      
      if (success && mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('تم إنشاء الحساب بنجاح!'), backgroundColor: Colors.green),
        );
        Navigator.pop(context); // العودة لشاشة الدخول
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('إنشاء حساب جديد')),
      body: Form(
        key: _formKey,
        child: ListView(
          padding: const EdgeInsets.all(20.0),
          children: [
            TextFormField(
              controller: _nameController,
              decoration: const InputDecoration(labelText: 'الاسم الكامل', border: OutlineInputBorder()),
              validator: FormValidators.fullName,
            ),
            const SizedBox(height: 15),
            TextFormField(
              controller: _academicIdController,
              keyboardType: TextInputType.number,
              decoration: const InputDecoration(labelText: 'الرقم الأكاديمي', border: OutlineInputBorder()),
              validator: FormValidators.academicId,
            ),
            const SizedBox(height: 15),
            TextFormField(
              controller: _emailController,
              keyboardType: TextInputType.emailAddress,
              decoration: const InputDecoration(labelText: 'البريد الجامعي', border: OutlineInputBorder()),
              validator: FormValidators.email,
            ),
            const SizedBox(height: 15),
            TextFormField(
              controller: _passwordController,
              obscureText: _obscurePass,
              decoration: InputDecoration(
                labelText: 'كلمة المرور', 
                border: const OutlineInputBorder(),
                suffixIcon: IconButton(
                  icon: Icon(_obscurePass ? Icons.visibility_off : Icons.visibility),
                  onPressed: () => setState(() => _obscurePass = !_obscurePass),
                ),
              ),
              validator: FormValidators.strongPassword,
            ),
            const SizedBox(height: 15),
            TextFormField(
              controller: _confirmPasswordController,
              obscureText: true,
              decoration: const InputDecoration(labelText: 'تأكيد كلمة المرور', border: OutlineInputBorder()),
              validator: (val) => FormValidators.confirmPassword(val, _passwordController.text),
            ),
            const SizedBox(height: 15),
            CheckboxListTile(
              title: const Text('أوافق على اللوائح والشروط الأكاديمية', style: TextStyle(fontSize: 14)),
              value: _acceptedTerms,
              onChanged: (val) => setState(() => _acceptedTerms = val!),
              controlAffinity: ListTileControlAffinity.leading,
              contentPadding: EdgeInsets.zero,
            ),
            const SizedBox(height: 20),
            ListenableBuilder(
              listenable: authController,
              builder: (context, child) {
                return authController.isLoading
                    ? const Center(child: CircularProgressIndicator())
                    : SizedBox(
                        height: 50,
                        child: ElevatedButton(
                          onPressed: _performRegister,
                          child: const Text('إنشاء الحساب'),
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