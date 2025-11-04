import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'auth_gate.dart'; // To get the authServiceProvider

class SettingsScreen extends ConsumerWidget {
  const SettingsScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final authService = ref.watch(authServiceProvider);
    
    return Scaffold(
      appBar: AppBar(title: const Text("Settings")),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              "Profile",
              style: Theme.of(context).textTheme.headlineSmall,
            ),
            ListTile(
              leading: const Icon(Icons.email),
              title: const Text("Email"),
              subtitle: Text(authService.currentUser?.email ?? "Not logged in"),
            ),
            const Divider(),
            Text(
              "Preferences",
              style: Theme.of(context).textTheme.headlineSmall,
            ),
            SwitchListTile(
              title: const Text("Enable Notifications"),
              value: false, // This is just a simulation as required
              onChanged: (bool value) {
                // TODO: Add state logic if you want
              },
            ),
            const Spacer(),
            Center(
              child: ElevatedButton(
                style: ElevatedButton.styleFrom(
                  backgroundColor: Theme.of(context).colorScheme.error,
                  foregroundColor: Theme.of(context).colorScheme.onError,
                ),
                onPressed: () {
                  authService.signOut();
                },
                child: const Text("Logout"),
              ),
            ),
          ],
        ),
      ),
    );
  }
}