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
  final _scrollCtrl = ScrollController();
  int _page = 0;

  @override
  void initState() {
    super.initState();
    _scrollCtrl.addListener(_onScroll);
    WidgetsBinding.instance.addPostFrameCallback((_) {
      context.read<PostProvider>().loadPosts();
      context.read<StoryProvider>().loadStories();
    });
  }

  @override
  void dispose() {
    _scrollCtrl.dispose();
    super.dispose();
  }

  void _onScroll() {
    if (_scrollCtrl.position.pixels >= _scrollCtrl.position.maxScrollExtent - 500) {
      final postProv = context.read<PostProvider>();
      if (!postProv.isLoading) {
        _page++;
        postProv.loadPosts(page: _page);
      }
    }
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
          _page = 0;
          await Future.wait([
            context.read<PostProvider>().loadPosts(page: 0),
            context.read<StoryProvider>().loadStories(),
          ]);
        },
        child: Consumer2<PostProvider, StoryProvider>(
          builder: (context, postProv, storyProv, _) {
            if (postProv.isLoading && _page == 0) {
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
              controller: _scrollCtrl,
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
                      if (index == postProv.posts.length) {
                        return const Padding(
                          padding: EdgeInsets.symmetric(vertical: 24),
                          child: Center(
                            child: CircularProgressIndicator(color: kTextSecondary),
                          ),
                        );
                      }
                      final post = postProv.posts[index];
                      return PostCard(
                        post: post,
                        onLike: () => postProv.toggleLike(post.id),
                        onBookmark: () => postProv.toggleBookmark(post.id),
                      );
                    },
                    childCount: postProv.posts.length + (postProv.isLoading && _page > 0 ? 1 : 0),
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
