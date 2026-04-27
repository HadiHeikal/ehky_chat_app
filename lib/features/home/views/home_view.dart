import 'package:ehky_chat_app/core/constants/app_colors.dart';
import 'package:ehky_chat_app/features/chat/views/chat_view.dart';
import 'package:ehky_chat_app/features/home/data/models/chat_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter_gap/flutter_gap.dart';

class HomeView extends StatefulWidget {
  const HomeView({super.key});

  @override
  State<HomeView> createState() => _HomeViewState();
}

class _HomeViewState extends State<HomeView> {
  final _searchController = TextEditingController();
  int _selectedTab = 0;

  //Dummy chats data
  final List<ChatModel> _dummyChats = [
    ChatModel(
      name: "Robert Fox",
      message: "Hey, let's play basketball",
      time: "15.43",
      isRead: true,
      avatar: "https://i.pravatar.cc/150?u=a042581f4e29026704d",
    ),
    ChatModel(
      name: "Esther Howard",
      message: "Perfect, see you later",
      time: "15.29",
      isRead: true,
      avatar: "https://i.pravatar.cc/150?u=a042581f4e29026024d",
    ),
    ChatModel(
      name: "Jacob Jones",
      message: "Oh you're right lmao",
      time: "14.53",
      unreadCount: 2,
      avatar: "https://i.pravatar.cc/150?u=a042581f4e29026704e",
    ),
    ChatModel(
      name: "Bessie Cooper",
      message: "Don't forget abt tonight babe",
      time: "12.27",
      isRead: true,
      avatar: "https://i.pravatar.cc/150?u=a042581f4e29026704f",
    ),
    ChatModel(
      name: "Albert Flores",
      message: "Bro wanna play basketball...",
      time: "12.20",
      unreadCount: 3,
      avatar: "https://i.pravatar.cc/150?u=a042581f4e29026704g",
    ),
    ChatModel(
      name: "Floyd Miles",
      message: "How about play basketball...",
      time: "11.40",
      isRead: true,
      avatar: "https://i.pravatar.cc/150?u=a042581f4e29026704h",
    ),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20),
        child: Column(
          children: [
            const Gap(40),
            Row(
              children: [
                Container(
                  height: 50,
                  width: 290,
                  alignment: Alignment.center,
                  decoration: BoxDecoration(
                    color: AppColors.searchBackground,
                    borderRadius: BorderRadius.circular(16),
                  ),
                  child: TextField(
                    controller: _searchController,
                    onChanged: (value) {
                      setState(() {});
                    },
                    decoration: InputDecoration(
                      hintText: 'Search Chat',
                      prefixIcon: Image.asset('assets/icons/Search_icon.png'),
                      suffixIcon: _searchController.text.isNotEmpty
                          ? IconButton(
                              icon: const Icon(Icons.clear),
                              onPressed: () {
                                _searchController.clear();
                                setState(() {});
                              },
                            )
                          : null,
                      filled: true,
                      fillColor: AppColors.searchBackground,
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(16),
                        borderSide: BorderSide.none,
                      ),
                    ),
                  ),
                ),
                const Gap(10),
                Container(
                  height: 50,
                  width: 50,
                  alignment: Alignment.center,
                  decoration: BoxDecoration(
                    color: AppColors.searchBackground,
                    borderRadius: BorderRadius.circular(16),
                  ),
                  child: Image.asset(
                    'assets/icons/Scan.png',
                    width: 40,
                    height: 40,
                  ),
                ),
              ],
            ),
            const Gap(20),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                _buildTab(0, "Chats"),
                _buildTab(1, "Friends"),
                _buildTab(2, "Calls"),
              ],
            ),
            const Gap(20),
            Expanded(
              child: _selectedTab == 0
                  ? ListView.separated(
                      padding: const EdgeInsets.only(bottom: 20),
                      itemCount: _dummyChats.length,
                      separatorBuilder: (context, index) => const Gap(16),
                      itemBuilder: (context, index) {
                        final chat = _dummyChats[index];
                        return GestureDetector(
                          onTap: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) => ChatView(
                                  name: chat.name,
                                  avatarUrl: chat.avatar,
                                ),
                              ),
                            );
                          },
                          child: Container(
                            padding: const EdgeInsets.symmetric(
                              horizontal: 16,
                              vertical: 12,
                            ),
                            decoration: BoxDecoration(
                              color: Colors.white,
                              borderRadius: BorderRadius.circular(16),
                              border: Border.all(
                                color: AppColors.primary,
                                width: 1.5,
                              ),
                            ),
                            child: Row(
                              children: [
                                CircleAvatar(
                                  radius: 26,
                                  backgroundImage: NetworkImage(chat.avatar),
                                ),
                                const Gap(16),
                                Expanded(
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Text(
                                        chat.name,
                                        style: const TextStyle(
                                          fontWeight: FontWeight.bold,
                                          fontSize: 16,
                                          color: Colors.black,
                                        ),
                                      ),
                                      const Gap(4),
                                      Row(
                                        children: [
                                          if (chat.isRead) ...[
                                            const Icon(
                                              Icons.done_all,
                                              size: 16,
                                              color: Colors.blue,
                                            ),
                                            const Gap(4),
                                          ],
                                          Expanded(
                                            child: Text(
                                              chat.message,
                                              maxLines: 1,
                                              overflow: TextOverflow.ellipsis,
                                              style: TextStyle(
                                                color: Colors.grey.shade600,
                                                fontSize: 14,
                                              ),
                                            ),
                                          ),
                                        ],
                                      ),
                                    ],
                                  ),
                                ),
                                Column(
                                  crossAxisAlignment: CrossAxisAlignment.end,
                                  children: [
                                    Text(
                                      chat.time,
                                      style: TextStyle(
                                        color: Colors.grey.shade500,
                                        fontSize: 12,
                                      ),
                                    ),
                                    const Gap(8),
                                    if (chat.unreadCount > 0)
                                      Container(
                                        padding: const EdgeInsets.all(6),
                                        decoration: const BoxDecoration(
                                          color: AppColors.primary,
                                          shape: BoxShape.circle,
                                        ),
                                        child: Text(
                                          chat.unreadCount.toString(),
                                          style: const TextStyle(
                                            color: Colors.white,
                                            fontSize: 10,
                                            fontWeight: FontWeight.bold,
                                          ),
                                        ),
                                      )
                                    else
                                      const Gap(20),
                                  ],
                                ),
                              ],
                            ),
                          ),
                        );
                      },
                    )
                  : Center(
                      child: Text(
                        "No ${_selectedTab == 1 ? 'Friends' : 'Calls'} yet.",
                        style: TextStyle(color: Colors.grey.shade600),
                      ),
                    ),
            ),
          ],
        ),
      ),
    );
  }

  // tab widget
  Widget _buildTab(int index, String title) {
    final isSelected = _selectedTab == index;
    return GestureDetector(
      onTap: () {
        setState(() {
          _selectedTab = index;
        });
      },
      child: Column(
        children: [
          Text(
            title,
            style: TextStyle(
              fontSize: 16,
              fontWeight: isSelected ? FontWeight.bold : FontWeight.w500,
              color: isSelected ? AppColors.primary : Colors.grey.shade600,
            ),
          ),
          const Gap(4),
          if (isSelected)
            Container(height: 2, width: 40, color: AppColors.primary)
          else
            const Gap(2),
        ],
      ),
    );
  }
}
