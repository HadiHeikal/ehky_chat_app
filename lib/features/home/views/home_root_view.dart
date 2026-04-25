import 'package:ehky_chat_app/features/home/views/home_view.dart';
import 'package:ehky_chat_app/features/home/views/new_chat_view.dart';
import 'package:ehky_chat_app/features/home/views/setting_view.dart';
import 'package:flutter/material.dart';

class HomeRootView extends StatefulWidget {
  const HomeRootView({super.key});

  @override
  State<HomeRootView> createState() => _HomeRootViewState();
}

class _HomeRootViewState extends State<HomeRootView> {
  int currentIndex = 0;
  late List<Widget> pages;
  PageController pageController = PageController();
  @override
  void initState() {
    super.initState();
    pages = [HomeView(), NewChatView(), SettingView()];
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      bottomNavigationBar: ClipRRect(
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(20),
          topRight: Radius.circular(20),
        ),
        child: Container(
          height: 110,
          decoration: BoxDecoration(
            boxShadow: [
              BoxShadow(
                color: Colors.grey,
                spreadRadius: 2,
                blurRadius: 5,
                offset: Offset(0, 3),
              ),
            ],
          ),
          child: BottomNavigationBar(
            backgroundColor: Colors.purple,
            type: BottomNavigationBarType.fixed,
            currentIndex: currentIndex,
            onTap: (index) {
              setState(() {
                currentIndex = index;
              });
              pageController.animateToPage(
                index,
                duration: Duration(milliseconds: 300),
                curve: Curves.ease,
              );
            },
            items: [
              BottomNavigationBarItem(icon: Icon(Icons.home), label: 'Home'),
              BottomNavigationBarItem(
                icon: Icon(Icons.person_4_rounded),
                label: 'Contacts',
              ),
              BottomNavigationBarItem(
                icon: Icon(Icons.settings),
                label: 'Settings',
              ),
            ],
          ),
        ),
      ),
      body: PageView(
        controller: pageController,
        physics: NeverScrollableScrollPhysics(),
        children: pages,
      ),
    );
  }
}
