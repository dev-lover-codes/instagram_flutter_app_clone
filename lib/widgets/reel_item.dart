import 'package:flutter/material.dart';
import 'package:cached_network_image/cached_network_image.dart';
import '../core/constants/colors.dart';
import '../core/constants/typography.dart';
import '../models/post_model.dart';

class ReelItem extends StatelessWidget {
  final PostModel reel;
  final VoidCallback? onFollow;

  const ReelItem({super.key, required this.reel, this.onFollow});

  String _formatCount(int count) {
    if (count >= 1000000) return '${(count / 1000000).toStringAsFixed(1)}M';
    if (count >= 1000) return '${(count / 1000).toStringAsFixed(1)}K';
    return '$count';
  }

  @override
  Widget build(BuildContext context) {
    return Stack(
      fit: StackFit.expand,
      children: [
        // Background full-screen image (simulating video)
        CachedNetworkImage(
          imageUrl: reel.imageUrls.first,
          fit: BoxFit.cover,
          placeholder: (_, __) => Container(color: kBackground),
          errorWidget: (_, __, ___) => Container(color: kBackground),
        ),
        // Gradient overlays
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
        // Top: Reels header
        Positioned(
          top: MediaQuery.of(context).padding.top + 8,
          left: 0,
          right: 0,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const SizedBox(width: 48),
              const Spacer(),
              Text('Reels', style: kSubheading),
              const Spacer(),
              Row(
                children: const [
                  Icon(Icons.camera_alt_outlined, color: kTextPrimary, size: 24),
                  SizedBox(width: 16),
                  Icon(Icons.more_vert, color: kTextPrimary, size: 24),
                ],
              ),
              const SizedBox(width: 12),
            ],
          ),
        ),
        // Right side actions
        Positioned(
          right: 12,
          bottom: 100,
          child: Column(
            children: [
              _ActionButton(
                icon: Icons.favorite_border,
                label: _formatCount(reel.likeCount),
                onTap: () {},
              ),
              const SizedBox(height: 20),
              _ActionButton(
                icon: Icons.chat_bubble_outline,
                label: _formatCount(reel.commentCount),
                onTap: () {},
              ),
              const SizedBox(height: 20),
              _ActionButton(
                icon: Icons.send_outlined,
                label: 'Share',
                onTap: () {},
              ),
              const SizedBox(height: 20),
              const Icon(Icons.more_horiz, color: kTextPrimary, size: 28),
              const SizedBox(height: 20),
              // Music disc
              Container(
                width: 40,
                height: 40,
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  border: Border.all(color: Colors.white, width: 2),
                ),
                child: ClipOval(
                  child: CachedNetworkImage(
                    imageUrl: reel.user.avatarUrl,
                    fit: BoxFit.cover,
                    placeholder: (_, __) => Container(color: kShimmerBase),
                  ),
                ),
              ),
            ],
          ),
        ),
        // Bottom: user info + caption
        Positioned(
          bottom: 16,
          left: 12,
          right: 80,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                children: [
                  ClipOval(
                    child: CachedNetworkImage(
                      imageUrl: reel.user.avatarUrl,
                      width: 32,
                      height: 32,
                      fit: BoxFit.cover,
                      placeholder: (_, __) => Container(color: kShimmerBase),
                    ),
                  ),
                  const SizedBox(width: 8),
                  Text('@${reel.user.username}', style: kBodyBold),
                  const SizedBox(width: 8),
                  GestureDetector(
                    onTap: onFollow,
                    child: Container(
                      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 3),
                      decoration: BoxDecoration(
                        border: Border.all(color: Colors.white),
                        borderRadius: BorderRadius.circular(6),
                      ),
                      child: Text('Follow', style: kCaptionBold),
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 8),
              Text(
                reel.caption,
                style: kBody,
                maxLines: 2,
                overflow: TextOverflow.ellipsis,
              ),
              const SizedBox(height: 8),
              Row(
                children: [
                  const Icon(Icons.music_note, color: kTextPrimary, size: 14),
                  const SizedBox(width: 6),
                  Text('Original Audio · ${reel.user.username}', style: kSmall),
                ],
              ),
            ],
          ),
        ),
        // Progress bar
        Positioned(
          bottom: 0,
          left: 0,
          right: 0,
          child: Column(
            children: [
              Stack(
                children: [
                  Container(height: 2, color: Colors.white24),
                  Container(height: 2, width: MediaQuery.of(context).size.width * 0.45, color: Colors.white),
                ],
              ),
            ],
          ),
        ),
      ],
    );
  }
}

class _ActionButton extends StatelessWidget {
  final IconData icon;
  final String label;
  final VoidCallback? onTap;

  const _ActionButton({required this.icon, required this.label, this.onTap});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Column(
        children: [
          Icon(icon, color: kTextPrimary, size: 28),
          const SizedBox(height: 4),
          Text(label, style: const TextStyle(color: kTextPrimary, fontSize: 12, fontWeight: FontWeight.w500)),
        ],
      ),
    );
  }
}
