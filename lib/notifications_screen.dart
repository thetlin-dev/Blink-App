import 'package:flutter/material.dart';

class NotificationsScreen extends StatelessWidget {
  const NotificationsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 2,
      child: Scaffold(
        backgroundColor: Colors.black,
        appBar: AppBar(
          backgroundColor: Colors.black,
          title: const Text("Notifications", style: TextStyle(color: Colors.white)),
          bottom: const TabBar(
            indicatorColor: Colors.pinkAccent,
            labelColor: Colors.pinkAccent,
            unselectedLabelColor: Colors.white54,
            tabs: [
              Tab(text: "All Activity"),
              Tab(text: "Messages"),
            ],
          ),
        ),
        body: TabBarView(
          children: [
            // Activity List
            ListView.builder(
              itemCount: 10,
              itemBuilder: (context, index) {
                return ListTile(
                  leading: const CircleAvatar(
                    backgroundColor: Colors.pinkAccent,
                    child: Icon(Icons.person, color: Colors.white),
                  ),
                  title: Text(
                    "User_$index liked your video",
                    style: const TextStyle(color: Colors.white, fontSize: 14),
                  ),
                  subtitle: const Text("2h ago", style: TextStyle(color: Colors.white54, fontSize: 12)),
                  trailing: const Icon(Icons.favorite, color: Colors.redAccent, size: 20),
                );
              },
            ),

            // Messages List
            ListView.builder(
              itemCount: 5,
              itemBuilder: (context, index) {
                return ListTile(
                  leading: const CircleAvatar(
                    backgroundColor: Colors.blueAccent,
                    child: Icon(Icons.chat_bubble, color: Colors.white),
                  ),
                  title: Text(
                    "Creator_$index",
                    style: const TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
                  ),
                  subtitle: const Text("Hey! Loved your recent video recap.", style: TextStyle(color: Colors.white70)),
                  trailing: const Text("10:30 AM", style: TextStyle(color: Colors.white38, fontSize: 12)),
                );
              },
            ),
          ],
        ),
      ),
    );
  }
}
