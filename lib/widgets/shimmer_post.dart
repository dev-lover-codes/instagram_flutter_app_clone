import 'package:flutter/material.dart';
import 'package:shimmer/shimmer.dart';
import '../core/constants/colors.dart';

class ShimmerPost extends StatelessWidget {
  const ShimmerPost({super.key});

  @override
  Widget build(BuildContext context) {
    final w = MediaQuery.of(context).size.width;
    return Shimmer.fromColors(
      baseColor: kShimmerBase,
      highlightColor: kShimmerHighlight,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Header
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 11),
            child: Row(
              children: [
                const CircleAvatar(radius: 16, backgroundColor: kShimmerBase),
                const SizedBox(width: 8),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Container(width: 100, height: 11, color: kShimmerBase),
                    const SizedBox(height: 4),
                    Container(width: 60, height: 9, color: kShimmerBase),
                  ],
                ),
              ],
            ),
          ),
          // Image
          Container(width: w, height: w, color: kShimmerBase),
          // Actions
          Padding(
            padding: const EdgeInsets.fromLTRB(12, 10, 12, 4),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(children: [
                  Container(width: 24, height: 24, color: kShimmerBase),
                  const SizedBox(width: 16),
                  Container(width: 24, height: 24, color: kShimmerBase),
                  const SizedBox(width: 16),
                  Container(width: 24, height: 24, color: kShimmerBase),
                  const Spacer(),
                  Container(width: 24, height: 24, color: kShimmerBase),
                ]),
                const SizedBox(height: 8),
                Container(width: 120, height: 11, color: kShimmerBase),
                const SizedBox(height: 6),
                Container(width: w * 0.7, height: 11, color: kShimmerBase),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class ShimmerStory extends StatelessWidget {
  const ShimmerStory({super.key});

  @override
  Widget build(BuildContext context) {
    return Shimmer.fromColors(
      baseColor: kShimmerBase,
      highlightColor: kShimmerHighlight,
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 6),
        child: Column(
          children: [
            const CircleAvatar(radius: 30, backgroundColor: kShimmerBase),
            const SizedBox(height: 4),
            Container(width: 54, height: 9, color: kShimmerBase),
          ],
        ),
      ),
    );
  }
}
