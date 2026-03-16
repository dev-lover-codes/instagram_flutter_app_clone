import 'package:flutter/material.dart';
import '../core/constants/colors.dart';
import '../core/constants/spacing.dart';
import '../models/story_model.dart';
import '../services/story_repository.dart';
import 'story_avatar.dart';

class StoriesTray extends StatelessWidget {
  final List<StoryModel> stories;
  final VoidCallback? onMyStoryTap;
  final void Function(StoryModel story)? onStoryTap;

  const StoriesTray({
    super.key,
    required this.stories,
    this.onMyStoryTap,
    this.onStoryTap,
  });

  @override
  Widget build(BuildContext context) {
    final currentUser = StoryRepository.currentUser;
    return Container(
      height: kStoryTrayHeight,
      color: kBackground,
      child: ListView(
        scrollDirection: Axis.horizontal,
        padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
        children: [
          // My Story
          Padding(
            padding: const EdgeInsets.only(right: kStorySpacing),
            child: StoryAvatar(
              imageUrl: currentUser.avatarUrl,
              username: 'Your Story',
              isMyStory: true,
              hasStory: false,
              onTap: onMyStoryTap,
            ),
          ),
          // Other stories
          ...stories.map((story) => Padding(
            padding: const EdgeInsets.only(right: kStorySpacing),
            child: StoryAvatar(
              imageUrl: story.user.avatarUrl,
              username: story.user.username,
              hasStory: true,
              isSeen: story.isSeen,
              isLive: story.user.isLive,
              onTap: () => onStoryTap?.call(story),
            ),
          )),
        ],
      ),
    );
  }
}
