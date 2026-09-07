import 'package:flutter/material.dart';

class ExploreScreen extends StatelessWidget {
  const ExploreScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      appBar: AppBar(
        backgroundColor: Colors.black,
        title: const TextField(
          decoration: InputDecoration(
            hintText: 'Search creators, videos...',
            prefixIcon: Icon(Icons.search, color: Colors.white54),
            border: InputBorder.none,
          ),
        ),
      ),
      body: const Center(
        child: Text('Explore Content', style: TextStyle(color: Colors.white54)),
      ),
    );
  }
}
