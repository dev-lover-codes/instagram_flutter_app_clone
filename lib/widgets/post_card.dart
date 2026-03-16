import 'package:flutter/material.dart';
import 'package:cached_network_image/cached_network_image.dart';
import '../core/constants/colors.dart';
import '../models/post_model.dart';
import 'post_header.dart';
import 'post_carousel.dart';
import 'post_actions.dart';

class PostCard extends StatefulWidget {
  final PostModel post;
  final VoidCallback onLike;
  final VoidCallback onBookmark;
  final VoidCallback? onUserTap;

  const PostCard({
    super.key,
    required this.post,
    required this.onLike,
    required this.onBookmark,
    this.onUserTap,
  });

  @override
  State<PostCard> createState() => _PostCardState();
}

class _PostCardState extends State<PostCard> {
  int _page = 0;

  @override
  Widget build(BuildContext context) {
    final post = widget.post;
    final w = MediaQuery.of(context).size.width;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        PostHeader(
          user: post.user,
          location: post.location,
          onUserTap: widget.onUserTap,
        ),
        // Image
        if (post.imageUrls.length > 1)
          PostCarousel(imageUrls: post.imageUrls)
        else
          GestureDetector(
            onDoubleTap: widget.onLike,
            child: CachedNetworkImage(
              imageUrl: post.imageUrls.first,
              width: w,
              height: w,
              fit: BoxFit.cover,
              placeholder: (_, __) => Container(
                width: w,
                height: w,
                color: kShimmerBase,
              ),
              errorWidget: (_, __, ___) => Container(
                width: w,
                height: w,
                color: kShimmerBase,
                child: const Icon(Icons.broken_image, color: kTextSecondary),
              ),
            ),
          ),
        PostActions(
          post: post,
          onLike: widget.onLike,
          onBookmark: widget.onBookmark,
          currentCarouselPage: _page,
          totalCarouselPages: post.imageUrls.length,
        ),
        const Divider(height: 0, thickness: 0.33),
      ],
    );
  }
}
