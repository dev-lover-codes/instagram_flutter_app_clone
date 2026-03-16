import 'package:flutter/material.dart';
import 'package:flutter/gestures.dart';
import '../core/constants/colors.dart';

class ZoomableImage extends StatelessWidget {
  final Widget child;

  const ZoomableImage({super.key, required this.child});

  @override
  Widget build(BuildContext context) {
    return InteractiveViewer(
      minScale: 1,
      maxScale: 4,
      child: child,
    );
  }
}
