import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../services/auth_service.dart';

// --- Import your real screens ---
import 'login_screen.dart';
import 'verify_email_screen.dart';
import 'main_app_screen.dart'; // <-- This is your new BottomNavBar screen!

// Provider for the AuthService
final authServiceProvider = Provider<AuthService>((ref) {
  return AuthService();
});

// Stream provider to listen to auth changes
final authStateProvider = StreamProvider<User?>((ref) {
  return ref.read(authServiceProvider).authStateChanges;
});

class AuthGate extends ConsumerWidget {
  const AuthGate({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final authState = ref.watch(authStateProvider);

    return authState.when(
      data: (user) {
        if (user == null) {
          return const LoginScreen();
        } else if (!user.emailVerified) {
          return const VerifyEmailScreen();
        } else {
          // User is logged in and verified!
          return const MainAppScreen(); 
        }
      },
      loading: () => const Scaffold(
        body: Center(child: CircularProgressIndicator()),
      ),
      error: (error, stack) => Scaffold(
        body: Center(child: Text("Error: $error")),
      ),
    );
  }
}