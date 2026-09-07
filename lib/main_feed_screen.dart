import 'package:flutter/material.dart';

class MainFeedScreen extends StatefulWidget {
  const MainFeedScreen({super.key});

  @override
  State<MainFeedScreen> createState() => _MainFeedScreenState();
}

class _MainFeedScreenState extends State<MainFeedScreen> {
  final PageController _pageController = PageController();

  void _showMatchDialog() {
    showModalBottomSheet(
      context: context,
      backgroundColor: Colors.grey[900],
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
      ),
      builder: (context) {
        return Container(
          padding: const EdgeInsets.all(24),
          height: 250,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const Icon(Icons.bolt, color: Color(0xFFFF2C55), size: 48),
              const SizedBox(height: 12),
              const Text(
                'Blink Match Active!',
                style: TextStyle(color: Colors.white, fontSize: 20, fontWeight: FontWeight.bold),
              ),
              const SizedBox(height: 8),
              const Text(
                'Connecting you with another viewer for 30s reaction...',
                textAlign: TextAlign.center,
                style: TextStyle(color: Colors.white70),
              ),
              const SizedBox(height: 16),
              ElevatedButton(
                style: ElevatedButton.styleFrom(backgroundColor: const Color(0xFFFF2C55)),
                onPressed: () => Navigator.pop(context),
                child: const Text('Start Vibing', style: TextStyle(color: Colors.white)),
              )
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
      body: PageView.builder(
        scrollDirection: Axis.vertical, // အပေါ်အောက် ဆွဲသည့် စနစ်
        controller: _pageController,
        itemCount: 10,
        itemBuilder: (context, index) {
          return Stack(
            children: [
              Center(
                child: Text(
                  'Vertical Video Feed #${index + 1}',
                  style: const TextStyle(color: Colors.white54, fontSize: 18),
                ),
              ),

              // Blink Match (Quick Vibing) Button
              Positioned(
                top: 50,
                right: 16,
                child: GestureDetector(
                  onTap: _showMatchDialog,
                  child: Container(
                    padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
                    decoration: BoxDecoration(
                      color: const Color(0xFFFF2C55),
                      borderRadius: BorderRadius.circular(20),
                      boxShadow: [
                        BoxShadow(
                          color: const Color(0xFFFF2C55).withOpacity(0.6),
                          blurRadius: 8,
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
                          style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold, fontSize: 12),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ],
          );
        },
      ),
    );
  }
}
