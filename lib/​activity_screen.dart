import 'package0:flutter/material.dart';

class ActivityScreen extends StatelessWidget {
  const ActivityScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      appBar: AppBar(
        backgroundColor: Colors.black,
        title: const Text('Notifications'),
      ),
      body: ListView.builder(
        itemCount: 5,
        itemBuilder: (context, index) {
          return ListTile(
            leading: const CircleAvatar(
              backgroundColor: Color(0xFFFF2C55),
              child: Icon(Icons.person, color: Colors.white),
            ),
            title: Text('User_$index liked your video'),
            subtitle: const Text('2h ago', style: TextStyle(color: Colors.white54)),
          );
        },
      ),
    );
  }
}
