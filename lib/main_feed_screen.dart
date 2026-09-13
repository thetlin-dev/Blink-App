import 'package:flutter/material.dart';

class MainFeedScreen extends StatefulWidget {
  const MainFeedScreen({super.key});

  @override
  State<MainFeedScreen> createState() => _MainFeedScreenState();
}

class _MainFeedScreenState extends State<MainFeedScreen> {
  // State variables for feature controls
  bool isGridView = false;
  bool isAudioOnly = false;
  bool isCleanMode = false;
  String selectedTab = 'For You';
  int selectedPollOption = -1;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      body: Stack(
        children: [
          // 1. Main Content Area (Vertical Swipe Video / Grid View Toggle)
          isGridView ? _buildGridView() : _buildVerticalSwipeFeed(),

          // 2. Top Navigation & Category Bar Overlay
          if (!isCleanMode) _buildTopHeaderBar(),

          // 3. Bottom Navigation Bar
          _buildBottomNavBar(),
        ],
      ),
    );
  }

  // Feature 1: Top Navigation Bar (Dual Tab, Grid Switcher, BlinkMatch, Category Tags)
  Widget _buildTopHeaderBar() {
    return Positioned(
      top: 50,
      left: 0,
      right: 0,
      child: Column(
        children: [
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                // Dual Tabs (For You / Following)
                Row(
                  children: [
                    GestureDetector(
                      onTap: () => setState(() => selectedTab = 'For You'),
                      child: Text(
                        "For You",
                        style: TextStyle(
                          color: selectedTab == 'For You' ? Colors.white : Colors.white60,
                          fontWeight: FontWeight.bold,
                          fontSize: 16,
                        ),
                      ),
                    ),
                    const SizedBox(width: 16),
                    GestureDetector(
                      onTap: () => setState(() => selectedTab = 'Following'),
                      child: Text(
                        "Following",
                        style: TextStyle(
                          color: selectedTab == 'Following' ? Colors.white : Colors.white60,
                          fontWeight: FontWeight.bold,
                          fontSize: 16,
                        ),
                      ),
                    ),
                  ],
                ),

                // Right Controls (Grid Toggle & BlinkMatch Button)
                Row(
                  children: [
                    // Layout Switcher Toggle Icon
                    IconButton(
                      icon: Icon(
                        isGridView ? Icons.view_agenda : Icons.grid_view,
                        color: Colors.white,
                      ),
                      onPressed: () {
                        setState(() {
                          isGridView = !isGridView;
                        });
                      },
                    ),
                    
                    // BlinkMatch Quick Action Button
                    ElevatedButton.icon(
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.pinkAccent,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(20),
                        ),
                        padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
                      ),
                      onPressed: () => _showBlinkMatchDialog(),
                      icon: const Icon(Icons.flash_on, color: Colors.yellow, size: 16),
                      label: const Text(
                        "BlinkMatch",
                        style: TextStyle(color: Colors.white, fontSize: 12, fontWeight: FontWeight.bold),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
          
          const SizedBox(height: 8),

          // Horizontal Category Tags Bar
          SingleChildScrollView(
            scrollDirection: Axis.horizontal,
            padding: const EdgeInsets.symmetric(horizontal: 16),
            child: Row(
              children: [
                _buildCategoryTag("✨ All", true),
                _buildCategoryTag("🎬 #MovieRecap", false),
                _buildCategoryTag("😂 #Funny", false),
                _buildCategoryTag("🎮 #Gaming", false),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildCategoryTag(String label, bool isSelected) {
    return Container(
      margin: const EdgeInsets.only(right: 8),
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
      decoration: BoxDecoration(
        color: isSelected ? Colors.white24 : Colors.white10,
        borderRadius: BorderRadius.circular(15),
      ),
      child: Text(
        label,
        style: const TextStyle(color: Colors.white, fontSize: 12),
      ),
    );
  }

  // Main Vertical Single Video View
  Widget _buildVerticalSwipeFeed() {
    return PageView.builder(
      scrollDirection: Axis.vertical,
      itemCount: 5,
      itemBuilder: (context, index) {
        return Stack(
          children: [
            // Video / Audio Player View Area
            Center(
              child: isAudioOnly
                  ? const Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Icon(Icons.headset, size: 80, color: Colors.greenAccent),
                        SizedBox(height: 12),
                        Text("Audio-Only Mode Active", style: TextStyle(color: Colors.white70)),
                      ],
                    )
                  : Container(
                      color: Colors.grey[900],
                      child: const Center(
                        child: Text("Vertical Video Player Area", style: TextStyle(color: Colors.white55)),
                      ),
                    ),
            ),

            // Feature 3: Interactive Poll Widget Overlay
            Align(
              alignment: Alignment.center,
              child: Container(
                width: 260,
                padding: const EdgeInsets.all(12),
                decoration: BoxDecoration(
                  color: Colors.black54,
                  borderRadius: BorderRadius.circular(16),
                  border: Border.all(color: Colors.white24),
                ),
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    const Text("Have you watched this movie?", style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold)),
                    const SizedBox(height: 8),
                    _buildPollOption(0, "Yes (10/10)"),
                    const SizedBox(height: 4),
                    _buildPollOption(1, "Not yet"),
                  ],
                ),
              ),
            ),

            // Bottom Actions & Meta Info (Feature 1: Bottom Horizontal Actions)
            Positioned(
              bottom: 80,
              left: 16,
              right: 16,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text("Thet Lin Zaw", style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold, fontSize: 16)),
                  const SizedBox(height: 4),
                  const Text("Today's movie recap clip #funny #happy #movierecap", style: TextStyle(color: Colors.white70, fontSize: 13)),
                  const SizedBox(height: 12),

                  // Horizontal Floating Bar for Interactions
                  Container(
                    padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                    decoration: BoxDecoration(
                      color: Colors.black45,
                      borderRadius: BorderRadius.circular(25),
                      border: Border.all(color: Colors.white12),
                    ),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Row(
                          children: const [
                            Icon(Icons.favorite, color: Colors.pinkAccent, size: 20),
                            SizedBox(width: 4),
                            Text("12.6K", style: TextStyle(color: Colors.white, fontSize: 12)),
                          ],
                        ),
                        Row(
                          children: const [
                            Icon(Icons.comment, color: Colors.white, size: 20),
                            SizedBox(width: 4),
                            Text("1,016", style: TextStyle(color: Colors.white, fontSize: 12)),
                          ],
                        ),
                        // Co-Watch Action Button
                        GestureDetector(
                          onTap: () {
                            ScaffoldMessenger.of(context).showSnackBar(
                              const SnackBar(content: Text("Co-Watch Party created!")),
                            );
                          },
                          child: Row(
                            children: const [
                              Icon(Icons.group, color: Colors.greenAccent, size: 20),
                              SizedBox(width: 4),
                              Text("Co-Watch", style: TextStyle(color: Colors.white, fontSize: 12)),
                            ],
                          ),
                        ),
                        // Audio Mode Launcher
                        IconButton(
                          icon: Icon(isAudioOnly ? Icons.videocam : Icons.music_note, color: Colors.amber, size: 20),
                          onPressed: () => setState(() => isAudioOnly = !isAudioOnly),
                        )
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ],
        );
      },
    );
  }

  // Feature 1: Grid View Switch Option
  Widget _buildGridView() {
    return Padding(
      padding: const EdgeInsets.only(top: 120.0, left: 8, right: 8, bottom: 70),
      child: GridView.builder(
        gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 2,
          childAspectRatio: 0.7,
          crossAxisSpacing: 8,
          mainAxisSpacing: 8,
        ),
        itemCount: 10,
        itemBuilder: (context, index) {
          return Container(
            decoration: BoxDecoration(
              color: Colors.grey[850],
              borderRadius: BorderRadius.circular(16),
            ),
            child: const Center(
              child: Icon(Icons.play_circle_fill, color: Colors.white54, size: 40),
            ),
          );
        },
      ),
    );
  }

  Widget _buildPollOption(int index, String text) {
    bool isSelected = selectedPollOption == index;
    return GestureDetector(
      onTap: () => setState(() => selectedPollOption = index),
      child: Container(
        width: double.infinity,
        padding: const EdgeInsets.symmetric(vertical: 8, horizontal: 12),
        decoration: BoxDecoration(
          color: isSelected ? Colors.pinkAccent : Colors.white12,
          borderRadius: BorderRadius.circular(10),
        ),
        child: Text(text, style: const TextStyle(color: Colors.white, fontSize: 12)),
      ),
    );
  }

  // BlinkMatch Feature Modal
  void _showBlinkMatchDialog() {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        backgroundColor: Colors.grey[900],
        title: const Text("⚡ BlinkMatch", style: TextStyle(color: Colors.white)),
        content: const Text("Swipe right to connect with people who share similar interests.", style: TextStyle(color: Colors.white70)),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text("Close", style: TextStyle(color: Colors.pinkAccent)),
          )
        ],
      ),
    );
  }

  // Bottom Navigation Bar Layout
  Widget _buildBottomNavBar() {
    return Align(
      alignment: Alignment.bottomCenter,
      child: Container(
        height: 65,
        color: Colors.black,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: const [
            Icon(Icons.home, color: Colors.pinkAccent),
            Icon(Icons.explore, color: Colors.white54),
            CircleAvatar(
              backgroundColor: Colors.pinkAccent,
              child: Icon(Icons.add, color: Colors.white),
            ),
            Icon(Icons.notifications, color: Colors.white54),
            Icon(Icons.person, color: Colors.white54),
          ],
        ),
      ),
    );
  }
}
