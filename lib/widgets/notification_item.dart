import 'package:flutter/material.dart';
import '../core/constants/colors.dart';
import '../core/constants/typography.dart';
import '../models/post_model.dart';

class NotificationItem extends StatelessWidget {
  final String avatarUrl;
  final String username;
  final String action;
  final String timeAgo;
  final String? postImageUrl;
  final bool showFollowBack;
  final PostModel? post;

  const NotificationItem({
    super.key,
    required this.avatarUrl,
    required this.username,
    required this.action,
    required this.timeAgo,
    this.postImageUrl,
    this.showFollowBack = false,
    this.post,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 72,
      padding: const EdgeInsets.symmetric(horizontal: 16),
      child: Row(
        children: [
          // Avatar
          ClipOval(
            child: Image.network(
              avatarUrl,
              width: 44,
              height: 44,
              fit: BoxFit.cover,
              errorBuilder: (_, __, ___) => Container(
                width: 44,
                height: 44,
                color: kShimmerBase,
                child: const Icon(Icons.person, color: kTextSecondary),
              ),
            ),
          ),
          const SizedBox(width: 12),
          // Text
          Expanded(
            child: RichText(
              text: TextSpan(
                style: kCaption,
                children: [
                  TextSpan(text: username, style: kCaptionBold),
                  TextSpan(text: ' $action '),
                  TextSpan(
                    text: timeAgo,
                    style: kTiny,
                  ),
                ],
              ),
            ),
          ),
          const SizedBox(width: 12),
          // Trailing: post thumbnail OR follow back button
          if (showFollowBack)
            Container(
              width: 104,
              height: 32,
              decoration: BoxDecoration(
                border: Border.all(color: kDivider),
                borderRadius: BorderRadius.circular(8),
              ),
              alignment: Alignment.center,
              child: Text('Follow Back', style: kCaptionBold),
            )
          else if (postImageUrl != null)
            ClipRRect(
              borderRadius: BorderRadius.circular(4),
              child: Image.network(
                postImageUrl!,
                width: 44,
                height: 44,
                fit: BoxFit.cover,
                errorBuilder: (_, __, ___) => Container(
                  width: 44,
                  height: 44,
                  color: kShimmerBase,
                ),
              ),
            ),
        ],
      ),
    );
  }
}
