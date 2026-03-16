import 'user_model.dart';

enum PostType { image, carousel, reel }

class PostModel {
  final String id;
  final UserModel user;
  final List<String> imageUrls;
  final String caption;
  final String location;
  final int likeCount;
  final int commentCount;
  final DateTime timestamp;
  final bool isLiked;
  final bool isBookmarked;
  final PostType type;
  final String? likedByUsername;

  const PostModel({
    required this.id,
    required this.user,
    required this.imageUrls,
    required this.caption,
    this.location = '',
    this.likeCount = 0,
    this.commentCount = 0,
    required this.timestamp,
    this.isLiked = false,
    this.isBookmarked = false,
    this.type = PostType.image,
    this.likedByUsername,
  });

  String get formattedLikes {
    if (likeCount >= 1000000) {
      return '${(likeCount / 1000000).toStringAsFixed(1)}M likes';
    } else if (likeCount >= 1000) {
      return '${(likeCount / 1000).toStringAsFixed(1)}K likes';
    }
    return '$likeCount likes';
  }

  String get timeAgo {
    final diff = DateTime.now().difference(timestamp);
    if (diff.inDays > 0) return '${diff.inDays}D AGO';
    if (diff.inHours > 0) return '${diff.inHours}H AGO';
    return '${diff.inMinutes}M AGO';
  }
}
