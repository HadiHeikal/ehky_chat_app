import 'package:flutter/material.dart';

class NewChatView extends StatefulWidget {
  const NewChatView({super.key});

  @override
  State<NewChatView> createState() => _NewChatViewState();
}

class _NewChatViewState extends State<NewChatView> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(body: Center(child: Text('New Chat View')));
  }
}
