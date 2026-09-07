import 'package:flutter/material.dart';

class AudioPlayerOverlay extends StatelessWidget {
  const AudioPlayerOverlay({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.black.withOpacity(0.85),
      child: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const CircleAvatar(
              radius: 60,
              backgroundColor: Colors.greenAccent,
              child: Icon(Icons.music_note, size: 60, color: Colors.black),
            ),
            const SizedBox(height: 24),
            const Text(
              "Podcast / Audio Mode",
              style: TextStyle(color: Colors.white, fontSize: 20, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 8),
            const Text(
              "Background Playback Active",
              style: TextStyle(color: Colors.white54, fontSize: 14),
            ),
            const SizedBox(height: 30),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                IconButton(
                  iconSize: 36,
                  icon: const Icon(Icons.replay_10, color: Colors.white),
                  onPressed: () {},
                ),
                const SizedBox(width: 20),
                IconButton(
                  iconSize: 48,
                  icon: const Icon(Icons.pause_circle_filled, color: Colors.greenAccent),
                  onPressed: () {},
                ),
                const SizedBox(width: 20),
                IconButton(
                  iconSize: 36,
                  icon: const Icon(Icons.forward_10, color: Colors.white),
                  onPressed: () {},
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
