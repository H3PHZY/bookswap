import 'package:flutter/material.dart';

class MyListingsScreen extends StatelessWidget {
  const MyListingsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("My Listings")),
      body: const Center(
        child: Text("My Posted Books & Incoming Offers Will Show Here"),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          // TODO: Navigate to the 'Post New Book' screen
        },
        child: const Icon(Icons.add),
      ),
    );
  }
}