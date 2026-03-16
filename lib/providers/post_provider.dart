import 'package:flutter/material.dart';
import '../models/post_model.dart';
import '../services/post_repository.dart';

class PostProvider extends ChangeNotifier {
  List<PostModel> _posts = [];
  bool _isLoading = false;

  List<PostModel> get posts => _posts;
  bool get isLoading => _isLoading;

  Future<void> loadPosts({int page = 0}) async {
    if (page == 0) {
      _isLoading = true;
      notifyListeners();
    }
    final newPosts = await PostRepository.getFeedPosts(page: page);
    if (page == 0) {
      _posts = newPosts;
    } else {
      _posts = [..._posts, ...newPosts];
    }
    _isLoading = false;
    notifyListeners();
  }

  void toggleLike(String postId) {
    _posts = _posts.map((p) {
      if (p.id == postId) {
        final liked = !p.isLiked;
        return PostModel(
          id: p.id,
          user: p.user,
          imageUrls: p.imageUrls,
          caption: p.caption,
          location: p.location,
          likeCount: liked ? p.likeCount + 1 : p.likeCount - 1,
          commentCount: p.commentCount,
          timestamp: p.timestamp,
          isLiked: liked,
          isBookmarked: p.isBookmarked,
          type: p.type,
          likedByUsername: p.likedByUsername,
        );
      }
      return p;
    }).toList();
    notifyListeners();
  }

  void toggleBookmark(String postId) {
    _posts = _posts.map((p) {
      if (p.id == postId) {
        return PostModel(
          id: p.id,
          user: p.user,
          imageUrls: p.imageUrls,
          caption: p.caption,
          location: p.location,
          likeCount: p.likeCount,
          commentCount: p.commentCount,
          timestamp: p.timestamp,
          isLiked: p.isLiked,
          isBookmarked: !p.isBookmarked,
          type: p.type,
          likedByUsername: p.likedByUsername,
        );
      }
      return p;
    }).toList();
    notifyListeners();
  }
}
