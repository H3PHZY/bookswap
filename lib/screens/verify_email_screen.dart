import 'dart:async';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'auth_gate.dart'; // To get the authServiceProvider

class VerifyEmailScreen extends ConsumerStatefulWidget {
  const VerifyEmailScreen({super.key});

  @override
  ConsumerState<VerifyEmailScreen> createState() => _VerifyEmailScreenState();
}

class _VerifyEmailScreenState extends ConsumerState<VerifyEmailScreen> {
  Timer? _timer;

  @override
  void initState() {
    super.initState();
    // Start a timer to periodically check if the email has been verified
    _timer = Timer.periodic(const Duration(seconds: 5), (timer) {
      ref.read(authServiceProvider).currentUser?.reload();
      final user = ref.read(authServiceProvider).currentUser;
      if (user?.emailVerified ?? false) {
        timer.cancel();
        // The AuthGate will see the change and navigate automatically
        // but we can force a rebuild of the AuthGate's stream
        ref.refresh(authStateProvider); 
      }
    });
  }

  @override
  void dispose() {
    _timer?.cancel();
    super.dispose();
  }

  Future<void> _resendVerificationEmail() async {
    try {
      await ref.read(authServiceProvider).currentUser?.sendEmailVerification();
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text("Verification email sent!")),
        );
      }
    } catch (e) {
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text(e.toString())),
        );
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    final authService = ref.watch(authServiceProvider);
    
    return Scaffold(
      appBar: AppBar(title: const Text("Verify Your Email")),
      body: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                "A verification email has been sent to:",
                style: Theme.of(context).textTheme.titleLarge,
                textAlign: TextAlign.center,
              ),
              const SizedBox(height: 10),
              Text(
                authService.currentUser?.email ?? "your email",
                style: Theme.of(context).textTheme.titleMedium,
                textAlign: TextAlign.center,
              ),
              const SizedBox(height: 20),
              const Text(
                "Please check your inbox (and spam folder) and click the link to verify your account.",
                textAlign: TextAlign.center,
              ),
              const SizedBox(height: 30),
              ElevatedButton(
                onPressed: _resendVerificationEmail,
                child: const Text("Resend Email"),
              ),
              TextButton(
                onPressed: () {
                  authService.signOut();
                },
                child: const Text("Cancel (Logout)"),
              ),
            ],
          ),
        ),
      ),
    );
  }
}