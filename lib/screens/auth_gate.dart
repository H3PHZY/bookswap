import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../services/services/auth_service.dart';

// --- Import your new, real screens ---
import 'login_screen.dart';
import 'verify_email_screen.dart';
// We'll create this one next, for now, a placeholder is fine
// import 'main_app_screen.dart'; 

// TODO: Create a placeholder MainAppScreen for now
class MainAppScreen extends ConsumerWidget {
  const MainAppScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final authService = ref.watch(authServiceProvider);
    return Scaffold(
      appBar: AppBar(
        title: const Text("BookSwap Home"),
        actions: [
          IconButton(
            icon: const Icon(Icons.logout),
            onPressed: () {
              authService.signOut();
            },
          )
        ],
      ),
      body: Center(
        child: Text("Welcome ${authService.currentUser?.email}!"),
      ),
    );
  }
}
// --- End of placeholder ---


// Provider for the AuthService (so we can access it)
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
    // Watch the auth state provider
    final authState = ref.watch(authStateProvider);

    return authState.when(
      data: (user) {
        if (user == null) {
          // User is logged out
          return const LoginScreen();
        } else if (!user.emailVerified) {
          // User is logged in but email is not verified
          return const VerifyEmailScreen();
        } else {
          // User is logged in and verified
          return const MainAppScreen(); // This is your BottomNavBar screen
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