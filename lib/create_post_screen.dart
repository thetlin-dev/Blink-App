import 'package:flutter/material.dart';

class CreatePostScreen extends StatefulWidget {
  const CreatePostScreen({super.key});

  @override
  State<CreatePostScreen> createState() => _CreatePostScreenState();
}

class _CreatePostScreenState extends State<CreatePostScreen> {
  bool _isRecording = false;
  double _selectedSpeed = 1.0;
  final TextEditingController _captionController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      appBar: AppBar(
        backgroundColor: Colors.black,
        leading: IconButton(
          icon: const Icon(Icons.close, color: Colors.white),
          onPressed: () => Navigator.pop(context),
        ),
        title: const Text("Create Post", style: TextStyle(color: Colors.white)),
        centerTitle: true,
        actions: [
          TextButton(
            onPressed: () {
              // Upload Logic
            },
            child: const Text("Next", style: TextStyle(color: Colors.pinkAccent, fontWeight: FontWeight.bold, fontSize: 16)),
          ),
        ],
      ),
      body: Stack(
        children: [
          // Camera Preview Placeholder
          Container(
            width: double.infinity,
            height: double.infinity,
            color: Colors.grey[900],
            child: const Center(
              child: Icon(Icons.videocam_outlined, size: 80, color: Colors.white24),
            ),
          ),

          // Right Side Camera Controls
          Positioned(
            top: 20,
            right: 16,
            child: Column(
              children: [
                _buildControlIcon(Icons.flip_camera_ios, "Flip"),
                const SizedBox(height: 20),
                _buildControlIcon(Icons.speed, "${_selectedSpeed}x", onTap: () {
                  setState(() {
                    _selectedSpeed = _selectedSpeed == 1.0 ? 2.0 : 1.0;
                  });
                }),
                const SizedBox(height: 20),
                _buildControlIcon(Icons.auto_awesome, "Filters"),
                const SizedBox(height: 20),
                _buildControlIcon(Icons.timer, "Timer"),
              ],
            ),
          ),

          // Bottom Recording Button & Options
          Positioned(
            bottom: 30,
            left: 0,
            right: 0,
            child: Column(
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    IconButton(
                      icon: const Icon(Icons.photo_library, color: Colors.white, size: 32),
                      onPressed: () {},
                    ),
                    GestureDetector(
                      onTap: () {
                        setState(() {
                          _isRecording = !_isRecording;
                        });
                      },
                      child: CircleAvatar(
                        radius: 38,
                        backgroundColor: Colors.white,
                        child: CircleAvatar(
                          radius: 32,
                          backgroundColor: _isRecording ? Colors.red : Colors.pinkAccent,
                          child: Icon(
                            _isRecording ? Icons.stop : Icons.videocam,
                            color: Colors.white,
                            size: 30,
                          ),
                        ),
                      ),
                    ),
                    IconButton(
                      icon: const Icon(Icons.music_note, color: Colors.white, size: 32),
                      onPressed: () {},
                    ),
                  ],
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildControlIcon(IconData icon, String label, {VoidCallback? onTap}) {
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
