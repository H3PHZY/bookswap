import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'firebase_options.dart';
import 'screens/auth_gate.dart'; // 1. Import your new AuthGate

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  runApp(
    const ProviderScope(
      child: MyApp(),
    ),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // Academic theme color palette
  static const Color primaryBlue = Color(0xFF0A4D68); // Scholarly Blue
  static const Color accentOrange = Color(0xFFF9A826); // Vibrant Orange
  static const Color backgroundWhite = Color(0xFFF8F8F8); // Paper White
  static const Color surfaceWhite = Color(0xFFFFFFFF); // Card White
  static const Color primaryText = Color(0xFF222222);
  static const Color secondaryText = Color(0xFF6C6C6C);
  static const Color successGreen = Color(0xFF28A745);
  static const Color errorRed = Color(0xFFD9534F);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'BookSwap',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        useMaterial3: true,
        colorScheme: ColorScheme.light(
          primary: primaryBlue,
          secondary: accentOrange,
          surface: surfaceWhite,
          background: backgroundWhite,
          error: errorRed,
          onPrimary: Colors.white,
          onSecondary: Colors.white,
          onSurface: primaryText,
          onBackground: primaryText,
          onError: Colors.white,
        ),
        scaffoldBackgroundColor: backgroundWhite,
        appBarTheme: AppBarTheme(
          centerTitle: true,
          elevation: 0,
          backgroundColor: primaryBlue,
          foregroundColor: Colors.white,
          iconTheme: const IconThemeData(color: Colors.white),
        ),
        cardTheme: CardThemeData(
          color: surfaceWhite,
          elevation: 2,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(12),
          ),
        ),
        inputDecorationTheme: InputDecorationTheme(
          filled: true,
          fillColor: surfaceWhite,
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(12),
            borderSide: BorderSide(color: Colors.grey.withValues(alpha: 0.3)),
          ),
          enabledBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(12),
            borderSide: BorderSide(color: Colors.grey.withValues(alpha: 0.3)),
          ),
          focusedBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(12),
            borderSide: const BorderSide(color: primaryBlue, width: 2),
          ),
        ),
        elevatedButtonTheme: ElevatedButtonThemeData(
          style: ElevatedButton.styleFrom(
            backgroundColor: primaryBlue,
            foregroundColor: Colors.white,
            padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 12),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(12),
            ),
          ),
        ),
        floatingActionButtonTheme: const FloatingActionButtonThemeData(
          backgroundColor: accentOrange,
          foregroundColor: Colors.white,
        ),
        bottomNavigationBarTheme: BottomNavigationBarThemeData(
          backgroundColor: surfaceWhite,
          selectedItemColor: primaryBlue,
          unselectedItemColor: secondaryText,
          type: BottomNavigationBarType.fixed,
          elevation: 8,
        ),
        switchTheme: SwitchThemeData(
          thumbColor: MaterialStateProperty.resolveWith((states) {
            if (states.contains(MaterialState.selected)) {
              return accentOrange;
            }
            return Colors.grey;
          }),
          trackColor: MaterialStateProperty.resolveWith((states) {
            if (states.contains(MaterialState.selected)) {
              return accentOrange.withValues(alpha: 0.5);
            }
            return Colors.grey.withValues(alpha: 0.3);
          }),
        ),
        textTheme: const TextTheme(
          displayLarge: TextStyle(color: primaryText),
          displayMedium: TextStyle(color: primaryText),
          displaySmall: TextStyle(color: primaryText),
          headlineLarge: TextStyle(color: primaryText),
          headlineMedium: TextStyle(color: primaryText),
          headlineSmall: TextStyle(color: primaryText),
          titleLarge: TextStyle(color: primaryText),
          titleMedium: TextStyle(color: primaryText),
          titleSmall: TextStyle(color: primaryText),
          bodyLarge: TextStyle(color: primaryText),
          bodyMedium: TextStyle(color: primaryText),
          bodySmall: TextStyle(color: secondaryText),
          labelLarge: TextStyle(color: primaryText),
          labelMedium: TextStyle(color: secondaryText),
          labelSmall: TextStyle(color: secondaryText),
        ),
      ),
      // 2. Set the home to your AuthGate
      home: const AuthGate(),
    );
  }
}