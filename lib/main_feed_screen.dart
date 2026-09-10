import 'package:flutter/material.dart';

class MainFeedScreen extends StatelessWidget {
  const MainFeedScreen({super.key});

  // Share & Copy Link Dialog/BottomSheet ပြသပေးသည့် Function
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
                  // Copy Link Option
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
                          child: const Icon(Icons.link_rounded, color: Colors.white, size: 28),
                        ),
                        const SizedBox(height: 8),
                        const Text('Copy Link', style: TextStyle(color: Colors.white, fontSize: 12)),
                      ],
                    ),
                  ),

                  // Share Option
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
          // Video Feed Placeholder
          PageView.builder(
      itemBuilder: (context, index) {
        return Stack(
          fit: StackFit.expand,
          children: [
            // Center Text
            Center(
              child: Text(
                'Vertical Video Feed #${index + 1}',
                style: const TextStyle(color: Colors.white, fontSize: 18),
              ),
            ),

            // Right Action Buttons (like, Comment, Share)
            Positioned(
              right: 12,
              bottom: 100,
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  // Profile Avatar
                  Container(
                    padding: const EdgeInsets.all(2),
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      border: Border.all(color: Colors.white, width: 2),
                    ),
                    child: const CircleAvatar(
                      radius: 27,
                      backgroundColor: Colors.grey,
                      child: Icon(Icons.person, color: Colors.white),
                    ),
                  ),
                  const SizedBox(height: 20),
                  // Like / Heart Button
                  _buildActionButton(
                    icon: Icons.favorite,
                    label: '12.5k',
                    color: Colors.redAccent,
                    onTap: () {},
                  ),
                ],
              ),
            ),
          ),
            // Bottom Content & Horizontal Action Buttons (Profile, Like, Comment, Share)
            Positioned(
              left: 16,
              right: 16,
              bottom: 20,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text(
                    '@thetlin_dev',
                    style: TextStyle(
                      color: Colors.white,
                      fontWeight: FontWeight.bold,
                      fontSize: 16,
                    ),
                  ),
                  const SizedBox(height: 6),
                  const Text(
                    'Blink App UI Demo Video Feed ✨ #Flutter #BlinkApp',
                    style: TextStyle(color: Colors.white70, fontSize: 14),
                  ),
                  const SizedBox(height: 12),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      // Profile Avatar
                      Container(
                        padding: const EdgeInsets.all(2),
                        decoration: const BoxDecoration(
                          color: Colors.white,
                          shape: BoxShape.circle,
                        ),
                        child: const CircleAvatar(
                          radius: 18,
                          backgroundColor: Colors.grey,
                          child: Icon(Icons.person, color: Colors.white, size: 20),
                        ),
                      ),
                      const SizedBox(width: 16),

                      // Like Button
                      GestureDetector(
                        onTap: () {},
                        child: Row(
                          children: const [
                            Icon(Icons.favorite, color: Colors.redAccent, size: 24),
                            SizedBox(width: 4),
                            Text('12.5k', style: TextStyle(color: Colors.white, fontSize: 13)),
                          ],
                        ),
                      ),
                      const SizedBox(width: 16),

                      // Comment Button
                      GestureDetector(
                        onTap: () {},
                        child: Row(
                          children: const [
                            Icon(Icons.chat_bubble_rounded, color: Colors.white, size: 22),
                            SizedBox(width: 4),
                            Text('1.2k', style: TextStyle(color: Colors.white, fontSize: 13)),
                          ],
                        ),
                      ),
                      const SizedBox(width: 16),

                      // Share Button
                      GestureDetector(
                        onTap: () => _showShareOptions(context),
                        onLongPress: () => _showShareOptions(context),
                        child: Row(
                          children: const [
                            Icon(Icons.share_rounded, color: Colors.white, size: 22),
                            SizedBox(width: 4),
                            Text('1.2k', style: TextStyle(color: Colors.white, fontSize: 13)),
                          ],
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),

            },
          ),

          // Top Blink Match Button
          Positioned(
            top: 45,
            right: 16,
            child: Container(
              padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 8),
              decoration: BoxDecoration(
                color: Colors.pinkAccent,
                borderRadius: BorderRadius.circular(20),
                boxShadow: [
                  BoxShadow(
                    color: Colors.pinkAccent.withOpacity(0.6),
                    blurRadius: 10,
                    spreadRadius: 2,
                  ),
                ],
              ),
              child: const Row(
                children: [
                  Icon(Icons.bolt, color: Colors.white, size: 18),
                  SizedBox(width: 4),
                  Text(
                    'Blink Match',
                    style: TextStyle(
                      color: Colors.white,
                      fontWeight: FontWeight.bold,
                      fontSize: 13,
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

  static Widget _buildActionButton({
    required IconData icon,
    required String label,
    required Color color,
    required VoidCallback onTap,
    VoidCallback? onLongPress,
  }) {
    return GestureDetector(
      onTap: onTap,
      onLongPress: onLongPress,
      child: Column(
        children: [
          Icon(icon, color: color, size: 32),
          const SizedBox(height: 4),
          Text(
            label,
            style: const TextStyle(
              color: Colors.white,
              fontSize: 12,
              fontWeight: FontWeight.w600,
            ),
          ),
        ],
      ),
    );
  }
}
