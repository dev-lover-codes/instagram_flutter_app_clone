import 'package:flutter/material.dart';
import '../core/constants/colors.dart';

class TopBar extends StatelessWidget implements PreferredSizeWidget {
  const TopBar({super.key});

  @override
  Size get preferredSize => const Size.fromHeight(88);

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 88,
      color: kSurface,
      padding: EdgeInsets.only(
        top: MediaQuery.of(context).padding.top,
        left: 16,
        right: 16,
        bottom: 8,
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.end,
        children: [
          // Camera icon
          GestureDetector(
            onTap: () {},
            child: const Icon(Icons.camera_alt_outlined, color: kTextPrimary, size: 26),
          ),
          const Spacer(),
          // Instagram logo text
          Text(
            'Instagram',
            style: TextStyle(
              fontFamily: 'Billabong',
              fontSize: 32,
              color: kTextPrimary,
              height: 1.0,
            ),
          ),
          const Spacer(),
          Row(
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [
              Stack(
                clipBehavior: Clip.none,
                children: [
                  const Icon(Icons.live_tv_outlined, color: kTextPrimary, size: 26),
                  Positioned(
                    top: -4,
                    right: -4,
                    child: Container(
                      width: 8,
                      height: 8,
                      decoration: const BoxDecoration(
                        color: kRed,
                        shape: BoxShape.circle,
                      ),
                    ),
                  ),
                ],
              ),
              const SizedBox(width: 20),
              const Icon(Icons.send_outlined, color: kTextPrimary, size: 26),
            ],
          ),
        ],
      ),
    );
  }
}
