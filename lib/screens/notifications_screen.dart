import 'package:flutter/material.dart';
import '../core/constants/colors.dart';
import '../core/constants/typography.dart';
import '../widgets/notification_item.dart';
import '../widgets/section_header.dart';
import '../services/story_repository.dart';
import '../services/post_repository.dart';

class NotificationsScreen extends StatelessWidget {
  const NotificationsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final users = StoryRepository.sampleUsers;
    final posts = PostRepository.getExploreImages();

    return Scaffold(
      backgroundColor: kBackground,
      body: CustomScrollView(
        slivers: [
          // Header
          SliverAppBar(
            pinned: true,
            backgroundColor: kSurface,
            elevation: 0,
            title: Text('Notifications', style: kHeading),
            bottom: PreferredSize(
              preferredSize: const Size.fromHeight(0.5),
              child: Container(height: 0.5, color: kDivider),
            ),
          ),
          // New section
          const SliverToBoxAdapter(child: SectionHeader(title: 'New')),
          SliverList(
            delegate: SliverChildListDelegate([
              NotificationItem(
                avatarUrl: users[4].avatarUrl,
                username: users[4].username,
                action: 'liked your photo.',
                timeAgo: '2m',
                postImageUrl: posts[0],
              ),
              NotificationItem(
                avatarUrl: users[1].avatarUrl,
                username: users[1].username,
                action: 'started following you.',
                timeAgo: '15m',
                showFollowBack: true,
              ),
              NotificationItem(
                avatarUrl: users[2].avatarUrl,
                username: users[2].username,
                action: 'commented: Amazing shot! 🔥',
                timeAgo: '1h',
                postImageUrl: posts[1],
              ),
            ]),
          ),
          const SliverToBoxAdapter(child: Divider(thickness: 0.5, height: 0)),
          // This Week section
          const SliverToBoxAdapter(child: SectionHeader(title: 'This Week')),
          SliverList(
            delegate: SliverChildListDelegate([
              NotificationItem(
                avatarUrl: users[0].avatarUrl,
                username: 'craig_love',
                action: 'mentioned you in a comment: @you should visit this place!',
                timeAgo: '3h',
                postImageUrl: posts[2],
              ),
              NotificationItem(
                avatarUrl: users[3].avatarUrl,
                username: 'karennne',
                action: 'liked your comment: The game was incredible 🏆',
                timeAgo: '5h',
                postImageUrl: posts[3],
              ),
              NotificationItem(
                avatarUrl: users[1].avatarUrl,
                username: 'marcus_g',
                action: 'liked your photo.',
                timeAgo: '1d',
                postImageUrl: posts[4],
              ),
              NotificationItem(
                avatarUrl: users[2].avatarUrl,
                username: 'dan.photography',
                action: 'liked your photo.',
                timeAgo: '2d',
                postImageUrl: posts[5],
              ),
            ]),
          ),
          const SliverToBoxAdapter(child: SizedBox(height: 24)),
        ],
      ),
    );
  }
}
