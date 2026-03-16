import 'package:flutter/material.dart';
import '../core/constants/colors.dart';
import '../widgets/bottom_tab_bar.dart';
import 'home_feed_screen.dart';
import 'search_screen.dart';
import 'reels_screen.dart';
import 'notifications_screen.dart';
import 'profile_screen.dart';

class MainScreen extends StatefulWidget {
  const MainScreen({super.key});

  @override
  State<MainScreen> createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen> {
  int _currentIndex = 0;

  static const _screens = [
    HomeFeedScreen(),
    SearchScreen(),
    ReelsScreen(),
    NotificationsScreen(),
    ProfileScreen(),
  ];

  void _onTabTap(int index) {
    setState(() => _currentIndex = index);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: kBackground,
      body: IndexedStack(
        index: _currentIndex,
        children: _screens,
      ),
      bottomNavigationBar: BottomTabBar(
        currentIndex: _currentIndex,
        onTap: _onTabTap,
      ),
    );
  }
}
