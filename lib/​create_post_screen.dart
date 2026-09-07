import 'package:flutter/material.dart';

class CreatePostScreen extends StatefulWidget {
  const CreatePostScreen({super.key});

  @override
  State<CreatePostScreen> createState() => _CreatePostScreenState();
}

class _CreatePostScreenState extends State<CreatePostScreen> {
  bool _isRecording = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      body: Stack(
        children: [
          // Camera Viewfinder Placeholder
          Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Icon(
                  Icons.camera_alt_outlined,
                  size: 80,
                  color: Colors.white.withOpacity(0.3),
                ),
                const SizedBox(height: 12),
                const Text(
                  'Camera Viewfinder',
                  style: TextStyle(color: Colors.white38, fontSize: 16),
                ),
              ],
            ),
          ),

          // Top Bar (Close & Sound Selection)
          Positioned(
            top: 50,
            left: 16,
            right: 16,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                IconButton(
                  icon: const Icon(Icons.close, color: Colors.white, size: 28),
                  onPressed: () {},
                ),
                Container(
                  padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 6),
                  decoration: BoxDecoration(
                    color: Colors.black54,
                    borderRadius: BorderRadius.circular(20),
                  ),
                  child: const Row(
                    children: [
                      Icon(Icons.music_note, color: Colors.white, size: 16),
                      SizedBox(width: 6),
                      Text(
                        'Add Sound',
                        style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold, fontSize: 13),
                      ),
                    ],
                  ),
                ),
                const SizedBox(width: 28),
              ],
            ),
          ),

          // Right Toolbar (Camera Controls & AR Effects)
          Positioned(
            top: 100,
            right: 16,
            child: Column(
              children: [
                _buildIconButton(Icons.flip_camera_ios, 'Flip'),
                const SizedBox(height: 20),
                _buildIconButton(Icons.flash_on, 'Flash'),
                const SizedBox(height: 20),
                _buildIconButton(Icons.timer, 'Timer'),
                const SizedBox(height: 20),
                _buildIconButton(Icons.auto_awesome, 'Effects'),
                const SizedBox(height: 20),
                _buildIconButton(Icons.draw, 'Canvas'),
              ],
            ),
          ),

          // Bottom Record Button Section
          Positioned(
            bottom: 40,
            left: 0,
            right: 0,
            child: Column(
              children: [
                GestureDetector(
                  onTap: () {
                    setState(() {
                      _isRecording = !_isRecording;
                    });
                  },
                  child: Container(
                    padding: const EdgeInsets.all(6),
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      border: Border.all(color: Colors.white, width: 4),
                    ),
                    child: Container(
                      width: 65,
                      height: 65,
                      decoration: BoxDecoration(
                        color: _isRecording ? Colors.red : const Color(0xFFFF2C55),
                        shape: _isRecording ? BoxShape.rectangle : BoxShape.circle,
                        borderRadius: _isRecording ? BorderRadius.circular(8) : null,
                      ),
                    ),
                  ),
                ),
                const SizedBox(height: 12),
                Text(
                  _isRecording ? 'Recording...' : 'Tap to Record',
                  style: const TextStyle(color: Colors.white, fontSize: 13, fontWeight: FontWeight.w500),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildIconButton(IconData icon, String label) {
    return Column(
      children: [
        Icon(icon, color: Colors.white, size: 26),
        const SizedBox(height: 4),
        Text(
          label,
          style: const TextStyle(color: Colors.white, fontSize: 11),
        ),
      ],
    );
  }
}
