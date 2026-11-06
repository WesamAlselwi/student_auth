class FormValidators {
  static String? loginIdentifier(String? val) {
    if (val == null || val.isEmpty) return 'هذا الحقل مطلوب';
    if (val.length < 5) return 'يجب أن يتكون من 5 خانات على الأقل';
    return null;
  }

  static String? loginPassword(String? val) {
    if (val == null || val.isEmpty) return 'هذا الحقل مطلوب';
    if (val.length < 6) return 'يجب أن تتكون من 6 محارف على الأقل';
    return null;
  }

  static String? fullName(String? val) {
    if (val == null || val.trim().isEmpty) return 'يرجى إدخال الاسم';
    if (val.trim().length < 3) return 'الاسم يجب أن يكون 3 أحرف فأكثر';
    return null;
  }

  static String? academicId(String? val) {
    if (val == null || val.isEmpty) return 'الرقم الأكاديمي مطلوب';
    if (!RegExp(r'^\d{9,10}$').hasMatch(val)) return 'يجب أن يتكون من 9 إلى 10 أرقام حصراً';
    return null;
  }

  static String? email(String? val) {
    if (val == null || val.isEmpty) return 'البريد الإلكتروني مطلوب';
    if (!RegExp(r'^[\w-\.]+@([\w-]+\.)+[\w-]{2,4}$').hasMatch(val)) {
      return 'صيغة البريد الإلكتروني غير صحيحة';
    }
    return null;
  }

  static String? strongPassword(String? val) {
    if (val == null || val.isEmpty) return 'كلمة المرور مطلوبة';
    if (val.length < 8) return 'يجب أن تتكون من 8 محارف على الأقل';
    if (!RegExp(r'(?=.*[A-Z])').hasMatch(val)) return 'يجب أن تحتوي على حرف إنجليزي كبير (Capital)';
    if (!RegExp(r'(?=.*\d)').hasMatch(val)) return 'يجب أن تحتوي على رقم واحد على الأقل';
    return null;
  }

  static String? confirmPassword(String? val, String password) {
    if (val == null || val.isEmpty) return 'يرجى تأكيد كلمة المرور';
    if (val != password) return 'كلمات المرور غير متطابقة 100%';
    return null;
  }

  static String? otp(String? val) {
    if (val == null || val.isEmpty) return 'رمز التحقق مطلوب';
    if (!RegExp(r'^\d{6}$').hasMatch(val)) return 'رمز التحقق يجب أن يكون 6 أرقام حصراً';
    return null;
  }
}