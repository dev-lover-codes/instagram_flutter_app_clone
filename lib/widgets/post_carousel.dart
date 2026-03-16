import 'package:flutter/material.dart';
import 'package:cached_network_image/cached_network_image.dart';
import '../core/constants/colors.dart';
import 'zoomable_image.dart';

class PostCarousel extends StatefulWidget {
  final List<String> imageUrls;
  final ValueChanged<int>? onPageChanged;

  const PostCarousel({super.key, required this.imageUrls, this.onPageChanged});

  @override
  State<PostCarousel> createState() => _PostCarouselState();
}

class _PostCarouselState extends State<PostCarousel> {
  int _currentPage = 0;
  final PageController _controller = PageController();

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final w = MediaQuery.of(context).size.width;
    return Stack(
      children: [
        SizedBox(
          width: w,
          height: w,
          child: PageView.builder(
            controller: _controller,
            itemCount: widget.imageUrls.length,
            onPageChanged: (p) {
              setState(() => _currentPage = p);
              if (widget.onPageChanged != null) widget.onPageChanged!(p);
            },
            itemBuilder: (_, i) => ZoomableImage(
              child: CachedNetworkImage(
                imageUrl: widget.imageUrls[i],
                width: w,
                height: w,
                fit: BoxFit.cover,
                placeholder: (_, __) => Container(color: kShimmerBase),
                errorWidget: (_, __, ___) => Container(
                  color: kShimmerBase,
                  child: const Icon(Icons.broken_image, color: kTextSecondary),
                ),
              ),
            ),
          ),
        ),
        // Page indicator (top right)
        if (widget.imageUrls.length > 1)
          Positioned(
            top: 12,
            right: 12,
            child: Container(
              padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
              decoration: BoxDecoration(
                color: kOverlay,
                borderRadius: BorderRadius.circular(12),
              ),
              child: Text(
                '${_currentPage + 1}/${widget.imageUrls.length}',
                style: const TextStyle(
                  color: kTextPrimary,
                  fontSize: 12,
                  fontWeight: FontWeight.w600,
                ),
              ),
            ),
          ),
      ],
    );
  }
}
