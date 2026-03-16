import 'package:flutter/material.dart';
import '../core/constants/colors.dart';
import '../core/constants/typography.dart';
import '../services/post_repository.dart';

class UploadReelScreen extends StatefulWidget {
  const UploadReelScreen({super.key});

  @override
  State<UploadReelScreen> createState() => _UploadReelScreenState();
}

class _UploadReelScreenState extends State<UploadReelScreen> {
  int _step = 0; // 0=select, 1=edit, 2=share
  int _selectedIndex = 0;
  final _images = PostRepository.getExploreImages();
  final _captionCtrl = TextEditingController();

  @override
  void dispose() {
    _captionCtrl.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    switch (_step) {
      case 1: return _buildEditStep();
      case 2: return _buildShareStep();
      default: return _buildSelectStep();
    }
  }

  Scaffold _buildSelectStep() {
    return Scaffold(
      backgroundColor: kBackground,
      appBar: PreferredSize(
        preferredSize: const Size.fromHeight(88),
        child: Container(
          color: kSurface,
          padding: EdgeInsets.only(
            top: MediaQuery.of(context).padding.top,
            left: 16, right: 16, bottom: 12,
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [
              GestureDetector(
                onTap: () => Navigator.pop(context),
                child: const Icon(Icons.close, color: kTextPrimary, size: 26),
              ),
              Text('New Reel', style: kBodyBold),
              GestureDetector(
                onTap: () => setState(() => _step = 1),
                child: Text('Next', style: kBodyBold.copyWith(color: kBlue)),
              ),
            ],
          ),
        ),
      ),
      body: Column(
        children: [
          // Preview
          Container(
            width: double.infinity,
            height: 220,
            decoration: BoxDecoration(
              image: DecorationImage(
                image: NetworkImage(_images[_selectedIndex % _images.length]),
                fit: BoxFit.cover,
              ),
            ),
            child: Stack(
              children: [
                Container(color: Colors.black26),
                const Center(
                  child: Icon(Icons.play_arrow, color: Colors.white, size: 64),
                ),
                const Positioned(
                  bottom: 12,
                  left: 16,
                  child: Text('0:24', style: TextStyle(color: Colors.white, fontSize: 12, fontWeight: FontWeight.bold)),
                ),
              ],
            ),
          ),
          // Gallery header
          Padding(
            padding: const EdgeInsets.fromLTRB(16, 12, 16, 8),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Row(
                  children: [
                    Text('Recents', style: kBodyBold),
                    const Icon(Icons.expand_more, color: kTextPrimary, size: 18),
                  ],
                ),
                Container(
                  width: 32,
                  height: 32,
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    border: Border.all(color: kDivider),
                    color: kSurface,
                  ),
                  child: const Icon(Icons.copy, color: kTextPrimary, size: 16),
                ),
              ],
            ),
          ),
          // Grid
          Expanded(
            child: GridView.builder(
              gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 3,
                mainAxisSpacing: 1.5,
                crossAxisSpacing: 1.5,
              ),
              itemCount: _images.length,
              padding: EdgeInsets.zero,
              itemBuilder: (_, i) {
                final selected = _selectedIndex == i;
                return GestureDetector(
                  onTap: () => setState(() => _selectedIndex = i),
                  child: Stack(
                    fit: StackFit.expand,
                    children: [
                      Image.network(_images[i % _images.length], fit: BoxFit.cover,
                        errorBuilder: (_, __, ___) => Container(color: kShimmerBase),
                      ),
                      if (selected)
                        Container(
                          decoration: BoxDecoration(
                            border: Border.all(color: kBlue, width: 2.5),
                            color: Colors.black26,
                          ),
                          alignment: Alignment.topRight,
                          padding: const EdgeInsets.all(4),
                          child: const CircleAvatar(
                            radius: 10,
                            backgroundColor: kBlue,
                            child: Icon(Icons.check, color: Colors.white, size: 12),
                          ),
                        ),
                      Positioned(
                        bottom: 4,
                        right: 4,
                        child: Text(
                          '0:${(15 + i * 7) % 60 < 10 ? '0${(15 + i * 7) % 60}' : '${(15 + i * 7) % 60}'}',
                          style: const TextStyle(color: Colors.white, fontSize: 10, fontWeight: FontWeight.bold),
                        ),
                      ),
                    ],
                  ),
                );
              },
            ),
          ),
        ],
      ),
      floatingActionButton: FloatingActionButton.extended(
        onPressed: () {},
        backgroundColor: kSurface,
        foregroundColor: kTextPrimary,
        icon: const Icon(Icons.camera_alt_outlined),
        label: const Text('Camera'),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.startFloat,
    );
  }

  Scaffold _buildEditStep() {
    return Scaffold(
      backgroundColor: kBackground,
      appBar: PreferredSize(
        preferredSize: const Size.fromHeight(88),
        child: Container(
          color: kSurface,
          padding: EdgeInsets.only(
            top: MediaQuery.of(context).padding.top,
            left: 16, right: 16, bottom: 12,
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [
              GestureDetector(
                onTap: () => setState(() => _step = 0),
                child: const Icon(Icons.arrow_back, color: kTextPrimary, size: 26),
              ),
              Text('Edit Reel', style: kBodyBold),
              GestureDetector(
                onTap: () => setState(() => _step = 2),
                child: Text('Next', style: kBodyBold.copyWith(color: kBlue)),
              ),
            ],
          ),
        ),
      ),
      body: Column(
        children: [
          // Video preview
          Expanded(
            child: Stack(
              fit: StackFit.expand,
              children: [
                Image.network(
                  _images[_selectedIndex % _images.length],
                  fit: BoxFit.cover,
                  errorBuilder: (_, __, ___) => Container(color: kShimmerBase),
                ),
                Container(color: Colors.black38),
                const Center(
                  child: Icon(Icons.play_arrow, color: Colors.white, size: 72),
                ),
              ],
            ),
          ),
          // Tools row
          Container(
            height: 80,
            color: kSurface,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                _EditTool(icon: Icons.music_note_outlined, label: 'Audio'),
                _EditTool(icon: Icons.text_fields, label: 'Text'),
                _EditTool(icon: Icons.auto_awesome, label: 'Effects'),
                _EditTool(icon: Icons.crop, label: 'Trim'),
                _EditTool(icon: Icons.speed, label: 'Speed'),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Scaffold _buildShareStep() {
    return Scaffold(
      backgroundColor: kBackground,
      appBar: PreferredSize(
        preferredSize: const Size.fromHeight(88),
        child: Container(
          color: kSurface,
          padding: EdgeInsets.only(
            top: MediaQuery.of(context).padding.top,
            left: 16, right: 16, bottom: 12,
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [
              GestureDetector(
                onTap: () => setState(() => _step = 1),
                child: const Icon(Icons.arrow_back, color: kTextPrimary, size: 26),
              ),
              Text('New Reel', style: kBodyBold),
              GestureDetector(
                onTap: () => Navigator.pop(context),
                child: Text('Share', style: kBodyBold.copyWith(color: kBlue)),
              ),
            ],
          ),
        ),
      ),
      body: ListView(
        padding: const EdgeInsets.all(16),
        children: [
          // Preview + caption
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              ClipRRect(
                borderRadius: BorderRadius.circular(8),
                child: Image.network(
                  _images[_selectedIndex % _images.length],
                  width: 80,
                  height: 80,
                  fit: BoxFit.cover,
                  errorBuilder: (_, __, ___) => Container(width: 80, height: 80, color: kShimmerBase),
                ),
              ),
              const SizedBox(width: 12),
              Expanded(
                child: TextField(
                  controller: _captionCtrl,
                  style: const TextStyle(color: kTextPrimary),
                  maxLines: 4,
                  decoration: InputDecoration(
                    hintText: 'Write a caption...',
                    hintStyle: const TextStyle(color: kTextSecondary),
                    border: InputBorder.none,
                    contentPadding: EdgeInsets.zero,
                  ),
                ),
              ),
            ],
          ),
          const Divider(height: 24),
          _ShareOption(icon: Icons.location_on_outlined, label: 'Add location'),
          const Divider(height: 0),
          _ShareOption(icon: Icons.tag, label: 'Add topics'),
          const Divider(height: 0),
          _ShareOption(icon: Icons.person_add_outlined, label: 'Tag people'),
          const Divider(height: 0),
          _ShareOption(icon: Icons.share_outlined, label: 'Share to Facebook'),
        ],
      ),
    );
  }
}

class _EditTool extends StatelessWidget {
  final IconData icon;
  final String label;
  const _EditTool({required this.icon, required this.label});

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Icon(icon, color: kTextPrimary, size: 26),
        const SizedBox(height: 4),
        Text(label, style: kTiny.copyWith(color: kTextPrimary)),
      ],
    );
  }
}

class _ShareOption extends StatelessWidget {
  final IconData icon;
  final String label;
  const _ShareOption({required this.icon, required this.label});

  @override
  Widget build(BuildContext context) {
    return ListTile(
      leading: Icon(icon, color: kTextPrimary),
      title: Text(label, style: kBody),
      trailing: const Icon(Icons.chevron_right, color: kTextSecondary),
      contentPadding: const EdgeInsets.symmetric(horizontal: 4),
      onTap: () {},
    );
  }
}
