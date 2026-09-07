import 'package:flutter/material.dart';

class SettingsScreen extends StatelessWidget {
  const SettingsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      body: SingleChildScrollView(
        child: Column(
          children: [
            // 1. Profile Banner Video Header (Background Video Loop Concept)
            Stack(
              clipBehavior: Clip.none,
              alignment: Alignment.center,
              children: [
                // Banner Video Background Box
                Container(
                  height: 180,
                  width: double.infinity,
                  decoration: BoxDecoration(
                    gradient: LinearGradient(
                      colors: [Colors.purple.shade900, Colors.pink.shade800, Colors.black],
                      begin: Alignment.topCenter,
                      end: Alignment.bottomCenter,
                    ),
                  ),
                  child: Stack(
                    children: [
                      const Center(
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Icon(Icons.movie_creation_outlined, color: Colors.white38, size: 20),
                            SizedBox(width: 8),
                            Text(
                              'Profile Banner Video Loop',
                              style: TextStyle(color: Colors.white38, fontSize: 13, fontWeight: FontWeight.bold),
                            ),
                          ],
                        ),
                      ),
                      // Action Icons on Banner Top Right
                      Positioned(
                        top: 45,
                        right: 16,
                        child: Row(
                          children: [
                            IconButton(
                              icon: const Icon(Icons.qr_code_scanner, color: Colors.white),
                              onPressed: () {},
                            ),
                            IconButton(
                              icon: const Icon(Icons.settings, color: Colors.white),
                              onPressed: () {},
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),

                // 2. 3D / Animated Avatar
                Positioned(
                  bottom: -45,
                  child: Stack(
                    alignment: Alignment.bottomRight,
                    children: [
                      Container(
                        padding: const EdgeInsets.all(4),
                        decoration: const BoxDecoration(
                          color: Colors.black,
                          shape: BoxShape.circle,
                        ),
                        child: CircleAvatar(
                          radius: 46,
                          backgroundColor: Colors.grey[800],
                          child: const Icon(
                            Icons.face_5, // 3D Avatar/Motion Character Representation Icon
                            size: 60,
                            color: Colors.pinkAccent,
                          ),
                        ),
                      ),
                      // Animated Indicator Badge
                      Container(
                        padding: const EdgeInsets.all(4),
                        decoration: const BoxDecoration(
                          color: Colors.blueAccent,
                          shape: BoxShape.circle,
                        ),
                        child: const Icon(
                          Icons.3d_rotation,
                          color: Colors.white,
                          size: 16,
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),

            const SizedBox(height: 55),

            // Profile Header Details (Name & Username)
            const Text(
              'Thet Lin Dev',
              style: TextStyle(
                color: Colors.white,
                fontSize: 20,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 4),
            const Text(
              '@thetlin_dev',
              style: TextStyle(color: Colors.grey, fontSize: 14),
            ),
            const SizedBox(height: 12),

            // Bio
            const Padding(
              padding: EdgeInsets.symmetric(horizontal: 32),
              child: Text(
                '✨ Flutter Developer | Creating Next-Gen Social Apps\n🚀 Welcome to Blink App Official Profile!',
                textAlign: TextAlign.center,
                style: TextStyle(color: Colors.white70, fontSize: 13),
              ),
            ),

            const SizedBox(height: 20),

            // Followers / Following / Likes Stats
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                _buildStatColumn('120', 'Following'),
                _buildStatColumn('45.8K', 'Followers'),
                _buildStatColumn('250.5K', 'Likes'),
              ],
            ),

            const SizedBox(height: 20),

            // Settings & Controls (Edit Profile Buttons)
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                ElevatedButton(
                  onPressed: () {},
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.pinkAccent,
                    padding: const EdgeInsets.symmetric(horizontal: 28, vertical: 12),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(20),
                    ),
                  ),
                  child: const Text('Edit Profile', style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold)),
                ),
                const SizedBox(width: 12),
                OutlinedButton(
                  onPressed: () {},
                  style: OutlinedButton.styleFrom(
                    side: const BorderSide(color: Colors.grey),
                    padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 12),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(20),
                    ),
                  ),
                  child: const Text('Share Profile', style: TextStyle(color: Colors.white)),
                ),
              ],
            ),

            const SizedBox(height: 24),
            const Divider(color: Colors.grey, thickness: 0.2),

            // Content Grid (Video Grid Tabs & Grid View)
            DefaultTabController(
              length: 3,
              child: Column(
                children: [
                  const TabBar(
                    indicatorColor: Colors.pinkAccent,
                    labelColor: Colors.white,
                    unselectedLabelColor: Colors.grey,
                    tabs: [
                      Tab(icon: Icon(Icons.grid_on)),
                      Tab(icon: Icon(Icons.favorite_border)),
                      Tab(icon: Icon(Icons.bookmark_border)),
                    ],
                  ),
                  SizedBox(
                    height: 400,
                    child: TabBarView(
                      children: [
                        // Video Posts Grid
                        GridView.builder(
                          physics: const NeverScrollableScrollPhysics(),
                          itemCount: 9,
                          gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                            crossAxisCount: 3,
                            crossAxisSpacing: 2,
                            mainAxisSpacing: 2,
                          ),
                          itemBuilder: (context, index) {
                            return Container(
                              color: Colors.grey[900],
                              child: Stack(
                                children: [
                                  Center(
                                    child: Icon(
                                      Icons.play_arrow,
                                      color: Colors.white.withOpacity(0.5),
                                      size: 30,
                                    ),
                                  ),
                                  Positioned(
                                    bottom: 6,
                                    left: 6,
                                    child: Row(
                                      children: [
                                        const Icon(Icons.play_arrow_outlined, color: Colors.white, size: 14),
                                        const SizedBox(width: 2),
                                        Text(
                                          '${(index + 1) * 1.2}k',
                                          style: const TextStyle(color: Colors.white, fontSize: 10),
                                        ),
                                      ],
                                    ),
                                  ),
                                ],
                              ),
                            );
                          },
                        ),
                        const Center(child: Text('Liked Videos', style: TextStyle(color: Colors.white54))),
                        const Center(child: Text('Saved Videos', style: TextStyle(color: Colors.white54))),
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

  static Widget _buildStatColumn(String value, String label) {
    return Column(
      children: [
        Text(
          value,
          style: const TextStyle(
            color: Colors.white,
            fontSize: 18,
            fontWeight: FontWeight.bold,
          ),
        ),
        const SizedBox(height: 4),
        Text(
          label,
          style: const TextStyle(color: Colors.grey, fontSize: 12),
        ),
      ],
    );
  }
}
