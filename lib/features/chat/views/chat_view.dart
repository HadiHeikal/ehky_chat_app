import 'package:flutter/material.dart';
import 'package:flutter_gap/flutter_gap.dart';

class ChatView extends StatelessWidget {
  final String name;
  final String avatarUrl;

  const ChatView({super.key, required this.name, required this.avatarUrl});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 1,
        iconTheme: const IconThemeData(color: Colors.black),
        title: Row(
          children: [
            CircleAvatar(backgroundImage: NetworkImage(avatarUrl)),
            const Gap(10),
            Text(
              name,
              style: const TextStyle(
                color: Colors.black,
                fontWeight: FontWeight.bold,
                fontSize: 18,
              ),
            ),
          ],
        ),
      ),
      body: Center(child: Text('Chat with $name')),
    );
  }
}
