import 'package:flutter/material.dart';
import 'package:cached_network_image/cached_network_image.dart';
import '../core/constants/colors.dart';
import '../core/constants/typography.dart';
import '../models/user_model.dart';

class PostHeader extends StatelessWidget {
  final UserModel user;
  final String? location;
  final VoidCallback? onMoreTap;
  final VoidCallback? onUserTap;

  const PostHeader({
    super.key,
    required this.user,
    this.location,
    this.onMoreTap,
    this.onUserTap,
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 54,
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 12),
        child: Row(
          children: [
            GestureDetector(
              onTap: onUserTap,
              child: ClipOval(
                child: CachedNetworkImage(
                  imageUrl: user.avatarUrl,
                  width: 32,
                  height: 32,
                  fit: BoxFit.cover,
                  placeholder: (_, __) => Container(
                    width: 32,
                    height: 32,
                    color: kShimmerBase,
                  ),
                  errorWidget: (_, __, ___) => Container(
                    width: 32,
                    height: 32,
                    color: kShimmerBase,
                    child: const Icon(Icons.person, color: kTextSecondary, size: 18),
                  ),
                ),
              ),
            ),
            const SizedBox(width: 8),
            Expanded(
              child: GestureDetector(
                onTap: onUserTap,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      children: [
                        Text(user.username, style: kCaptionBold),
                        if (user.isVerified) ...[
                          const SizedBox(width: 4),
                          Container(
                            width: 12,
                            height: 12,
                            decoration: const BoxDecoration(
                              color: kBlue,
                              shape: BoxShape.circle,
                            ),
                            child: const Icon(
                              Icons.check,
                              color: Colors.white,
                              size: 8,
                            ),
                          ),
                        ],
                      ],
                    ),
                    if (location != null && location!.isNotEmpty)
                      Text(
                        location!,
                        style: kTiny,
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                      ),
                  ],
                ),
              ),
            ),
            GestureDetector(
              onTap: onMoreTap,
              child: const Padding(
                padding: EdgeInsets.all(8),
                child: Icon(Icons.more_horiz, color: kTextPrimary, size: 20),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
