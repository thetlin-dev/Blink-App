import 'package:flutter/material.dart';

class MainFeedScreen extends StatefulWidget {
  const MainFeedScreen({super.key});

  @override
  State<MainFeedScreen> createState() => _MainFeedScreenState();
}

class _MainFeedScreenState extends State<MainFeedScreen> {
  int _selectedIndex = 2; // Home Icon ကို Select လုပ်ထားရန် (Index 2)

  void _showShareOptions(BuildContext context) {
    showModalBottomSheet(
      context: context,
      backgroundColor: Colors.grey[900],
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
      ),
      builder: (BuildContext context) {
        return Padding(
          padding: const EdgeInsets.symmetric(vertical: 20, horizontal: 16),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Container(
                width: 40,
                height: 4,
                decoration: BoxDecoration(
                  color: Colors.grey[600],
                  borderRadius: BorderRadius.circular(2),
                ),
              ),
              const SizedBox(height: 20),
              const Text(
                'Share to',
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 16,
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(height: 20),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  GestureDetector(
                    onTap: () {
                      Navigator.pop(context);
                      ScaffoldMessenger.of(context).showSnackBar(
                        const SnackBar(content: Text('Link copied to clipboard!')),
                      );
                    },
                    child: Column(
                      children: [
                        CircleAvatar(
                          radius: 26,
                          backgroundColor: Colors.grey[800],
                          child: const Icon(Icons.link_rounded, color: Colors.white, size: 26),
                        ),
                        const SizedBox(height: 8),
                        const Text('Copy Link', style: TextStyle(color: Colors.white, fontSize: 12)),
                      ],
                    ),
                  ),
                  GestureDetector(
                    onTap: () {
                      Navigator.pop(context);
                      ScaffoldMessenger.of(context).showSnackBar(
                        const SnackBar(content: Text('Share opened!')),
                      );
                    },
                    child: Column(
                      children: [
                        CircleAvatar(
                          radius: 26,
                          backgroundColor: Colors.pinkAccent,
                          child: const Icon(Icons.share_rounded, color: Colors.white, size: 26),
                        ),
                        const SizedBox(height: 8),
                        const Text('Share', style: TextStyle(color: Colors.white, fontSize: 12)),
                      ],
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 10),
            ],
          ),
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      body: Stack(
        children: [
          // 1. Full Screen Video Feed Area
          PageView.builder(
            scrollDirection: Axis.vertical,
            itemBuilder: (context, index) {
              return Stack(
                fit: StackFit.expand,
                children: [
                  // Center Content Placeholder
                  const Center(
                    child: Icon(Icons.play_circle_outline, size: 80, color: Colors.white24),
                  ),

                  // 2. Bottom Content Overlay (စာသားများ နှင့် Horizontal Action Buttons)
                  Positioned(
                    left: 16,
                    right: 16,
                    bottom: 20,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        // Username
                        const Text(
                          'Thet Lin Zaw',
                          style: TextStyle(
                            color: Colors.white,
                            fontWeight: FontWeight.bold,
                            fontSize: 16,
                          ),
                        ),
                        const SizedBox(height: 6),
                        
                        // Description & Hashtags
                        const Text(
                          'ဒီနေ့ဗီဒီယိုလေးပါ #funny #happy\n#movierecap #blink',
                          style: TextStyle(color: Colors.white, fontSize: 13, height: 1.4),
                        ),
                        const SizedBox(height: 16),

                        // Horizontal Action Row (Profile -> Like -> Comment -> Share)
                        Row(
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: [
                            // Profile Avatar (+ Icon ပါဝင်သည်)
                            Stack(
                              alignment: Alignment.bottomRight,
                              children: [
                                Container(
                                  padding: const EdgeInsets.all(1.5),
                                  decoration: const BoxDecoration(
                                    color: Colors.white,
                                    shape: BoxShape.circle,
                                  ),
                                  child: const CircleAvatar(
                                    radius: 20,
                                    backgroundColor: Colors.grey,
                                    child: Icon(Icons.person, color: Colors.white, size: 24),
                                  ),
                                ),
                                Container(
                                  decoration: const BoxDecoration(
                                    color: Colors.pinkAccent,
                                    shape: BoxShape.circle,
                                  ),
                                  child: const Icon(Icons.add, color: Colors.white, size: 14),
                                ),
                              ],
                            ),
                            const SizedBox(width: 20),

                            // Like Button (12.6)
                            GestureDetector(
                              onTap: () {},
                              child: const Row(
                                children: [
                                  Icon(Icons.favorite, color: Colors.redAccent, size: 24),
                                  SizedBox(width: 6),
                                  Text('12.6', style: TextStyle(color: Colors.white, fontSize: 13, fontWeight: FontWeight.bold)),
                                ],
                              ),
                            ),
                            const SizedBox(width: 20),

                            // Comment Button (1016)
                            GestureDetector(
                              onTap: () {},
                              child: const Row(
                                children: [
                                  Icon(Icons.chat_bubble_outline, color: Colors.white, size: 22),
                                  SizedBox(width: 6),
                                  Text('1016', style: TextStyle(color: Colors.white, fontSize: 13, fontWeight: FontWeight.bold)),
                                ],
                              ),
                            ),
                            const SizedBox(width: 20),

                            // Share Button (860)
                            GestureDetector(
                              onTap: () => _showShareOptions(context),
                              child: const Row(
                                children: [
                                  Icon(Icons.reply_rounded, color: Colors.white, size: 24),
                                  SizedBox(width: 6),
                                  Text('860', style: TextStyle(color: Colors.white, fontSize: 13, fontWeight: FontWeight.bold)),
                                ],
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                ],
              );
            },
          ),

          // 3. Top Header Title (FYP)
          const Positioned(
            top: 45,
            left: 0,
            right: 0,
            child: Center(
              child: Text(
                'FYP',
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
          ),

          // 4. Top Right BlinkMatch / BlinkWatch Button
          Positioned(
            top: 40,
            right: 16,
            child: Container(
              padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
              decoration: BoxDecoration(
                color: Colors.black.withOpacity(0.5),
                borderRadius: BorderRadius.circular(20),
                border: Border.all(color: Colors.pinkAccent, width: 1.5),
              ),
              child: const Row(
                children: [
                  Icon(Icons.bolt, color: Colors.pinkAccent, size: 16),
                  SizedBox(width: 4),
                  Text(
                    'BlinkMatch',
                    style: TextStyle(
                      color: Colors.white,
                      fontWeight: FontWeight.bold,
                      fontSize: 12,
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
