import 'package:flutter/material.dart';
import '../core/constants/colors.dart';
import '../widgets/bottom_tab_bar.dart';
import 'home_feed_screen.dart';
import 'search_screen.dart';
import 'reels_screen.dart';
import 'profile_screen.dart';
import 'upload_reel_screen.dart';

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
    SizedBox.shrink(), // placeholder for upload sheet
    ReelsScreen(),
    ProfileScreen(),
  ];

  void _onTabTap(int index) {
    if (index == 2) {
      // Show upload reel modal
      Navigator.push(
        context,
        MaterialPageRoute(
          fullscreenDialog: true,
          builder: (_) => const UploadReelScreen(),
        ),
      );
      return;
    }
    setState(() => _currentIndex = index);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: kBackground,
      body: IndexedStack(
        index: _currentIndex == 2 ? 0 : _currentIndex > 2 ? _currentIndex - 1 : _currentIndex,
        children: _screens.where((s) => s is! SizedBox).toList(),
      ),
      bottomNavigationBar: BottomTabBar(
        currentIndex: _currentIndex,
        onTap: _onTabTap,
      ),
    );
  }
}
