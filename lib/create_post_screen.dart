import 'package:flutter/material.dart';

class CreatePostScreen extends StatefulWidget {
  const CreatePostScreen({super.key});

  @override
  State<CreatePostScreen> createState() => _CreatePostScreenState();
}

class _CreatePostScreenState extends State<CreatePostScreen> {
  // State Variables
  bool isFrontCamera = true;
  double selectedSpeed = 1.0;
  bool isFilterOn = false;
  int timerSeconds = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      body: SafeArea(
        child: Stack(
          children: [
            // 1. Camera Preview Center Area
            Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Icon(
                    Icons.videocam_outlined,
                    size: 64,
                    color: isFilterOn ? Colors.pinkAccent : Colors.grey[700],
                  ),
                  const SizedBox(height: 16),
                  Text(
                   'Camera Preview (${isFrontCamera ? 'Front' : 'Back'})',
                   style: TextStyle(
                    color: Colors.grey[400],
                    fontSize: 16,
                    fontWeight: FontWeight.w500,
  ),
),

                  ),
                  if (timerSeconds > 0)
                    Padding(
                      padding: const EdgeInsets.only(top: 8.0),
                      child: Text(
                        'Timer set: ${timerSeconds}s',
                        style: const TextStyle(color: Colors.pinkAccent, fontSize: 13),
                      ),
                    ),
                ],
              ),
            ),

            // 2. Top Bar (Close and Next)
            Positioned(
              top: 16,
              left: 16,
              right: 16,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  IconButton(
                    icon: const Icon(Icons.close, color: Colors.white, size: 28),
                    onPressed: () => Navigator.maybePop(context),
                  ),
                  const Text(
                    'Create Post',
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  TextButton(
                    onPressed: () {
                      ScaffoldMessenger.of(context).showSnackBar(
                        const SnackBar(content: Text('Proceeding to next step...')),
                      );
                    },
                    child: const Text(
                      'Next',
                      style: TextStyle(
                        color: Colors.pinkAccent,
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                ],
              ),
            ),

            // 3. Right Side Control Panel (Flip, Speed, Filter, Timer)
            Positioned(
              top: 80,
              right: 16,
              child: Column(
                children: [
                  // Flip Button
                  _buildSideButton(
                    icon: Icons.flip_camera_ios,
                    label: 'Flip',
                    isActive: false,
                    onTap: () {
                      setState(() {
                        isFrontCamera = !isFrontCamera;
                      });
                      ScaffoldMessenger.of(context).showSnackBar(
                        SnackBar(
                          content: Text(
                            isFrontCamera ? 'Switched to Front Camera' : 'Switched to Back Camera',
                          ),
                          duration: const Duration(seconds: 1),
                        ),
                      );
                    },
                  ),
                  const SizedBox(height: 20),

                  // Speed Button
                  _buildSideButton(
                    icon: Icons.speed,
                    label: '${selectedSpeed}x',
                    isActive: selectedSpeed != 1.0,
                    onTap: () {
                      setState(() {
                        if (selectedSpeed == 1.0) {
                          selectedSpeed = 2.0;
                        } else if (selectedSpeed == 2.0) {
                          selectedSpeed = 0.5;
                        } else {
                          selectedSpeed = 1.0;
                        }
                      });
                    },
                  ),
                  const SizedBox(height: 20),

                  // Filters Button
                  _buildSideButton(
                    icon: Icons.auto_awesome,
                    label: 'Filters',
                    isActive: isFilterOn,
                    onTap: () {
                      setState(() {
                        isFilterOn = !isFilterOn;
                      });
                    },
                  ),
                  const SizedBox(height: 20),

                  // Timer Button
                  _buildSideButton(
                    icon: Icons.timer,
                    label: timerSeconds == 0 ? 'Timer' : '${timerSeconds}s',
                    isActive: timerSeconds > 0,
                    onTap: () {
                      setState(() {
                        if (timerSeconds == 0) {
                          timerSeconds = 3;
                        } else if (timerSeconds == 3) {
                          timerSeconds = 10;
                        } else {
                          timerSeconds = 0;
                        }
                      });
                    },
                  ),
                ],
              ),
            ),

            // 4. Bottom Controls Area (Gallery, Record, Music)
            Positioned(
              bottom: 30,
              left: 24,
              right: 24,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  // Gallery Button
                  IconButton(
                    iconSize: 40,
                    icon: Container(
                      padding: const EdgeInsets.all(8),
                      decoration: BoxDecoration(
                        color: Colors.grey[800],
                        borderRadius: BorderRadius.circular(12),
                      ),
                      child: const Icon(Icons.photo_library, color: Colors.white, size: 24),
                    ),
                    onPressed: () {
                      ScaffoldMessenger.of(context).showSnackBar(
                        const SnackBar(content: Text('Opening Gallery...')),
                      );
                    },
                  ),

                  // Record Button
                  GestureDetector(
                    onTap: () {
                      ScaffoldMessenger.of(context).showSnackBar(
                        SnackBar(
                          content: Text(
                            timerSeconds > 0
                                ? 'Recording starts in $timerSeconds seconds...'
                                : 'Recording started!',
                          ),
                        ),
                      );
                    },
                    child: Container(
                      width: 72,
                      height: 72,
                      padding: const EdgeInsets.all(4),
                      decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        border: Border.all(color: Colors.white, width: 4),
                      ),
                      child: Container(
                        decoration: const BoxDecoration(
                          color: Colors.pinkAccent,
                          shape: BoxShape.circle,
                        ),
                        child: const Icon(Icons.videocam, color: Colors.white, size: 32),
                      ),
                    ),
                  ),

                  // Music Button
                  IconButton(
                    iconSize: 40,
                    icon: Container(
                      padding: const EdgeInsets.all(8),
                      decoration: BoxDecoration(
                        color: Colors.grey[800],
                        borderRadius: BorderRadius.circular(12),
                      ),
                      child: const Icon(Icons.music_note, color: Colors.white, size: 24),
                    ),
                    onPressed: () {
                      ScaffoldMessenger.of(context).showSnackBar(
                        const SnackBar(content: Text('Select Sound/Music')),
                      );
                    },
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  // Side Control Button UI Helper
  Widget _buildSideButton({
    required IconData icon,
    required String label,
    required bool isActive,
    required VoidCallback onTap,
  }) {
    return GestureDetector(
      onTap: onTap,
      child: Column(
        children: [
          Icon(
            icon,
            color: isActive ? Colors.pinkAccent : Colors.white,
            size: 28,
          ),
          const SizedBox(height: 4),
          Text(
            label,
            style: TextStyle(
              color: isActive ? Colors.pinkAccent : Colors.white,
              fontSize: 12,
              fontWeight: FontWeight.w500,
            ),
          ),
        ],
      ),
    );
  }
}
