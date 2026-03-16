import 'package:flutter/material.dart';
import 'post_provider.dart';
import 'story_provider.dart';

class FeedProvider extends ChangeNotifier {
  final PostProvider postProvider;
  final StoryProvider storyProvider;

  FeedProvider({required this.postProvider, required this.storyProvider}) {
    refresh();
  }

  bool get isLoading => postProvider.isLoading || storyProvider.isLoading;

  Future<void> refresh() async {
    await Future.wait([
      postProvider.loadPosts(),
      storyProvider.loadStories(),
    ]);
   notifyListeners();
  }
}
