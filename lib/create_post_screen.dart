import 'package:flutter/material.dart';

class CreatePostScreen extends StatefulWidget {
  const CreatePostScreen({super.key});

  @override
  State<CreatePostScreen> createState() => _CreatePostScreenState();
}

class _CreatePostScreenState extends State<CreatePostScreen> {
  bool isFrontCamera = true;
  double speed = 1.0;
  bool isTimerActive = false;

  void _showToast(String message) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(message),
        duration: const Duration(seconds: 1),
        behavior: SnackBarBehavior.floating,
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      body: SafeArea(
        child: Stack(
          children: [
            // Preview / Camera Area
            Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Icon(
                    Icons.videocam_outlined,
                    size: 80,
                    color: Colors.white.withOpacity(0.3),
                  ),
                  const SizedBox(height: 12),
                  Text(
                    'Camera Preview (${isFrontCamera ? "Front" : "Back"})',
                    style: TextStyle(color: Colors.white.withOpacity(0.5)),
                  ),
                ],
              ),
            ),

            // Top Bar Controls
            Positioned(
              top: 16,
              left: 16,
              right: 16,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  IconButton(
                    icon: const Icon(Icons.close, color: Colors.white, size: 28),
                    onPressed: () => _showToast("Close pressed"),
                  ),
                  const Text(
                    'Create Post',
                    style: TextStyle(color: Colors.white, fontSize: 18, fontWeight: FontWeight.bold),
                  ),
                  TextButton(
                    onPressed: () => _showToast("Next pressed"),
                    child: const Text(
                      'Next',
                      style: TextStyle(color: Color(0xFFFF2C55), fontSize: 16, fontWeight: FontWeight.bold),
                    ),
                  ),
                ],
              ),
            ),

            // Right Action Column
            Positioned(
              right: 16,
              top: 80,
              child: Column(
                children: [
                  _buildSideButton(
                    icon: Icons.flip_camera_ios,
                    label: 'Flip',
                    onTap: () {
                      setState(() => isFrontCamera = !isFrontCamera);
                      _showToast('Switched to ${isFrontCamera ? "Front" : "Back"} camera');
                    },
                  ),
                  const SizedBox(height: 20),
                  _buildSideButton(
                    icon: Icons.speed,
                    label: '${speed}x',
                    onTap: () {
                      setState(() {
                        if (speed == 1.0) speed = 2.0;
                        else if (speed == 2.0) speed = 0.5;
                        else speed = 1.0;
                      });
                      _showToast('Speed set to ${speed}x');
                    },
                  ),
                  const SizedBox(height: 20),
                  _buildSideButton(
                    icon: Icons.auto_awesome,
                    label: 'Filters',
                    onTap: () => _showToast('Filters opened'),
                  ),
                  const SizedBox(height: 20),
                  _buildSideButton(
                    icon: Icons.timer,
                    label: 'Timer',
                    onTap: () {
                      setState(() => isTimerActive = !isTimerActive);
                      _showToast(isTimerActive ? 'Timer enabled (3s)' : 'Timer disabled');
                    },
                  ),
                ],
              ),
            ),

            // Bottom Controls
            Positioned(
              bottom: 30,
              left: 0,
              right: 0,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  IconButton(
                    icon: const Icon(Icons.photo_library, color: Colors.white, size: 32),
                    onPressed: () => _showToast('Gallery opened'),
                  ),
                  GestureDetector(
                    onTap: () => _showToast('Recording started...'),
                    child: Container(
                      padding: const EdgeInsets.all(4),
                      decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        border: Border.all(color: Colors.white, width: 4),
                      ),
                      child: Container(
                        width: 65,
                        height: 65,
                        decoration: const BoxDecoration(
                          color: Color(0xFFFF2C55),
                          shape: BoxShape.circle,
                        ),
                        child: const Icon(Icons.videocam, color: Colors.white, size: 32),
                      ),
                    ),
                  ),
                  IconButton(
                    icon: const Icon(Icons.music_note, color: Colors.white, size: 32),
                    onPressed: () => _showToast('Music selector opened'),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildSideButton({required IconData icon, required String label, required VoidCallback onTap}) {
    return GestureDetector(
      onTap: onTap,
      child: Column(
        children: [
          Icon(icon, color: Colors.white, size: 28),
          const SizedBox(height: 4),
          Text(label, style: const TextStyle(color: Colors.white, fontSize: 12)),
        ],
      ),
    );
  }
}
