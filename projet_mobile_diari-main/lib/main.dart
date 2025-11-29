// Diari - Prototype fidèle au design fourni (Onboarding, Login, Home)
import 'package:flutter/material.dart';
import 'onboarding_page.dart';
import 'login_page.dart';
import 'home_page.dart';
import 'dish_details_page.dart'; // كان حطّيت صفحة التفاصيل في هذا الملف

void main() {
  runApp(const DiariPrototype());
}

class DiariPrototype extends StatelessWidget {
  const DiariPrototype({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Diari Prototype',

      // الثيم العام
      theme: ThemeData(
        scaffoldBackgroundColor: const Color(0xFFF7EFE6),
        fontFamily: 'Roboto',
        useMaterial3: false,
      ),

      // الانطلاق من شاشة الـ Onboarding
      initialRoute: '/onboarding',

      // المسارات الرئيسية للتطبيق
      routes: {
        '/onboarding': (context) => const OnboardingPage(),
        '/login': (context) => const LoginPage(),
        '/home': (context) => const HomePage(),
        // تنجم تستعمل هذي كي تحب تفتح تفاصيل لازانيا مثلا
        '/dish-details': (context) => const DishDetailsPage(),
      },

      // نخلي الـ RTL عام للتطبيق الكل
      builder: (context, child) {
        return Directionality(
          textDirection: TextDirection.rtl,
          child: child ?? const SizedBox.shrink(),
        );
      },
    );
  }
}
