import 'package:flutter/material.dart';
import '../core/constants/colors.dart';
import '../widgets/reel_item.dart';
import '../services/post_repository.dart';

class ReelsScreen extends StatefulWidget {
  const ReelsScreen({super.key});

  @override
  State<ReelsScreen> createState() => _ReelsScreenState();
}

class _ReelsScreenState extends State<ReelsScreen> {
  final _reels = PostRepository.getReelPosts();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: kBackground,
      extendBodyBehindAppBar: true,
      appBar: null,
      body: PageView.builder(
        scrollDirection: Axis.vertical,
        itemCount: _reels.length,
        itemBuilder: (context, index) {
          return ReelItem(reel: _reels[index]);
        },
      ),
    );
  }
}
