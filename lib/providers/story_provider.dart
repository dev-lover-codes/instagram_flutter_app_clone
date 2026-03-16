import 'package:flutter/material.dart';
import '../models/story_model.dart';
import '../services/story_repository.dart';

class StoryProvider extends ChangeNotifier {
  List<StoryModel> _stories = [];
  bool _isLoading = false;

  List<StoryModel> get stories => _stories;
  bool get isLoading => _isLoading;

  StoryProvider() {
    loadStories();
  }

  Future<void> loadStories() async {
    _isLoading = true;
    notifyListeners();
    await Future.delayed(const Duration(milliseconds: 300));
    _stories = StoryRepository.getStories();
    _isLoading = false;
    notifyListeners();
  }

  void markSeen(String storyId) {
    _stories = _stories.map((s) {
      if (s.id == storyId) {
        return StoryModel(
          id: s.id,
          user: s.user,
          imageUrl: s.imageUrl,
          timestamp: s.timestamp,
          isSeen: true,
        );
      }
      return s;
    }).toList();
    notifyListeners();
  }
}
