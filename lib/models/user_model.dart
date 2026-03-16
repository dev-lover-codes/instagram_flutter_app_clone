import 'package:flutter/material.dart';

class UserModel {
  final String id;
  final String username;
  final String displayName;
  final String avatarUrl;
  final bool isVerified;
  final bool hasStory;
  final bool isLive;
  final int postCount;
  final int followerCount;
  final int followingCount;
  final String bio;
  final String website;

  const UserModel({
    required this.id,
    required this.username,
    required this.displayName,
    required this.avatarUrl,
    this.isVerified = false,
    this.hasStory = false,
    this.isLive = false,
    this.postCount = 0,
    this.followerCount = 0,
    this.followingCount = 0,
    this.bio = '',
    this.website = '',
  });
}
