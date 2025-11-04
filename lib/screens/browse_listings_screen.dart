import 'package:flutter/material.dart';

class BrowseListingsScreen extends StatelessWidget {
  const BrowseListingsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Browse Listings")),
      body: const Center(
        child: Text("All Book Listings Will Show Here"),
      ),
    );
  }
}