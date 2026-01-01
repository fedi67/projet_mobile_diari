import 'package:flutter/material.dart';
import 'dart:convert'; // For jsonEncode
import 'package:http/http.dart' as http; // For connecting to backend
import 'package:flutter/foundation.dart'; // REQUIRED: To check if running on Web (kIsWeb)

class SignupPage extends StatefulWidget {
  const SignupPage({super.key});

  @override
  State<SignupPage> createState() => _SignupPageState();
}

class _SignupPageState extends State<SignupPage> {
  final TextEditingController _name = TextEditingController();
  final TextEditingController _email = TextEditingController();
  final TextEditingController _pass = TextEditingController();
  final TextEditingController _confirm = TextEditingController();

  @override
  void dispose() {
    _name.dispose();
    _email.dispose();
    _pass.dispose();
    _confirm.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: const Color(0xFFCB675B),
        title: const Text('إنشاء حساب'),
        centerTitle: true,
      ),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(18.0),
          child: Card(
            elevation: 6,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(18),
            ),
            child: Padding(
              padding: const EdgeInsets.all(20),
              child: SingleChildScrollView(
                child: Column(
                  children: [
                    const Text(
                      'DIARI',
                      style: TextStyle(
                        fontSize: 36,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    const SizedBox(height: 8),
                    Text(
                      'أنشئ حسابك للتمتع بخدمات دْياري',
                      style: TextStyle(color: Colors.grey[700]),
                    ),
                    const SizedBox(height: 20),

                    _buildInput(
                      controller: _name,
                      hint: 'الإسم الكامل',
                      icon: Icons.person_outline,
                    ),
                    const SizedBox(height: 12),

                    _buildInput(
                      controller: _email,
                      hint: 'البريد الإلكتروني',
                      icon: Icons.email_outlined,
                    ),
                    const SizedBox(height: 12),

                    _buildInput(
                      controller: _pass,
                      hint: 'كلمة المرور',
                      obscure: true,
                      icon: Icons.lock_outline,
                    ),
                    const SizedBox(height: 12),

                    _buildInput(
                      controller: _confirm,
                      hint: 'تأكيد كلمة المرور',
                      obscure: true,
                      icon: Icons.lock_reset,
                    ),
                    const SizedBox(height: 18),

                    // BUTTON
                    SizedBox(
                      width: double.infinity,
                      child: ElevatedButton(
                        onPressed: _register,
                        style: ElevatedButton.styleFrom(
                          backgroundColor: const Color(0xFFCB675B),
                          padding: const EdgeInsets.symmetric(vertical: 14),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(28),
                          ),
                        ),
                        child: const Text(
                          'إنشاء الحساب',
                          style: TextStyle(fontSize: 16),
                        ),
                      ),
                    ),

                    const SizedBox(height: 20),
                    GestureDetector(
                      onTap: () {
                        Navigator.pop(context);
                      },
                      child: const Text(
                        'عندك حساب؟ تسجيل الدخول',
                        style: TextStyle(
                          color: Color(0xFFCB675B),
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildInput({
    required TextEditingController controller,
    required String hint,
    required IconData icon,
    bool obscure = false,
  }) {
    return TextField(
      controller: controller,
      obscureText: obscure,
      decoration: InputDecoration(
        filled: true,
        fillColor: Colors.grey[200],
        prefixIcon: Icon(icon),
        hintText: hint,
        contentPadding: const EdgeInsets.symmetric(vertical: 14),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(28),
          borderSide: BorderSide.none,
        ),
      ),
    );
  }

  Future<void> _register() async {
    // 1. Validation
    if (_name.text.isEmpty ||
        _email.text.isEmpty ||
        _pass.text.isEmpty ||
        _confirm.text.isEmpty) {
      _showMessage('الرجاء تعمير جميع الخانات');
      return;
    }

    if (_pass.text != _confirm.text) {
      _showMessage('كلمتا المرور غير متطابقتين');
      return;
    }

    // 2. Prepare the URL (Automatically detects Web vs Android)
    // If Web -> localhost, If Android -> 10.0.2.2
    final String baseUrl = kIsWeb ? 'http://localhost:3000' : 'http://10.0.2.2:3000';
    final url = Uri.parse('$baseUrl/api/auth/signup');

    print("Attempting to connect to: $url"); // Debug print

    try {
      // 3. Send Data to Backend
      final response = await http.post(
        url,
        headers: {'Content-Type': 'application/json'},
        body: jsonEncode({
          'username': _name.text,
          'email': _email.text,
          'password': _pass.text,
        }),
      );

      print("Response Status: ${response.statusCode}"); // Debug print
      print("Response Body: ${response.body}"); // Debug print

      // 4. Check Response
      if (response.statusCode == 201) {
        _showMessage('تم إنشاء الحساب بنجاح! الرجاء تسجيل الدخول');
        
        // Wait 1 second then go to login page
        await Future.delayed(const Duration(seconds: 1));
        if (mounted) Navigator.pop(context); 
      } else {
        // Error from server (e.g., "User already exists")
        final errorData = jsonDecode(response.body);
        _showMessage(errorData['message'] ?? 'حدث خطأ ما');
      }
    } catch (e) {
      // Network error (Server down, wrong IP, etc.)
      print("Error: $e"); 
      _showMessage('فشل الاتصال بالخادم. تأكد أن الباك اند يعمل');
    }
  }

  void _showMessage(String msg) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(msg, textAlign: TextAlign.center),
        backgroundColor: const Color(0xFFCB675B),
      ),
    );
  }
}