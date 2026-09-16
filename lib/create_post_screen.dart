import 'package:flutter/material.dart';

void main() {
  runApp(const MaterialApp(
    debugShowCheckedModeBanner: false,
    home: BlinkCameraScreen(),
  ));
}

class BlinkCameraScreen extends StatefulWidget {
  const BlinkCameraScreen({super.key});

  @override
  State<BlinkCameraScreen> createState() => _BlinkCameraScreenState();
}

class _BlinkCameraScreenState extends State<BlinkCameraScreen> with SingleTickerProviderStateMixin {
  int _selectedModeIndex = 0;
  final List<String> _modes = ["Recap Mode", "15s Sync", "60s Video", "Photo"];
  
  // States for Features
  bool _isRecording = false;
  bool _isDualLensActive = true; // 3. Dual-Lens Split View
  bool _isARFilterActive = false; // 5. AR Scene-Split Effects
  bool _isBeatSyncActive = false; // 6. Beat-Sync Auto Cut
  
  late AnimationController _waveController;

  @override
  void initState() {
    super.initState();
    // 2. Blink Radial Shutter - Neon Wave Animation
    _waveController = AnimationController(
      vsync: this,
      duration: const Duration(seconds: 1),
    )..repeat(reverse: true);
  }

  @override
  void dispose() {
    _waveController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFF121212),
      body: SafeArea(
        child: Stack(
          children: [
            // 5. AR Scene-Split Effects Background Representation
            AnimatedContainer(
              duration: const Duration(milliseconds: 300),
              decoration: BoxDecoration(
                gradient: _isARFilterActive
                    ? const LinearGradient(
                        colors: [Colors.purple, Colors.deepPink, Colors.black],
                        begin: Alignment.topLeft,
                        end: Alignment.bottomRight,
                      )
                    : null,
                color: _isARFilterActive ? null : const Color(0xFF1C1C1E),
              ),
              child: Center(
                child: Text(
                  _isARFilterActive ? "AI Dynamic 3D Environment Active" : "Camera Live View",
                  style: const TextStyle(color: Colors.white54, fontSize: 16),
                ),
              ),
            ),

            // 3. Dual-Lens Split View (Dynamic Island Floating Preview)
            if (_isDualLensActive)
              Positioned(
                top: 70,
                left: 20,
                child: Container(
                  width: 110,
                  height: 150,
                  decoration: BoxDecoration(
                    color: Colors.black80,
                    borderRadius: BorderRadius.circular(20),
                    border: Border.all(color: const Color(0xFFFF2B57), width: 1.5),
                    boxShadow: const [BoxShadow(color: Colors.black54, blurRadius: 10)],
                  ),
                  child: const Center(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Icon(Icons.person, color: Colors.white, size: 30),
                        SizedBox(height: 4),
                        Text("Front Cam", style: TextStyle(color: Colors.white, fontSize: 10)),
                      ],
                    ),
                  ),
                ),
              ),

            // 4. AI Smart Recap Script Anchor (Teleprompter Overlay)
            if (_selectedModeIndex == 0) // When Recap Mode is selected
              Positioned(
                top: 80,
                left: 140,
                right: 20,
                child: Container(
                  padding: const EdgeInsets.all(12),
                  decoration: BoxDecoration(
                    color: Colors.black.withOpacity(0.65),
                    borderRadius: BorderRadius.circular(12),
                  ),
                  child: const Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        children: [
                          Icon(Icons.remove_red_eye, color: Colors.cyanAccent, size: 16),
                          SizedBox(width: 6),
                          Text(
                            "AI Eye-Contact Script",
                            style: TextStyle(color: Colors.cyanAccent, fontSize: 11, fontWeight: FontWeight.bold),
                          ),
                        ],
                      ),
                      SizedBox(height: 6),
                      Text(
                        "Welcome to today's video! Today we are testing the new Blink AI Camera system...",
                        style: TextStyle(color: Colors.white, fontSize: 13, height: 1.3),
                        maxLines: 3,
                        overflow: TextOverflow.ellipsis,
                      ),
                    ],
                  ),
                ),
              ),

            // Top Control Bar & 6. Beat-Sync Auto Cut
            Positioned(
              top: 16,
              left: 16,
              right: 16,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  const Icon(Icons.close, color: Colors.white, size: 28),
                  
                  // 6. Beat-Sync Button
                  GestureDetector(
                    onTap: () {
                      setState(() {
                        _isBeatSyncActive = !_isBeatSyncActive;
                      });
                    },
                    child: Container(
                      padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 8),
                      decoration: BoxDecoration(
                        color: _isBeatSyncActive ? const Color(0xFFFF2B57) : Colors.black45,
                        borderRadius: BorderRadius.circular(20),
                        border: Border.all(color: const Color(0xFFFF2B57), width: 1.5),
                      ),
                      child: Row(
                        children: [
                          Icon(Icons.music_note, color: _isBeatSyncActive ? Colors.white : const Color(0xFFFF2B57), size: 16),
                          const SizedBox(width: 6),
                          Text(
                            _isBeatSyncActive ? "Beat-Sync Active" : "Add Beat-Sync Sound",
                            style: const TextStyle(color: Colors.white, fontSize: 13, fontWeight: FontWeight.bold),
                          ),
                        ],
                      ),
                    ),
                  ),

                  IconButton(
                    icon: Icon(_isDualLensActive ? Icons.flip_to_front : Icons.camera_rear, color: Colors.white),
                    onPressed: () {
                      setState(() {
                        _isDualLensActive = !_isDualLensActive;
                      });
                    },
                  ),
                ],
              ),
            ),

            // Bottom Area with Shutter, Mode Bar & 1. Orbital Floating Actions Wheel
            Positioned(
              bottom: 30,
              left: 0,
              right: 0,
              child: Column(
                children: [
                  // Mode Selector
                  SingleChildScrollView(
                    scrollDirection: Axis.horizontal,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: List.generate(_modes.length, (index) {
                        final isSelected = _selectedModeIndex == index;
                        return GestureDetector(
                          onTap: () => setState(() => _selectedModeIndex = index),
                          child: Padding(
                            padding: const EdgeInsets.symmetric(horizontal: 12),
                            child: Text(
                              _modes[index],
                              style: TextStyle(
                                color: isSelected ? const Color(0xFFFF2B57) : Colors.grey,
                                fontWeight: isSelected ? FontWeight.bold : FontWeight.normal,
                                fontSize: 14,
                              ),
                            ),
                          ),
                        );
                      }),
                    ),
                  ),
                  const SizedBox(height: 30),

                  // Shutter and Arc Floating Actions
                  SizedBox(
                    height: 120,
                    width: double.infinity,
                    child: Stack(
                      alignment: Alignment.center,
                      children: [
                        // 1. Orbital Floating Actions Wheel (Arc-shaped Floating Bubbles)
                        Positioned(
                          left: 45,
                          bottom: 50,
                          child: _buildOrbitalBubble(Icons.auto_awesome, "AR Split", _isARFilterActive, () {
                            setState(() => _isARFilterActive = !_isARFilterActive);
                          }),
                        ),
                        Positioned(
                          right: 45,
                          bottom: 50,
                          child: _buildOrbitalBubble(Icons.subtitles, "Script", false, () {}),
                        ),

                        // 2. Blink Radial Shutter with Neon Wave Pulse
                        GestureDetector(
                          onTap: () {
                            setState(() => _isRecording = !_isRecording);
                          },
                          child: AnimatedBuilder(
                            animation: _waveController,
                            builder: (context, child) {
                              return Container(
                                width: 84,
                                height: 84,
                                decoration: BoxDecoration(
                                  shape: BoxShape.circle,
                                  boxShadow: _isRecording
                                      ? [
                                          BoxShadow(
                                            color: const Color(0xFFFF2B57).withOpacity(0.8),
                                            blurRadius: 15 * _waveController.value + 5,
                                            spreadRadius: 8 * _waveController.value + 2,
                                          )
                                        ]
                                      : [],
                                  gradient: const LinearGradient(
                                    colors: [Color(0xFFFF2B57), Color(0xFFFF7B00)],
                                  ),
                                ),
                                child: Padding(
                                  padding: const EdgeInsets.all(4.0),
                                  child: Container(
                                    decoration: const BoxDecoration(
                                      shape: BoxShape.circle,
                                      color: Colors.white,
                                    ),
                                    child: _isRecording
                                        ? const Center(
                                            child: Icon(Icons.stop, color: Color(0xFFFF2B57), size: 36),
                                          )
                                        : null,
                                  ),
                                ),
                              );
                            },
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  // Helper method to create Orbital Floating Bubbles
  Widget _buildOrbitalBubble(IconData icon, String label, bool isActive, VoidCallback onTap) {
    return GestureDetector(
      onTap: onTap,
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Container(
            padding: const EdgeInsets.all(10),
            decoration: BoxDecoration(
              color: isActive ? const Color(0xFFFF2B57) : Colors.black54,
              shape: BoxShape.circle,
              border: Border.all(color: Colors.white30, width: 1),
              boxShadow: const [BoxShadow(color: Colors.black26, blurRadius: 6)],
            ),
            child: Icon(icon, color: Colors.white, size: 20),
          ),
          const SizedBox(height: 4),
          Text(label, style: const TextStyle(color: Colors.white70, fontSize: 10)),
        ],
      ),
    );
  }
}
