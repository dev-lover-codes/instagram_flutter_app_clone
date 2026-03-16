import 'package:flutter/material.dart';
import 'package:cached_network_image/cached_network_image.dart';
import '../core/constants/colors.dart';
import '../core/constants/typography.dart';
import '../services/story_repository.dart';
import '../services/post_repository.dart';

class ProfileScreen extends StatefulWidget {
  const ProfileScreen({super.key});

  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen>
    with SingleTickerProviderStateMixin {
  late final TabController _tabCtrl;
  final user = StoryRepository.currentUser;
  final posts = PostRepository.getProfilePosts();

  final _highlights = [
    {'label': 'Italy', 'img': 'https://lh3.googleusercontent.com/aida-public/AB6AXuBXFBO_uWojInoWUDjU8AzzLkycCje5Ilpn8caya-DveHsr2jIRjHNANxaCmiaYLyM7ztGX1XBorWq1n_YuUTATKtSlu9LVS3xgAQy51DUND0npeM-o8GI6yr0s5lNuDW3UE_oWxnQqHY-Eb_Br4yTU05Zu60Ikh2fDj62dCXlfJkO6hAnhwgOxUyfQmbAkDqTh-k9E_asAnXKQB9vNMTtd85f57fAP_ndzKGxpFGEmOLDOFXusMo8xEMrdK-yRhJTGoHiTf1je7Fk'},
    {'label': 'Food', 'img': 'https://lh3.googleusercontent.com/aida-public/AB6AXuAAkyvB0Brra7sh0TFLPw4fU2tFBu_i-aZx1m4QiGEoU-F89IPqTlLja_Vqb19qAsqwrt_BBd37dSYhi0zQS_If--hp9zMS4GKJ-pqX2nuGNzI-rlmh-01UU_t8uYH3oPvkcXv-y6aQzyWOhxPyb3faKfE1tErHjuSoNgemTeCxaJGhuKj6FpW67PLrc6meB8Lw7AhIY8fA-TWYwDbvRes73ypno4faZ1Nh5cKzyfHqzRgSxht5TwN356_VwZTpHY7VyG6tpX8fiFA'},
    {'label': 'Views', 'img': 'https://lh3.googleusercontent.com/aida-public/AB6AXuAL1wQrsBkYlqtwQyY1x17EAILputnxSmNUD1hg39mHBo2RwICPTnEECjxtObMWldYCpv0hr2rTqoYhylmVsiRALo6kpOUFW92sjjZijYPQyoot_BtJuN9UU4LiHBFIIdhmsP5Vh1WZQSN_VXYpIyvafEFeGGl5WE5aXoEANAn46MXOT3gkVwyWIY41oOfkT-ftH-Pn5OR4ANP1g_iQxQqwUe5k2IzbIPX6lhy-62KJLPh0zZYq-90qRGGmT5k0jL3vKV1fy4pfK9I'},
    {'label': 'Beach', 'img': 'https://lh3.googleusercontent.com/aida-public/AB6AXuD9PRlQQLJz1Ul3OPrGjKkHZr9_5aRD1JigGZY0dXAXCtilT3-uzSyKocKB3bnyx7ZyTfls-JrnQOEJNqnU8NKVdgv3UGTuyiaRMO0_GHCL1VFeDcYBWjVfa4AU8b1t4PMvfH-Lz5trdXhv9zS62HiCXB2VxM3SImb4GsGXGqaRKntH7Bdqx3vGE4AcT0VUa7L6dab7Z3lAX5gFid-75_TD7fObalk4lZWDeXAfPZxN6sofUPiRd1BvyGEBcOESHgJikUYDfSchexI'},
    {'label': 'Nature', 'img': 'https://lh3.googleusercontent.com/aida-public/AB6AXuCLvpomuGfa1vUxkKlzupsaJZ9_-zQlIFhYDMpVDtlkUwnxgBkYyu7697jCic8y_arKhpUEKy65pcmFiY_6G86Wzh_8Sz_vJpn6idFgidO6Qfw9ZJDv2019d7D-fTxiTL1uohU0aEU60398Q8FGGgeTQbrWVVXc1YbgjMgXBOJ4WlazEXg3LLpCk8yO1aQibssKWdkcdL5q8X1gJJt3xIu1tRcunoeLAq2PFHT7GWv68EwrtsxH7BvmCMaRGa3Fio1b9gaQ0AB2nzg'},
  ];

  @override
  void initState() {
    super.initState();
    _tabCtrl = TabController(length: 3, vsync: this);
  }

  @override
  void dispose() {
    _tabCtrl.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: kBackground,
      body: NestedScrollView(
        headerSliverBuilder: (context, innerBoxIsScrolled) => [
          SliverAppBar(
            backgroundColor: kBackground,
            pinned: true,
            title: Text(user.username, style: kSubheading),
            actions: [
              const Icon(Icons.add_box_outlined, color: kTextPrimary),
              const SizedBox(width: 16),
              const Icon(Icons.menu, color: kTextPrimary),
              const SizedBox(width: 12),
            ],
          ),
          // Profile header
          SliverToBoxAdapter(
            child: Padding(
              padding: const EdgeInsets.fromLTRB(16, 8, 16, 0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // Avatar + stats
                  Row(
                    children: [
                      ClipOval(
                        child: CachedNetworkImage(
                          imageUrl: user.avatarUrl,
                          width: 77,
                          height: 77,
                          fit: BoxFit.cover,
                          placeholder: (_, __) => Container(width: 77, height: 77, color: kShimmerBase),
                        ),
                      ),
                      Expanded(
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          children: [
                            _StatItem(value: '${posts.length}', label: 'Posts'),
                            _StatItem(value: '340', label: 'Followers'),
                            _StatItem(value: '280', label: 'Following'),
                          ],
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 8),
                  Text(user.displayName, style: kBodyBold),
                  if (user.bio.isNotEmpty) ...[
                    const SizedBox(height: 2),
                    Text(user.bio, style: kCaption),
                  ],
                  const SizedBox(height: 12),
                  // Edit profile button
                  SizedBox(
                    width: double.infinity,
                    height: 32,
                    child: OutlinedButton(
                      onPressed: () {},
                      style: OutlinedButton.styleFrom(
                        side: const BorderSide(color: Color(0x4DFFFFFF)),
                        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
                        foregroundColor: kTextPrimary,
                        textStyle: kCaptionBold,
                      ),
                      child: const Text('Edit Profile'),
                    ),
                  ),
                ],
              ),
            ),
          ),
          // Highlights
          SliverToBoxAdapter(
            child: SizedBox(
              height: 100,
              child: ListView.builder(
                scrollDirection: Axis.horizontal,
                padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
                itemCount: _highlights.length,
                itemBuilder: (_, i) {
                  final h = _highlights[i];
                  return Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 6),
                    child: Column(
                      children: [
                        Container(
                          width: 56,
                          height: 56,
                          decoration: BoxDecoration(
                            shape: BoxShape.circle,
                            border: Border.all(color: kDivider),
                          ),
                          child: ClipOval(
                            child: CachedNetworkImage(
                              imageUrl: h['img']!,
                              fit: BoxFit.cover,
                              placeholder: (_, __) => Container(color: kShimmerBase),
                            ),
                          ),
                        ),
                        const SizedBox(height: 4),
                        Text(
                          h['label']!,
                          style: kTiny.copyWith(color: kTextPrimary),
                          overflow: TextOverflow.ellipsis,
                        ),
                      ],
                    ),
                  );
                },
              ),
            ),
          ),
          // Tab bar
          SliverPersistentHeader(
            pinned: true,
            delegate: _TabBarDelegate(
              TabBar(
                controller: _tabCtrl,
                indicatorColor: kTextPrimary,
                indicatorWeight: 1,
                tabs: [
                  Tab(icon: Icon(Icons.grid_on, color: kTextPrimary)),
                  Tab(icon: Icon(Icons.movie_outlined, color: kTextSecondary)),
                  Tab(icon: Icon(Icons.person_pin_circle_outlined, color: kTextSecondary)),
                ],
              ),
            ),
          ),
        ],
        body: TabBarView(
          controller: _tabCtrl,
          children: [
            // Grid tab
            GridView.builder(
              padding: EdgeInsets.zero,
              gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 3,
                mainAxisSpacing: 1.5,
                crossAxisSpacing: 1.5,
              ),
              itemCount: posts.length,
              itemBuilder: (_, i) => CachedNetworkImage(
                imageUrl: posts[i].imageUrls.first,
                fit: BoxFit.cover,
                placeholder: (_, __) => Container(color: kShimmerBase),
              ),
            ),
            // Reels tab
            Center(child: Text('No Reels yet', style: kCaption)),
            // Tagged tab
            Center(child: Text('No tagged posts', style: kCaption)),
          ],
        ),
      ),
    );
  }
}

class _StatItem extends StatelessWidget {
  final String value;
  final String label;

  const _StatItem({required this.value, required this.label});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Text(value, style: kSubheading),
        const SizedBox(height: 2),
        Text(label, style: kTiny.copyWith(color: kTextPrimary, fontSize: 13)),
      ],
    );
  }
}

class _TabBarDelegate extends SliverPersistentHeaderDelegate {
  final TabBar tabBar;
  const _TabBarDelegate(this.tabBar);

  @override
  double get minExtent => tabBar.preferredSize.height;
  @override
  double get maxExtent => tabBar.preferredSize.height;

  @override
  Widget build(BuildContext context, double shrinkOffset, bool overlapsContent) {
    return Container(color: kBackground, child: tabBar);
  }

  @override
  bool shouldRebuild(covariant _TabBarDelegate oldDelegate) => false;
}
