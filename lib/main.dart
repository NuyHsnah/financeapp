import 'package:flutter/material.dart';
import 'screens/splash_screen.dart'; // Tambahkan import ini
import 'screens/home_screen.dart'; // tetap boleh ada untuk navigasi setelah splash

void main() {
  runApp(const FinanceApp());
}

class FinanceApp extends StatelessWidget {
  const FinanceApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'FinanceApp',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        useMaterial3: true,
        brightness: Brightness.light,
        primaryColor: const Color(0xFF1B5E20), // Hijau emerald elegan
        scaffoldBackgroundColor: const Color(0xFFFAFAFA),

        colorScheme: ColorScheme.fromSwatch().copyWith(
          primary: const Color(0xFF1B5E20),
          secondary: const Color(0xFF81C784),
        ),

        appBarTheme: const AppBarTheme(
          backgroundColor: Color(0xFF1B5E20),
          foregroundColor: Colors.white,
          elevation: 1,
          centerTitle: true,
          titleTextStyle: TextStyle(
            fontSize: 20,
            fontWeight: FontWeight.w600,
            color: Colors.white,
          ),
        ),

        cardTheme: CardThemeData(
          color: const Color(0xFFF9FFF9),
          elevation: 2,
          margin: const EdgeInsets.symmetric(vertical: 6, horizontal: 8),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(12),
          ),
        ),

        textTheme: const TextTheme(
          titleMedium: TextStyle(
            color: Color(0xFF1B5E20),
            fontWeight: FontWeight.w600,
          ),
          bodyMedium: TextStyle(color: Colors.black87, fontSize: 14),
        ),

        floatingActionButtonTheme: const FloatingActionButtonThemeData(
          backgroundColor: Color(0xFF81C784),
          foregroundColor: Colors.white,
        ),

        iconTheme: const IconThemeData(color: Color(0xFF1B5E20)),
      ),

      // 👇 SplashScreen akan tampil pertama kali
      home: const SplashScreen(),
    );
  }
}
