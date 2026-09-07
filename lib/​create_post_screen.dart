import 'package:flutter/material.dart';

class CreatePostScreen extends StatelessWidget {
  const CreatePostScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      body: Center(
        child: ElevatedButton.icon(
          style: ElevatedButton.styleFrom(
            backgroundColor: const Color(0xFFFF2C55),
          ),
          onPressed: () {},
          icon: const Icon(Icons.videocam, color: Colors.white),
          label: const Text('Record Video', style: TextStyle(color: Colors.white)),
        ),
      ),
    );
  }
}
