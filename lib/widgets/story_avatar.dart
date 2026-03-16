import 'package:flutter/material.dart';
import 'package:cached_network_image/cached_network_image.dart';
import '../core/constants/colors.dart';

class StoryAvatar extends StatelessWidget {
  final String imageUrl;
  final String username;
  final bool hasStory;
  final bool isSeen;
  final bool isLive;
  final bool isMyStory;
  final double size;
  final VoidCallback? onTap;

  const StoryAvatar({
    super.key,
    required this.imageUrl,
    required this.username,
    this.hasStory = true,
    this.isSeen = false,
    this.isLive = false,
    this.isMyStory = false,
    this.size = 56,
    this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          SizedBox(
            width: size + 8,
            height: size + 10,
            child: Stack(
              alignment: Alignment.center,
              children: [
                // Story ring
                if (hasStory && !isMyStory)
                  Container(
                    width: size + 6,
                    height: size + 6,
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      gradient: isSeen
                          ? null
                          : const LinearGradient(
                              begin: Alignment.topLeft,
                              end: Alignment.bottomRight,
                              colors: [
                                Color(0xFFF09433),
                                Color(0xFFE6683C),
                                Color(0xFFDC2743),
                                Color(0xFFCC2366),
                                kStoryGradientStart,
                              ],
                            ),
                      color: isSeen ? const Color(0x40FFFFFF) : null,
                    ),
                    child: Padding(
                      padding: const EdgeInsets.all(2.5),
                      child: Container(
                        decoration: const BoxDecoration(
                          shape: BoxShape.circle,
                          color: kBackground,
                        ),
                      ),
                    ),
                  ),
                // Avatar image
                ClipOval(
                  child: CachedNetworkImage(
                    imageUrl: imageUrl,
                    width: size,
                    height: size,
                    fit: BoxFit.cover,
                    placeholder: (_, __) => Container(
                      width: size,
                      height: size,
                      color: kShimmerBase,
                    ),
                    errorWidget: (_, __, ___) => Container(
                      width: size,
                      height: size,
                      color: kShimmerBase,
                      child: const Icon(Icons.person, color: kTextSecondary),
                    ),
                  ),
                ),
                // My Story: plus badge
                if (isMyStory)
                  Positioned(
                    bottom: 2,
                    right: 2,
                    child: Container(
                      width: 18,
                      height: 18,
                      decoration: const BoxDecoration(
                        shape: BoxShape.circle,
                        color: kBlue,
                      ),
                      child: const Icon(Icons.add, color: Colors.white, size: 12),
                    ),
                  ),
                // Live badge
                if (isLive)
                  Positioned(
                    bottom: 0,
                    child: Container(
                      padding: const EdgeInsets.symmetric(horizontal: 5, vertical: 1),
                      decoration: const BoxDecoration(
                        gradient: LinearGradient(
                          colors: [Color(0xFFD22463), kStoryGradientEnd],
                        ),
                        borderRadius: BorderRadius.all(Radius.circular(3)),
                      ),
                      child: const Text(
                        'LIVE',
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 8,
                          fontWeight: FontWeight.bold,
                          letterSpacing: 0.5,
                        ),
                      ),
                    ),
                  ),
              ],
            ),
          ),
          const SizedBox(height: 2),
          SizedBox(
            width: size + 8,
            child: Text(
              isMyStory ? 'Your Story' : username,
              textAlign: TextAlign.center,
              maxLines: 1,
              overflow: TextOverflow.ellipsis,
              style: const TextStyle(
                color: kTextPrimary,
                fontSize: 11,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
