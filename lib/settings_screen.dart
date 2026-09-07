import 'package:flutter/material.dart';

class SettingsScreen extends StatelessWidget {
  const SettingsScreen({super.key});

  // Settings Menu Bottom Sheet ပြသပေးသည့် Function
  void _showSettingsMenu(BuildContext context) {
    showModalBottomSheet(
      context: context,
      backgroundColor: Colors.grey[900],
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
      ),
      builder: (BuildContext context) {
        return Padding(
          padding: const EdgeInsets.symmetric(vertical: 20, horizontal: 16),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Container(
                width: 40,
                height: 4,
                decoration: BoxDecoration(
                  color: Colors.grey[600],
                  borderRadius: BorderRadius.circular(2),
                ),
              ),
              const SizedBox(height: 20),
              const Text(
                'Settings & Privacy',
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(height: 15),
              ListTile(
                leading: const Icon(Icons.person_outline, color: Colors.white),
                title: const Text('Account Settings', style: TextStyle(color: Colors.white)),
                onTap: () => Navigator.pop(context),
              ),
              ListTile(
                leading: const Icon(Icons.lock_outline, color: Colors.white),
                title: const Text('Privacy & Safety', style: TextStyle(color: Colors.white)),
                onTap: () => Navigator.pop(context),
              ),
              ListTile(
                leading: const Icon(Icons.notifications_none, color: Colors.white),
                title: const Text('Notifications', style: TextStyle(color: Colors.white)),
                onTap: () => Navigator.pop(context),
              ),
              ListTile(
                leading: const Icon(Icons.logout, color: Colors.redAccent),
                title: const Text('Log Out', style: TextStyle(color: Colors.redAccent)),
                onTap: () => Navigator.pop(context),
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
      body: CustomScrollView(
        slivers: [
          // Banner Video / Header Area
          SliverAppBar(
            expandedHeight: 180,
            pinned: true,
            backgroundColor: Colors.black,
            actions: [
              IconButton(
                icon: const Icon(Icons.settings, color: Colors.white),
                onPressed: () => _showSettingsMenu(context),
              ),
            ],
            flexibleSpace: FlexibleSpaceBar(
              background: Stack(
                fit: StackFit.expand,
                children: [
                  // Profile Banner Video Placeholder
                  Container(
                    decoration: BoxDecoration(
                      gradient: LinearGradient(
                        colors: [Colors.purple.shade900, Colors.pink.shade900],
                        begin: Alignment.topLeft,
                        end: Alignment.bottomRight,
                      ),
                    ),
                    child: const Center(
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Icon(Icons.play_circle_fill, color: Colors.white54, size: 30),
                          SizedBox(width: 8),
                          Text(
                            'Profile Banner Video Loop',
                            style: TextStyle(color: Colors.white70, fontSize: 13),
                          ),
                        ],
                      ),
                    ),
                  ),
                  Container(
                    color: Colors.black.withOpacity(0.3),
                  ),
                ],
              ),
            ),
          ),

          // Profile Info Section
          SliverToBoxAdapter(
            child: Column(
              children: [
                const SizedBox(height: 10),
                // Avatar with 3D/Animated Badge
                Stack(
                  alignment: Alignment.bottomRight,
                  children: [
                    Container(
                      padding: const EdgeInsets.all(3),
                      decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        border: Border.all(color: Colors.pinkAccent, width: 2),
                      ),
                      child: const CircleAvatar(
                        radius: 45,
                        backgroundColor: Colors.grey,
                        child: Icon(Icons.person, size: 50, color: Colors.white),
                      ),
                    ),
                    // 3D / Motion Avatar Badge
                    Container(
                      padding: const EdgeInsets.symmetric(horizontal: 6, vertical: 2),
                      decoration: BoxDecoration(
                        color: Colors.pinkAccent,
                        borderRadius: BorderRadius.circular(10),
                      ),
                      child: const Row(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          Icon(Icons.view_in_ar, size: 12, color: Colors.white),
                          SizedBox(width: 2),
                          Text(
                            '3D',
                            style: TextStyle(
                              color: Colors.white,
                              fontSize: 10,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 10),

                // Name & Username
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
                    'Mobile Developer 🚀 | Creating cool apps with Flutter ✨',
                    textAlign: TextAlign.center,
                    style: TextStyle(color: Colors.white70, fontSize: 13),
                  ),
                ),
                const SizedBox(height: 16),

                // Followers / Following Stats
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    _buildStatItem('Following', '128'),
                    _buildDivider(),
                    _buildStatItem('Followers', '10.5K'),
                    _buildDivider(),
                    _buildStatItem('Likes', '85.2K'),
                  ],
                ),
                const SizedBox(height: 16),

                // Edit Profile & Settings Controls
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    OutlinedButton(
                      onPressed: () {},
                      style: OutlinedButton.styleFrom(
                        side: const BorderSide(color: Colors.grey),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(8),
                        ),
                        padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 10),
                      ),
                      child: const Text(
                        'Edit Profile',
                        style: TextStyle(color: Colors.white),
                      ),
                    ),
                    const SizedBox(width: 10),
                    OutlinedButton(
                      onPressed: () {},
                      style: OutlinedButton.styleFrom(
                        side: const BorderSide(color: Colors.grey),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(8),
                        ),
                        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 10),
                      ),
                      child: const Icon(Icons.share, color: Colors.white, size: 18),
                    ),
                  ],
                ),
                const SizedBox(height: 20),
                const Divider(color: Colors.white24, height: 1),
              ],
            ),
          ),

          // Content Grid (Video Feed Grid)
          SliverPadding(
            padding: const EdgeInsets.all(2),
            sliver: SliverGrid(
              gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 3,
                crossAxisSpacing: 2,
                mainAxisSpacing: 2,
                childAspectRatio: 0.75,
              ),
              delegate: SliverChildBuilderDelegate(
                (context, index) {
                  return Container(
                    color: Colors.grey[900],
                    child: Stack(
                      children: [
                        Center(
                          child: Icon(
                            Icons.movie_creation_outlined,
                            color: Colors.grey[700],
                            size: 32,
                          ),
                        ),
                        Positioned(
                          bottom: 6,
                          left: 6,
                          child: Row(
                            children: [
                              const Icon(Icons.play_arrow, color: Colors.white, size: 14),
                              const SizedBox(width: 2),
                              Text(
                                '${((index + 1) * 1.2).toStringAsFixed(1)}k',
                                style: const TextStyle(
                                  color: Colors.white,
                                  fontSize: 11,
                                  fontWeight: FontWeight.w600,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  );
                },
                childCount: 15,
              ),
            ),
          ),
        ],
      ),
    );
  }

  static Widget _buildStatItem(String label, String value) {
    return Column(
      children: [
        Text(
          value,
          style: const TextStyle(
            color: Colors.white,
            fontSize: 16,
            fontWeight: FontWeight.bold,
          ),
        ),
        const SizedBox(height: 2),
        Text(
          label,
          style: const TextStyle(color: Colors.grey, fontSize: 12),
        ),
      ],
    );
  }

  static Widget _buildDivider() {
    return Container(
      height: 20,
      width: 1,
      color: Colors.white24,
      margin: const EdgeInsets.symmetric(horizontal: 20),
    );
  }
}
