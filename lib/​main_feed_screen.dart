import 'package:flutter/material.dart';

class MainFeedScreen extends StatefulWidget {
  const MainFeedScreen({super.key});

  @override
  State<MainFeedScreen> createState() => _MainFeedScreenState();
}

class _MainFeedScreenState extends State<MainFeedScreen> {
  bool isLiked = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      body: Stack(
        children: [
          const Center(
            child: Text('Vertical Video Player', style: TextStyle(color: Colors.white54)),
          ),
          Positioned(
            right: 16,
            bottom: 40,
            child: Column(
              children: [
                IconButton(
                  icon: Icon(
                    isLiked ? Icons.favorite : Icons.favorite_border,
                    color: isLiked ? const Color(0xFFFF2C55) : Colors.white,
                    size: 32,
                  ),
                  onPressed: () {
                    setState(() {
                      isLiked = !isLiked;
                    });
                  },
                ),
                const SizedBox(height: 16),
                IconButton(
                  icon: const Icon(Icons.comment, color: Colors.white, size: 32),
                  onPressed: () {},
                ),
                const SizedBox(height: 16),
                IconButton(
                  icon: const Icon(Icons.share, color: Colors.white, size: 32),
                  onPressed: () {},
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
