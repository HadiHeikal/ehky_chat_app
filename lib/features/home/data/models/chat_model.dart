class ChatModel {
  final String name;
  final String message;
  final String time;
  final int unreadCount;
  final bool isRead;
  final String avatar;

  ChatModel({
    required this.name,
    required this.message,
    required this.time,
    this.unreadCount = 0,
    this.isRead = false,
    required this.avatar,
  });
}
