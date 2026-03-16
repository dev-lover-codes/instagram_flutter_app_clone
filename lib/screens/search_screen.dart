import 'package:flutter/material.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import '../core/constants/colors.dart';
import '../services/post_repository.dart';

class SearchScreen extends StatefulWidget {
  const SearchScreen({super.key});

  @override
  State<SearchScreen> createState() => _SearchScreenState();
}

class _SearchScreenState extends State<SearchScreen> {
  final _ctrl = TextEditingController();

  @override
  void dispose() {
    _ctrl.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final images = PostRepository.getExploreImages();
    return Scaffold(
      backgroundColor: kBackground,
      body: SafeArea(
        child: Column(
          children: [
            // Search bar
            Padding(
              padding: const EdgeInsets.fromLTRB(12, 8, 12, 8),
              child: Container(
                height: 36,
                decoration: BoxDecoration(
                  color: const Color(0x1AFFFFFF),
                  borderRadius: BorderRadius.circular(10),
                ),
                child: Row(
                  children: [
                    const SizedBox(width: 10),
                    const Icon(Icons.search, color: kTextSecondary, size: 20),
                    const SizedBox(width: 6),
                    Expanded(
                      child: TextField(
                        controller: _ctrl,
                        style: const TextStyle(color: kTextPrimary, fontSize: 14),
                        decoration: const InputDecoration(
                          hintText: 'Search',
                          hintStyle: TextStyle(color: kTextSecondary, fontSize: 14),
                          border: InputBorder.none,
                          isDense: true,
                          contentPadding: EdgeInsets.zero,
                        ),
                        onChanged: (_) => setState(() {}),
                      ),
                    ),
                    if (_ctrl.text.isNotEmpty)
                      GestureDetector(
                        onTap: () { _ctrl.clear(); setState(() {}); },
                        child: const Padding(
                          padding: EdgeInsets.symmetric(horizontal: 8),
                          child: Icon(Icons.cancel, color: kTextSecondary, size: 18),
                        ),
                      ),
                  ],
                ),
              ),
            ),
            // Grid
            Expanded(
              child: GridView.custom(
                padding: EdgeInsets.zero,
                gridDelegate: SliverQuiltedGridDelegate(
                  crossAxisCount: 3,
                  mainAxisSpacing: 1.5,
                  crossAxisSpacing: 1.5,
                  repeatPattern: QuiltedGridRepeatPattern.inverted,
                  pattern: const [
                    QuiltedGridTile(2, 2),
                    QuiltedGridTile(1, 1),
                    QuiltedGridTile(1, 1),
                    QuiltedGridTile(1, 1),
                    QuiltedGridTile(1, 1),
                    QuiltedGridTile(1, 1),
                  ],
                ),
                childrenDelegate: SliverChildBuilderDelegate(
                  (context, index) {
                    return GestureDetector(
                      onTap: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => Scaffold(
                              backgroundColor: kBackground,
                              appBar: AppBar(
                                backgroundColor: kBackground,
                                title: const Text('Explore', style: TextStyle(color: kTextPrimary)),
                                iconTheme: const IconThemeData(color: kTextPrimary),
                              ),
                              body: Center(
                                child: Image.network(
                                  images[index % images.length],
                                  fit: BoxFit.contain,
                                ),
                              ),
                            ),
                          ),
                        );
                      },
                      child: Stack(
                        fit: StackFit.expand,
                        children: [
                          Image.network(
                            images[index % images.length],
                            fit: BoxFit.cover,
                            errorBuilder: (_, __, ___) => Container(color: kShimmerBase),
                          ),
                          if (index % 3 == 0)
                            const Positioned(
                              top: 6,
                              right: 6,
                              child: Icon(Icons.play_circle_outline, color: Colors.white, size: 18),
                            ),
                          if (index % 5 == 0)
                            const Positioned(
                              top: 6,
                              right: 6,
                              child: Icon(Icons.layers, color: Colors.white, size: 18),
                            ),
                        ],
                      ),
                    );
                  },
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
