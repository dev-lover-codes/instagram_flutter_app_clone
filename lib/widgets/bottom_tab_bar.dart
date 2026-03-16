import 'package:flutter/material.dart';
import 'package:cached_network_image/cached_network_image.dart';
import '../core/constants/colors.dart';
import '../services/story_repository.dart';

class BottomTabBar extends StatelessWidget {
  final int currentIndex;
  final ValueChanged<int> onTap;

  const BottomTabBar({
    super.key,
    required this.currentIndex,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 79,
      color: kSurface,
      child: Row(
        children: [
          _TabItem(
            icon: Icons.home,
            iconOutline: Icons.home_outlined,
            isActive: currentIndex == 0,
            onTap: () => onTap(0),
          ),
          _TabItem(
            icon: Icons.search,
            iconOutline: Icons.search,
            isActive: currentIndex == 1,
            onTap: () => onTap(1),
          ),
          _AddItem(onTap: () => onTap(2)),
          _TabItem(
            icon: Icons.movie,
            iconOutline: Icons.movie_outlined,
            isActive: currentIndex == 3,
            onTap: () => onTap(3),
          ),
          _ProfileItem(
            avatarUrl: StoryRepository.currentUser.avatarUrl,
            isActive: currentIndex == 4,
            onTap: () => onTap(4),
          ),
        ],
      ),
    );
  }
}

class _TabItem extends StatelessWidget {
  final IconData icon;
  final IconData iconOutline;
  final bool isActive;
  final VoidCallback onTap;

  const _TabItem({
    required this.icon,
    required this.iconOutline,
    required this.isActive,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: GestureDetector(
        behavior: HitTestBehavior.opaque,
        onTap: onTap,
        child: Padding(
          padding: const EdgeInsets.only(top: 8),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              Icon(
                isActive ? icon : iconOutline,
                color: kTextPrimary,
                size: 26,
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class _AddItem extends StatelessWidget {
  final VoidCallback onTap;
  const _AddItem({required this.onTap});

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: GestureDetector(
        behavior: HitTestBehavior.opaque,
        onTap: onTap,
        child: Padding(
          padding: const EdgeInsets.only(top: 8),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              Container(
                width: 26,
                height: 26,
                decoration: BoxDecoration(
                  border: Border.all(color: kTextPrimary, width: 2),
                  borderRadius: BorderRadius.circular(6),
                ),
                child: const Icon(Icons.add, color: kTextPrimary, size: 16),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class _ProfileItem extends StatelessWidget {
  final String avatarUrl;
  final bool isActive;
  final VoidCallback onTap;

  const _ProfileItem({
    required this.avatarUrl,
    required this.isActive,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: GestureDetector(
        behavior: HitTestBehavior.opaque,
        onTap: onTap,
        child: Padding(
          padding: const EdgeInsets.only(top: 8),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              Container(
                width: 26,
                height: 26,
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  border: Border.all(
                    color: isActive ? kTextPrimary : Colors.transparent,
                    width: 2,
                  ),
                ),
                child: ClipOval(
                  child: CachedNetworkImage(
                    imageUrl: avatarUrl,
                    fit: BoxFit.cover,
                    placeholder: (_, __) => Container(color: kShimmerBase),
                    errorWidget: (_, __, ___) => const Icon(Icons.person, color: kTextSecondary, size: 16),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
