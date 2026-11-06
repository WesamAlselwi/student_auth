import 'package:flutter/material.dart';
import 'views/auth/login_page.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'نظام المصادقة الطلابي',
      theme: ThemeData(primarySwatch: Colors.blue),
      // إجبار اتجاه النص ليكون من اليمين لليسار (اللغة العربية)
      builder: (context, child) => Directionality(
        textDirection: TextDirection.rtl,
        child: child!,
      ),
      home: const LoginPage(),
    );
  }
}