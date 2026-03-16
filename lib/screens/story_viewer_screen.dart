import 'package:flutter/material.dart';
import 'package:cached_network_image/cached_network_image.dart';
import '../core/constants/colors.dart';
import '../core/constants/typography.dart';
import '../models/story_model.dart';

class StoryViewerScreen extends StatefulWidget {
  final List<StoryModel> stories;
  final int initialIndex;

  const StoryViewerScreen({
    super.key,
    required this.stories,
    this.initialIndex = 0,
  });

  @override
  State<StoryViewerScreen> createState() => _StoryViewerScreenState();
}

class _StoryViewerScreenState extends State<StoryViewerScreen>
    with SingleTickerProviderStateMixin {
  late int _currentIndex;
  late AnimationController _progressCtrl;

  @override
  void initState() {
    super.initState();
    _currentIndex = widget.initialIndex;
    _progressCtrl = AnimationController(
      vsync: this,
      duration: const Duration(seconds: 5),
    )
      ..addStatusListener((status) {
        if (status == AnimationStatus.completed) _advance();
      })
      ..forward();
  }

  @override
  void dispose() {
    _progressCtrl.dispose();
    super.dispose();
  }

  void _advance() {
    if (_currentIndex < widget.stories.length - 1) {
      setState(() => _currentIndex++);
      _progressCtrl.forward(from: 0);
    } else {
      Navigator.pop(context);
    }
  }

  void _goBack() {
    if (_currentIndex > 0) {
      setState(() => _currentIndex--);
      _progressCtrl.forward(from: 0);
    }
  }

  @override
  Widget build(BuildContext context) {
    final story = widget.stories[_currentIndex];
    return Scaffold(
      backgroundColor: Colors.black,
      body: GestureDetector(
        onTapUp: (details) {
          final w = MediaQuery.of(context).size.width;
          if (details.globalPosition.dx < w / 2) {
            _goBack();
          } else {
            _advance();
          }
        },
        child: Stack(
          fit: StackFit.expand,
          children: [
            // Background
            CachedNetworkImage(
              imageUrl: story.imageUrl,
              fit: BoxFit.cover,
              placeholder: (_, __) => Container(color: kBackground),
              errorWidget: (_, __, ___) => Container(color: kBackground),
            ),
            // Gradient overlay
            Container(
              decoration: const BoxDecoration(
                gradient: LinearGradient(
                  begin: Alignment.topCenter,
                  end: Alignment.bottomCenter,
                  colors: [Color(0x66000000), Colors.transparent, Color(0x99000000)],
                  stops: [0, 0.4, 1],
                ),
              ),
            ),
            // Top: Progress + user info
            Positioned(
              top: MediaQuery.of(context).padding.top + 8,
              left: 12,
              right: 12,
              child: Column(
                children: [
                  // Progress bars
                  Row(
                    children: List.generate(widget.stories.length, (i) {
                      return Expanded(
                        child: Container(
                          margin: const EdgeInsets.symmetric(horizontal: 1.5),
                          height: 2,
                          child: LinearProgressIndicator(
                            value: i < _currentIndex
                                ? 1
                                : i == _currentIndex
                                    ? _progressCtrl.value
                                    : 0,
                            backgroundColor: Colors.white30,
                            valueColor: const AlwaysStoppedAnimation<Color>(Colors.white),
                            borderRadius: BorderRadius.circular(2),
                          ),
                        ),
                      );
                    }),
                  ),
                  const SizedBox(height: 12),
                  // User row
                  Row(
                    children: [
                      ClipOval(
                        child: CachedNetworkImage(
                          imageUrl: story.user.avatarUrl,
                          width: 32,
                          height: 32,
                          fit: BoxFit.cover,
                          placeholder: (_, __) => Container(width: 32, height: 32, color: kShimmerBase),
                        ),
                      ),
                      const SizedBox(width: 8),
                      Text(story.user.username, style: kBodyBold),
                      const SizedBox(width: 8),
                      Text('2h', style: kTiny),
                      const Spacer(),
                      const Icon(Icons.volume_up, color: Colors.white, size: 22),
                      const SizedBox(width: 16),
                      GestureDetector(
                        onTap: () => Navigator.pop(context),
                        child: const Icon(Icons.close, color: Colors.white, size: 22),
                      ),
                    ],
                  ),
                ],
              ),
            ),
            // Bottom: message input + reactions
            Positioned(
              bottom: MediaQuery.of(context).padding.bottom + 16,
              left: 16,
              right: 16,
              child: Column(
                children: [
                  Row(
                    children: [
                      Expanded(
                        child: Container(
                          height: 48,
                          decoration: BoxDecoration(
                            border: Border.all(color: Colors.white60),
                            borderRadius: BorderRadius.circular(24),
                            color: Colors.white10,
                          ),
                          alignment: Alignment.centerLeft,
                          padding: const EdgeInsets.symmetric(horizontal: 16),
                          child: Text('Send message...', style: kBody.copyWith(color: Colors.white54)),
                        ),
                      ),
                      const SizedBox(width: 12),
                      const Icon(Icons.send_outlined, color: Colors.white, size: 26),
                      const SizedBox(width: 12),
                      const Icon(Icons.more_horiz, color: Colors.white, size: 26),
                    ],
                  ),
                  const SizedBox(height: 16),
                  // Quick reactions
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: ['❤️', '🙌', '🔥', '👏', '😢', '😮', '😂', '😍']
                        .map((e) => Text(e, style: const TextStyle(fontSize: 26)))
                        .toList(),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
