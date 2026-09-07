import 'package0package:flutter/material.dart';

class CreatePostScreen extends StatefulWidget {
  const CreatePostScreen({super.key});

  @override
  State<CreatePostScreen> createState() => _CreatePostScreenState();
}

class _CreatePostScreenState extends State<CreatePostScreen> {
  bool isFrontCamera = true;
  String selectedSpeed = '1.0x';
  String? selectedMusic;

  // Music Selection Dialog
  void _showMusicPicker(BuildContext context) {
    showModalBottomSheet(
      context: context,
      backgroundColor: Colors.grey[900],
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
      ),
      builder: (BuildContext context) {
        final songs = [
          'Trending Song 1 - Popular Artist',
          'Acoustic Chill Beats',
          'Viral TikTok Sound 2026',
          'Lofi Study Music',
          'Pop Hits Instrumental',
        ];

        return Padding(
          padding: const EdgeInsets.symmetric(vertical: 20, horizontal: 16),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Center(
                child: Container(
                  width: 40,
                  height: 4,
                  decoration: BoxDecoration(
                    color: Colors.grey[600],
                    borderRadius: BorderRadius.circular(2),
                  ),
                ),
              ),
              const SizedBox(height: 16),
              const Text(
                'Select Music / Sound',
                style: TextStyle(color: Colors.white, fontSize: 18, fontWeight: FontWeight.bold),
              ),
              const SizedBox(height: 12),
              Expanded(
                child: ListView.builder(
                  shrinkWrap: true,
                  itemCount: songs.length,
                  itemBuilder: (context, index) {
                    return ListTile(
                      leading: const Icon(Icons.music_note, color: Colors.pinkAccent),
                      title: Text(songs[index], style: const TextStyle(color: Colors.white)),
                      onTap: () {
                        setState(() {
                          selectedMusic = songs[index];
                        });
                        Navigator.pop(context);
                        ScaffoldMessenger.of(context).showSnackBar(
                          SnackBar(content: Text('Selected Music: ${songs[index]}')),
                        );
                      },
                    );
                  },
                ),
              ),
            ],
          ),
        );
      },
    );
  }

  // Gallery Picker Sheet
  void _showGalleryPicker(BuildContext context) {
    showModalBottomSheet(
      context: context,
      backgroundColor: Colors.grey[900],
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
      ),
      builder: (BuildContext context) {
        return Padding(
          padding: const EdgeInsets.all(20),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              const Text(
                'Upload Media',
                style: TextStyle(color: Colors.white, fontSize: 18, fontWeight: FontWeight.bold),
              ),
              const SizedBox(height: 20),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  GestureDetector(
                    onTap: () {
                      Navigator.pop(context);
                      ScaffoldMessenger.of(context).showSnackBar(
                        const SnackBar(content: Text('Photo Gallery Opened')),
                      );
                    },
                    child: Column(
                      children: const [
                        CircleAvatar(
                          radius: 30,
                          backgroundColor: Colors.pinkAccent,
                          child: Icon(Icons.photo_library, color: Colors.white, size: 28),
                        ),
                        SizedBox(height: 8),
                        Text('Select Photo', style: TextStyle(color: Colors.white)),
                      ],
                    ),
                  ),
                  GestureDetector(
                    onTap: () {
                      Navigator.pop(context);
                      ScaffoldMessenger.of(context).showSnackBar(
                        const SnackBar(content: Text('Video Gallery Opened')),
                      );
                    },
                    child: Column(
                      children: const [
                        CircleAvatar(
                          radius: 30,
                          backgroundColor: Colors.purple,
                          child: Icon(Icons.video_library, color: Colors.white, size: 28),
                        ),
                        SizedBox(height: 8),
                        Text('Select Video', style: TextStyle(color: Colors.white)),
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
      body: SafeArea(
        child: Stack(
          children: [
            // Camera Preview Placeholder
            Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const Icon(Icons.videocam_outlined, color: Colors.white38, size: 80),
                  const SizedBox(height: 12),
                  Text(
                    'Camera Preview (${isFrontCamera ? "Front" : "Back"})',
                    style: const TextStyle(color: Colors.white38, fontSize: 16),
                  ),
                  if (selectedMusic != null) ...[
                    const SizedBox(height: 12),
                    Container(
                      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
                      decoration: BoxDecoration(
                        color: Colors.pinkAccent.withOpacity(0.2),
                        borderRadius: BorderRadius.circular(15),
                        border: Border.all(color: Colors.pinkAccent),
                      ),
                      child: Row(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          const Icon(Icons.music_note, color: Colors.pinkAccent, size: 16),
                          const SizedBox(width: 6),
                          Text(
                            selectedMusic!,
                            style: const TextStyle(color: Colors.white, fontSize: 13),
                          ),
                        ],
                      ),
                    ),
                  ],
                ],
              ),
            ),

            // Top Control Bar (Close, Title, Next)
            Positioned(
              top: 16,
              left: 16,
              right: 16,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  IconButton(
                    icon: const Icon(Icons.close, color: Colors.white, size: 28),
                    onPressed: () {},
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
                        const SnackBar(content: Text('Proceeding to Post Edit...')),
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

            // Right Side Controls (Flip, Speed, Filters, Timer)
            Positioned(
              top: 80,
              right: 16,
              child: Column(
                children: [
                  _buildSideIconButton(
                    icon: Icons.flip_camera_android,
                    label: 'Flip',
                    onTap: () {
                      setState(() {
                        isFrontCamera = !isFrontCamera;
                      });
                    },
                  ),
                  const SizedBox(height: 20),
                  _buildSideIconButton(
                    icon: Icons.speed,
                    label: selectedSpeed,
                    onTap: () {
                      setState(() {
                        selectedSpeed = selectedSpeed == '1.0x' ? '2.0x' : '1.0x';
                      });
                    },
                  ),
                  const SizedBox(height: 20),
                  _buildSideIconButton(
                    icon: Icons.auto_awesome,
                    label: 'Filters',
                    onTap: () {
                      ScaffoldMessenger.of(context).showSnackBar(
                        const SnackBar(content: Text('Filter Panel Opened')),
                      );
                    },
                  ),
                  const SizedBox(height: 20),
                  _buildSideIconButton(
                    icon: Icons.timer,
                    label: 'Timer',
                    onTap: () {
                      ScaffoldMessenger.of(context).showSnackBar(
                        const SnackBar(content: Text('Timer Set to 3s')),
                      );
                    },
                  ),
                ],
              ),
            ),

            // Bottom Control Area (Gallery, Record Button, Music Selection)
            Positioned(
              bottom: 30,
              left: 0,
              right: 0,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  // Gallery Upload Button (ပုံ/ဗီဒီယို တင်ရန်)
                  GestureDetector(
                    onTap: () => _showGalleryPicker(context),
                    child: Container(
                      padding: const EdgeInsets.all(10),
                      decoration: BoxDecoration(
                        color: Colors.grey[850],
                        borderRadius: BorderRadius.circular(12),
                      ),
                      child: const Icon(Icons.photo_library, color: Colors.white, size: 28),
                    ),
                  ),

                  // Record Button
                  GestureDetector(
                    onTap: () {
                      ScaffoldMessenger.of(context).showSnackBar(
                        const SnackBar(content: Text('Recording Started...')),
                      );
                    },
                    child: Container(
                      height: 75,
                      width: 75,
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

                  // Music Selector Button (သီချင်းထည့်ရန်)
                  GestureDetector(
                    onTap: () => _showMusicPicker(context),
                    child: Container(
                      padding: const EdgeInsets.all(10),
                      decoration: BoxDecoration(
                        color: Colors.grey[850],
                        borderRadius: BorderRadius.circular(12),
                      ),
                      child: const Icon(Icons.music_note, color: Colors.white, size: 28),
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

  Widget _buildSideIconButton({
    required IconData icon,
    required String label,
    required VoidCallback onTap,
  }) {
    return GestureDetector(
      onTap: onTap,
      child: Column(
        children: [
          Icon(icon, color: Colors.white, size: 28),
          const SizedBox(height: 4),
          Text(
            label,
            style: const TextStyle(color: Colors.white, fontSize: 11),
          ),
        ],
      ),
    );
  }
}
