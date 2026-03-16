import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../core/constants/colors.dart';
import '../providers/post_provider.dart';
import '../providers/story_provider.dart';
import '../widgets/top_bar.dart';
import '../widgets/stories_tray.dart';
import '../widgets/post_card.dart';
import '../widgets/shimmer_post.dart';
import 'story_viewer_screen.dart';

class HomeFeedScreen extends StatefulWidget {
  const HomeFeedScreen({super.key});

  @override
  State<HomeFeedScreen> createState() => _HomeFeedScreenState();
}

class _HomeFeedScreenState extends State<HomeFeedScreen> {
  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      context.read<PostProvider>().loadPosts();
      context.read<StoryProvider>().loadStories();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: kBackground,
      appBar: const TopBar(),
      body: RefreshIndicator(
        color: kBlue,
        backgroundColor: kSurface,
        onRefresh: () async {
          await Future.wait([
            context.read<PostProvider>().loadPosts(),
            context.read<StoryProvider>().loadStories(),
          ]);
        },
        child: Consumer2<PostProvider, StoryProvider>(
          builder: (context, postProv, storyProv, _) {
            if (postProv.isLoading) {
              return ListView(
                children: [
                  // Shimmer stories
                  SizedBox(
                    height: 98,
                    child: ListView.builder(
                      scrollDirection: Axis.horizontal,
                      padding: const EdgeInsets.symmetric(horizontal: 8),
                      itemCount: 5,
                      itemBuilder: (_, __) => const ShimmerStory(),
                    ),
                  ),
                  const Divider(height: 0, thickness: 0.33),
                  const ShimmerPost(),
                  const ShimmerPost(),
                ],
              );
            }
            return CustomScrollView(
              slivers: [
                // Stories tray
                SliverToBoxAdapter(
                  child: Column(
                    children: [
                      StoriesTray(
                        stories: storyProv.stories,
                        onMyStoryTap: () {},
                        onStoryTap: (story) {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (_) => StoryViewerScreen(
                                stories: storyProv.stories,
                                initialIndex: storyProv.stories.indexOf(story),
                              ),
                            ),
                          );
                        },
                      ),
                      const Divider(height: 0, thickness: 0.33),
                    ],
                  ),
                ),
                // Posts
                SliverList(
                  delegate: SliverChildBuilderDelegate(
                    (context, index) {
                      final post = postProv.posts[index];
                      return PostCard(
                        post: post,
                        onLike: () => postProv.toggleLike(post.id),
                        onBookmark: () => postProv.toggleBookmark(post.id),
                      );
                    },
                    childCount: postProv.posts.length,
                  ),
                ),
              ],
            );
          },
        ),
      ),
    );
  }
}
