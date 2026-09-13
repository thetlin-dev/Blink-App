import 'package:flutter/material.dart';

class CameraScreen extends StatefulWidget {
  const CameraScreen({super.key});

  @override
  State<CameraScreen> createState() => _CameraScreenState();
}

class _CameraScreenState extends State<CameraScreen> with TickerProviderStateMixin {
  // Mode & Toggle States
  String selectedMode = 'Recap Mode';
  bool isRecording = false;
  bool isDualCam = false;
  bool isTeleprompterOpen = false;
  bool isARFilterActive = false;
  bool isBeatSyncActive = false;

  // Teleprompter Script State
  final TextEditingController _scriptController = TextEditingController(
    text: "Welcome to today's movie recap! In this scene, the main character discovers...",
  );

  // Animation Controllers for Neon Pulse Shutter
  late AnimationController _pulseController;
  late Animation<double> _pulseAnimation;

  @override
  void initState() {
    super.initState();
    _pulseController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 1000),
    );
    _pulseAnimation = Tween<double>(begin: 1.0, end: 1.25).animate(
      CurvedAnimation(parent: _pulseController, curve: Curves.easeInOut),
    );
  }

  @override
  void dispose() {
    _pulseController.dispose();
    _scriptController.dispose();
    super.dispose();
  }

  void _toggleRecording() {
    setState(() {
      isRecording = !isRecording;
      if (isRecording) {
        _pulseController.repeat(reverse: true);
      } else {
        _pulseController.stop();
        _pulseController.reset();
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      body: Stack(
        children: [
          // 1. Camera Preview & AR Filter Visual Effect
          AnimatedContainer(
            duration: const Duration(milliseconds: 500),
            color: isARFilterActive ? Colors.deepPurple[900] : Colors.grey[900],
            child: Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Icon(
                    isDualCam ? Icons.flip_camera_ios : Icons.camera_rear,
                    size: 70,
                    color: isARFilterActive ? Colors.cyanAccent : Colors.white24,
                  ),
                  const SizedBox(height: 12),
                  Text(
                    isDualCam
                        ? "Dual-Lens Split View Active"
                        : (isARFilterActive ? "AI Dynamic 3D Environment Active" : "Blink AI Camera Active"),
                    style: TextStyle(
                      color: isARFilterActive ? Colors.cyanAccent : Colors.white54,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ],
              ),
            ),
          ),

          // Dual Cam Overlay Pip View
          if (isDualCam)
            Positioned(
              top: 100,
              left: 20,
              child: Container(
                width: 100,
                height: 140,
                decoration: BoxDecoration(
                  color: Colors.black87,
                  borderRadius: BorderRadius.circular(16),
                  border: Border.all(color: Colors.pinkAccent, width: 2),
                ),
                child: const Center(
                  child: Icon(Icons.person, color: Colors.white70, size: 40),
                ),
              ),
            ),

          // 2. AI Teleprompter Floating Overlay
          if (isTeleprompterOpen)
            Positioned(
              top: 120,
              left: 30,
              right: 30,
              child: Container(
                padding: const EdgeInsets.all(12),
                decoration: BoxDecoration(
                  color: Colors.black.withOpacity(0.75),
                  borderRadius: BorderRadius.circular(16),
                  border: Border.all(color: Colors.pinkAccent.withOpacity(0.5)),
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        const Row(
                          children: [
                            Icon(Icons.remove_red_eye, color: Colors.greenAccent, size: 16),
                            SizedBox(width: 6),
                            Text(
                              "AI Eye-Contact Auto Correcting...",
                              style: TextStyle(color: Colors.greenAccent, fontSize: 11, fontWeight: FontWeight.bold),
                            ),
                          ],
                        ),
                        GestureDetector(
                          onTap: () => setState(() => isTeleprompterOpen = false),
                          child: const Icon(Icons.close, color: Colors.white, size: 18),
                        ),
                      ],
                    ),
                    const SizedBox(height: 8),
                    TextField(
                      controller: _scriptController,
                      maxLines: 3,
                      style: const TextStyle(color: Colors.white, fontSize: 13),
                      decoration: const InputDecoration(
                        border: InputBorder.none,
                        hintText: "Enter your script...",
                        hintStyle: TextStyle(color: Colors.white38),
                      ),
                    ),
                  ],
                ),
              ),
            ),

          // 3. Top Control Bar
          Positioned(
            top: 50,
            left: 16,
            right: 16,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                IconButton(
                  icon: const Icon(Icons.close, color: Colors.white, size: 28),
                  onPressed: () => Navigator.pop(context),
                ),
                // Music Beat-Sync Pill
                GestureDetector(
                  onTap: () => setState(() => isBeatSyncActive = !isBeatSyncActive),
                  child: AnimatedContainer(
                    duration: const Duration(milliseconds: 300),
                    padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                    decoration: BoxDecoration(
                      color: isBeatSyncActive ? Colors.pinkAccent : Colors.black54,
                      borderRadius: BorderRadius.circular(20),
                      border: Border.all(color: Colors.pinkAccent),
                    ),
                    child: Row(
                      children: [
                        Icon(Icons.music_note, color: isBeatSyncActive ? Colors.white : Colors.pinkAccent, size: 18),
                        const SizedBox(width: 6),
                        Text(
                          isBeatSyncActive ? "Beat-Sync Active" : "Add Beat-Sync Sound",
                          style: const TextStyle(color: Colors.white, fontSize: 12, fontWeight: FontWeight.bold),
                        ),
                      ],
                    ),
                  ),
                ),
                IconButton(
                  icon: const Icon(Icons.flash_on, color: Colors.amber, size: 24),
                  onPressed: () {},
                ),
              ],
            ),
          ),

          // 4. Orbital Floating Actions (Right Side Tools)
          Positioned(
            right: 16,
            top: 140,
            child: Column(
              children: [
                _buildOrbitalButton(
                  icon: Icons.flip_camera_android,
                  label: "Dual Cam",
                  isActive: isDualCam,
                  onTap: () => setState(() => isDualCam = !isDualCam),
                ),
                const SizedBox(height: 16),
                _buildOrbitalButton(
                  icon: Icons.subtitles,
                  label: "Script",
                  isActive: isTeleprompterOpen,
                  onTap: () => setState(() => isTeleprompterOpen = !isTeleprompterOpen),
                ),
                const SizedBox(height: 16),
                _buildOrbitalButton(
                  icon: Icons.auto_awesome,
                  label: "AR Split",
                  isActive: isARFilterActive,
                  onTap: () => setState(() => isARFilterActive = !isARFilterActive),
                ),
                const SizedBox(height: 16),
                _buildOrbitalButton(
                  icon: Icons.center_focus_weak,
                  label: "Beat Cut",
                  isActive: isBeatSyncActive,
                  onTap: () => setState(() => isBeatSyncActive = !isBeatSyncActive),
                ),
              ],
            ),
          ),

          // 5. Bottom Mode Selector & Neon Radial Shutter
          Positioned(
            bottom: 30,
            left: 0,
            right: 0,
            child: Column(
              children: [
                // Mode Horizontal Selector
                SingleChildScrollView(
                  scrollDirection: Axis.horizontal,
                  child: Row(
                    children: ['Recap Mode', '15s Sync', '60s Video', 'Photo'].map((mode) {
                      bool isSelected = selectedMode == mode;
                      return GestureDetector(
                        onTap: () => setState(() => selectedMode = mode),
                        child: Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 6),
                          child: Text(
                            mode,
                            style: TextStyle(
                              color: isSelected ? Colors.pinkAccent : Colors.white54,
                              fontWeight: isSelected ? FontWeight.bold : FontWeight.normal,
                              fontSize: 13,
                            ),
                          ),
                        ),
                      );
                    }).toList(),
                  ),
                ),
                const SizedBox(height: 18),

                // Shutter & Quick Gallery Row
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    // Upload Gallery Option
                    Container(
                      width: 46,
                      height: 46,
                      decoration: BoxDecoration(
                        color: Colors.white12,
                        borderRadius: BorderRadius.circular(14),
                        border: Border.all(color: Colors.white30),
                      ),
                      child: const Icon(Icons.photo_library, color: Colors.white),
                    ),

                    // Neon Pulse Radial Shutter Button
                    GestureDetector(
                      onTap: _toggleRecording,
                      child: ScaleTransition(
                        scale: _pulseAnimation,
                        child: AnimatedContainer(
                          duration: const Duration(milliseconds: 300),
                          width: 82,
                          height: 82,
                          padding: const EdgeInsets.all(6),
                          decoration: BoxDecoration(
                            shape: BoxShape.circle,
                            border: Border.all(
                              color: isRecording ? Colors.redAccent : Colors.pinkAccent,
                              width: 4,
                            ),
                            boxShadow: [
                              BoxShadow(
                                color: (isRecording ? Colors.redAccent : Colors.pinkAccent).withOpacity(0.6),
                                blurRadius: isRecording ? 25 : 12,
                                spreadRadius: isRecording ? 4 : 1,
                              ),
                            ],
                          ),
                          child: Container(
                            decoration: BoxDecoration(
                              color: isRecording ? Colors.redAccent : Colors.white,
                              shape: isRecording ? BoxShape.rectangle : BoxShape.circle,
                              borderRadius: isRecording ? BorderRadius.circular(10) : null,
                            ),
                          ),
                        ),
                      ),
                    ),

                    // Effects Library Button
                    Container(
                      width: 46,
                      height: 46,
                      decoration: BoxDecoration(
                        color: Colors.pinkAccent.withOpacity(0.2),
                        shape: BoxShape.circle,
                        border: Border.all(color: Colors.pinkAccent),
                      ),
                      child: const Icon(Icons.auto_fix_high, color: Colors.pinkAccent),
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

  Widget _buildOrbitalButton({
    required IconData icon,
    required String label,
    bool isActive = false,
    required VoidCallback onTap,
  }) {
    return GestureDetector(
      onTap: onTap,
      child: Column(
        children: [
          AnimatedContainer(
            duration: const Duration(milliseconds: 250),
            padding: const EdgeInsets.all(10),
            decoration: BoxDecoration(
              color: isActive ? Colors.pinkAccent : Colors.black54,
              shape: BoxShape.circle,
              border: Border.all(color: isActive ? Colors.white : Colors.white24),
              boxShadow: isActive
                  ? [BoxShadow(color: Colors.pinkAccent.withOpacity(0.5), blurRadius: 10)]
                  : [],
            ),
            child: Icon(icon, color: Colors.white, size: 20),
          ),
          const SizedBox(height: 4),
          Text(
            label,
            style: TextStyle(
              color: isActive ? Colors.pinkAccent : Colors.white70,
              fontSize: 10,
              fontWeight: isActive ? FontWeight.bold : FontWeight.normal,
            ),
          ),
        ],
      ),
    );
  }
}
