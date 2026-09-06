import 'package:flutter/material.dart';

class MainFeedScreen extends StatefulWidget {
  const MainFeedScreen({super.key});

  @override
  State<MainFeedScreen> createState() => _MainFeedScreenState();
}

class _MainFeedScreenState extends State<MainFeedScreen> {
  bool isCleanMode = false;
  bool isAudioOnly = false;
  bool showEmojiWheel = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      body: Stack(
        children: [
          // 1. Video Player Area / Audio Mode Background
          Center(
            child: isAudioOnly
                ? const Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Icon(Icons.headset, size: 80, color: Colors.greenAccent),
                      SizedBox(height: 12),
                      Text("Audio-Only Mode Active", style: TextStyle(color: Colors.white)),
                    ],
                  )
                : Container(
                    color: Colors.grey[900],
                    child: const Center(child: Text("Vertical Video Player", style: TextStyle(color: Colors.white54))),
                  ),
          ),

          // 2. Top Bar Overlay
          if (!isCleanMode)
            Positioned(
              top: 50,
              left: 16,
              right: 16,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  IconButton(
                    icon: const Icon(Icons.dialpad, color: Colors.white),
                    onPressed: () {},
                  ),
                  Row(
                    children: const [
                      Text("Following", style: TextStyle(color: Colors.white70)),
                      SizedBox(width: 12),
                      Text("For You", style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold)),
                      SizedBox(width: 12),
                      Text("Time-Machine", style: TextStyle(color: Colors.white70)),
                    ],
                  ),
                  IconButton(
                    icon: const Icon(Icons.cleaning_services, color: Colors.white),
                    onPressed: () => setState(() => isCleanMode = true),
                  ),
                ],
              ),
            ),

          // Exit Clean Mode Button
          if (isCleanMode)
            Positioned(
              top: 50,
              right: 16,
              child: IconButton(
                icon: const Icon(Icons.visibility, color: Colors.white),
                onPressed: () => setState(() => isCleanMode = false),
              ),
            ),

          // 3. Right Side Floating Control Column
          if (!isCleanMode)
            Positioned(
              right: 12,
              bottom: 120,
              child: Column(
                children: [
                  const CircleAvatar(radius: 24, backgroundColor: Colors.purpleAccent),
                  const SizedBox(height: 20),
                  GestureDetector(
                    onLongPress: () => setState(() => showEmojiWheel = !showEmojiWheel),
                    child: const Icon(Icons.favorite, color: Colors.redAccent, size: 38),
                  ),
                  const SizedBox(height: 20),
                  const Icon(Icons.comment, color: Colors.white, size: 32),
                  const SizedBox(height: 20),
                  const Icon(Icons.monetization_on, color: Colors.amber, size: 32),
                  const SizedBox(height: 20),
                  const Icon(Icons.draw, color: Colors.pinkAccent, size: 32),
                ],
              ),
            ),

          // 4. Reaction Emoji Wheel Popup
          if (showEmojiWheel)
            Positioned(
              right: 60,
              bottom: 220,
              child: Container(
                padding: const EdgeInsets.all(8),
                decoration: BoxDecoration(color: Colors.black87, borderRadius: BorderRadius.circular(30)),
                child: Row(
                  children: const [
                    Text("❤️ ", style: TextStyle(fontSize: 24)),
                    Text("😂 ", style: TextStyle(fontSize: 24)),
                    Text("😮 ", style: TextStyle(fontSize: 24)),
                    Text("😢 ", style: TextStyle(fontSize: 24)),
                  ],
                ),
              ),
            ),

          // 5. Bottom Overlay Bar
          if (!isCleanMode)
            Positioned(
              left: 16,
              bottom: 30,
              right: 80,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text("@creator_username", style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold)),
                  const SizedBox(height: 6),
                  const Text("Movie recap video caption text... #BlinkShorts #Trending", style: TextStyle(color: Colors.white70)),
                  const SizedBox(height: 12),
                  Row(
                    children: [
                      ActionChip(label: const Text("1x Speed"), onPressed: () {}),
                      const SizedBox(width: 8),
                      ActionChip(label: const Text("Skip Chapter"), onPressed: () {}),
                      const SizedBox(width: 8),
                      ActionChip(
                        avatar: Icon(isAudioOnly ? Icons.audiotrack : Icons.videocam, size: 16),
                        label: Text(isAudioOnly ? "Audio Mode" : "Video Mode"),
                        onPressed: () => setState(() => isAudioOnly = !isAudioOnly),
                      ),
                    ],
                  )
                ],
              ),
            ),
        ],
      ),
    );
  }
}
