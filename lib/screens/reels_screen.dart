import 'package:flutter/material.dart';
import '../widgets/reel_item.dart';
import '../services/post_repository.dart';
import '../models/post_model.dart';


class ReelsScreen extends StatefulWidget {
  const ReelsScreen({super.key});

  @override
  State<ReelsScreen> createState() => _ReelsScreenState();
}

class _ReelsScreenState extends State<ReelsScreen> {
  final List<PostModel> _reels = [];
  bool _isLoading = false;
  int _page = 0;
  late PageController _pageController;

  @override
  void initState() {
    super.initState();
    _pageController = PageController();
    _loadMoreReels();
    _pageController.addListener(_onPageScroll);
  }

  @override
  void dispose() {
    _pageController.dispose();
    super.dispose();
  }

  Future<void> _loadMoreReels() async {
    if (_isLoading) return;
    setState(() => _isLoading = true);
    
    final newReels = await PostRepository.getReelPosts(page: _page);
    if (mounted) {
      setState(() {
        _reels.addAll(newReels);
        _isLoading = false;
        _page++;
      });
    }
  }

  void _onPageScroll() {
    if (_pageController.position.pixels >= _pageController.position.maxScrollExtent - 200) {
      _loadMoreReels();
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      extendBodyBehindAppBar: true,
      body: _reels.isEmpty && _isLoading
          ? const Center(child: CircularProgressIndicator(color: Colors.white))
          : PageView.builder(
              controller: _pageController,
              scrollDirection: Axis.vertical,
              itemCount: _reels.length + (_isLoading ? 1 : 0),
              itemBuilder: (context, index) {
                if (index == _reels.length) {
                  return const Center(child: CircularProgressIndicator(color: Colors.white));
                }
                return ReelItem(reel: _reels[index]);
              },
            ),
    );
  }
}
