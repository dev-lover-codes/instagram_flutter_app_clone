import 'user_model.dart';

class StoryModel {
  final String id;
  final UserModel user;
  final String imageUrl;
  final DateTime timestamp;
  final bool isSeen;

  const StoryModel({
    required this.id,
    required this.user,
    required this.imageUrl,
    required this.timestamp,
    this.isSeen = false,
  });
}
