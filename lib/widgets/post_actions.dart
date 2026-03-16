import 'package:flutter/material.dart';
import '../core/constants/colors.dart';
import '../core/constants/typography.dart';
import '../models/post_model.dart';

class PostActions extends StatelessWidget {
  final PostModel post;
  final VoidCallback onLike;
  final VoidCallback onBookmark;
  final int currentCarouselPage;
  final int totalCarouselPages;

  const PostActions({
    super.key,
    required this.post,
    required this.onLike,
    required this.onBookmark,
    this.currentCarouselPage = 0,
    this.totalCarouselPages = 1,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(12, 8, 12, 4),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Action buttons row
          Row(
            children: [
              // Like
              GestureDetector(
                onTap: onLike,
                child: AnimatedSwitcher(
                  duration: const Duration(milliseconds: 200),
                  child: Icon(
                    post.isLiked ? Icons.favorite : Icons.favorite_border,
                    key: ValueKey(post.isLiked),
                    color: post.isLiked ? kRed : kTextPrimary,
                    size: 26,
                  ),
                ),
              ),
              const SizedBox(width: 16),
              // Comment
              const Icon(Icons.chat_bubble_outline, color: kTextPrimary, size: 24),
              const SizedBox(width: 16),
              // Share
              const RotatedBox(
                quarterTurns: 0,
                child: Icon(Icons.send_outlined, color: kTextPrimary, size: 24),
              ),
              const Spacer(),
              // Carousel dots
              if (totalCarouselPages > 1) ...[
                Row(
                  children: List.generate(totalCarouselPages, (i) => Container(
                    width: 6,
                    height: 6,
                    margin: const EdgeInsets.symmetric(horizontal: 2),
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      color: i == currentCarouselPage ? kBlue : const Color(0x66FFFFFF),
                    ),
                  )),
                ),
                const Spacer(),
              ],
              // Bookmark
              GestureDetector(
                onTap: onBookmark,
                child: AnimatedSwitcher(
                  duration: const Duration(milliseconds: 200),
                  child: Icon(
                    post.isBookmarked ? Icons.bookmark : Icons.bookmark_border,
                    key: ValueKey(post.isBookmarked),
                    color: kTextPrimary,
                    size: 24,
                  ),
                ),
              ),
            ],
          ),
          const SizedBox(height: 6),
          // Likes count
          if (post.likedByUsername != null)
            RichText(
              text: TextSpan(
                style: kCaption,
                children: [
                  const TextSpan(text: 'Liked by '),
                  TextSpan(
                    text: post.likedByUsername,
                    style: kCaptionBold,
                  ),
                  const TextSpan(text: ' and '),
                  const TextSpan(text: 'others', style: TextStyle(fontWeight: FontWeight.w600)),
                ],
              ),
            )
          else
            Text(post.formattedLikes, style: kCaptionBold),
          const SizedBox(height: 4),
          // Caption
          RichText(
            text: TextSpan(
              style: kCaption,
              children: [
                TextSpan(
                  text: '${post.user.username} ',
                  style: kCaptionBold,
                ),
                TextSpan(text: post.caption),
              ],
            ),
            maxLines: 2,
            overflow: TextOverflow.ellipsis,
          ),
          const SizedBox(height: 4),
          // Timestamp
          Text(
            post.timeAgo,
            style: kTiny.copyWith(letterSpacing: 0.5),
          ),
          const SizedBox(height: 8),
        ],
      ),
    );
  }
}
