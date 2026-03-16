import 'package:flutter/material.dart';
import '../core/constants/typography.dart';

class SectionHeader extends StatelessWidget {
  final String title;
  final EdgeInsets padding;

  const SectionHeader({
    super.key,
    required this.title,
    this.padding = const EdgeInsets.fromLTRB(16, 12, 16, 4),
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: padding,
      child: Text(title, style: kBodyBold),
    );
  }
}
