import '../models/post_model.dart';
import 'story_repository.dart';

const _postImages = [
  'https://lh3.googleusercontent.com/aida-public/AB6AXuAb8U4XhyuASySwZpG-Y8Cbfij3IIgWapzkyyE-H-KaiBqIH4uFMjQpKoSKH8MuXj_FoC4sAk8N5Waj2YUMBIO66nk9NadwQGzrT8o_C6RbfJwCmdMgDj2O5CGn592bFusbhprxrkaAlHZub1i4Sqav0_iJRm9-q9-vNRco4IYpLAF0cPIImJIjNVo1MECOsm4TsNAQEdxAyC5N-1Ma7RzjYV0XyVVeJJO0z506c87vOTzEQuEs89g_Pvf2YH4923JwSxsUxON37cc',
  'https://lh3.googleusercontent.com/aida-public/AB6AXuAL1wQrsBkYlqtwQyY1x17EAILputnxSmNUD1hg39mHBo2RwICPTnEECjxtObMWldYCpv0hr2rTqoYhylmVsiRALo6kpOUFW92sjjZijYPQyoot_BtJuN9UU4LiHBFIIdhmsP5Vh1WZQSN_VXYpIyvafEFeGGl5WE5aXoEANAn46MXOT3gkVwyWIY41oOfkT-ftH-Pn5OR4ANP1g_iQxQqwUe5k2IzbIPX6lhy-62KJLPh0zZYq-90qRGGmT5k0jL3vKV1fy4pfK9I',
  'https://lh3.googleusercontent.com/aida-public/AB6AXuD9PRlQQLJz1Ul3OPrGjKkHZr9_5aRD1JigGZY0dXAXCtilT3-uzSyKocKB3bnyx7ZyTfls-JrnQOEJNqnU8NKVdgv3UGTuyiaRMO0_GHCL1VFeDcYBWjVfa4AU8b1t4PMvfH-Lz5trdXhv9zS62HiCXB2VxM3SImb4GsGXGqaRKntH7Bdqx3vGE4AcT0VUa7L6dab7Z3lAX5gFid-75_TD7fObalk4lZWDeXAfPZxN6sofUPiRd1BvyGEBcOESHgJikUYDfSchexI',
  'https://lh3.googleusercontent.com/aida-public/AB6AXuCUUOi_WlLFhCt6dWUnpAaVMVClpCyoIQkXWaPtf8NV-Nl9Aa0pm5at93GnhLjpieyN9g0osFRUSli7jZ9-kAufFWhBhQ5120AGxX39HXjVISH3ZRzm5zXIOpJZGq8bKO_D464SnLZnKN0I7CALZ1cuHuN83RKp7HbceXWYcJpsF2ijjhKLkfIAN6mCc0j06KPUNPGyy5MCrQbiSLoSSM92-9YI-I5n4FU3hB5tg-WL6Tne1FzetAYoKE6RwczKp7LW5DhfPDYkHWI',
  'https://lh3.googleusercontent.com/aida-public/AB6AXuCLvpomuGfa1vUxkKlzupsaJZ9_-zQlIFhYDMpVDtlkUwnxgBkYyu7697jCic8y_arKhpUEKy65pcmFiY_6G86Wzh_8Sz_vJpn6idFgidO6Qfw9ZJDv2019d7D-fTxiTL1uohU0aEU60398Q8FGGgeTQbrWVVXc1YbgjMgXBOJ4WlazEXg3LLpCk8yO1aQibssKWdkcdL5q8X1gJJt3xIu1tRcunoeLAq2PFHT7GWv68EwrtsxH7BvmCMaRGa3Fio1b9gaQ0AB2nzg',
  'https://lh3.googleusercontent.com/aida-public/AB6AXuC2Ha-9U3ZGS-pbEtsqmP5b2hZ5_tcWBgNJO1_exDSol4xCyDBXABllzon-jl8AmSWe5zxtzKvyqyqpZhCSqCxVwCjHgs9wk2w7DGPtPs-BdAEYt_G1GdkXYBbnDgqMWyP1R1QiBhbkAgbhkAjlS7r8w3E7IbLlIiV0S1ysrLziI6HT_JBFbNiP12nRFCirHpT0kggqhyKxJf-TDdq8z0S7ifMrs_8fTOeLtxRP3zTnrnCzgysgJgcrhxoNPtjWexZ5U-kPx_KWRx4',
  'https://lh3.googleusercontent.com/aida-public/AB6AXuCqEa5Nnc_ms0xHohjUu2RCaYHwt9w5n4xjbtKIoKuAcrzBCAAQ2nrysf5Une3qLycLAI7Pw5FXXakhjo05La5hMFXwfNuGhhObOSLEy65WvCk0HiQt3WZyq6R-gQtmzmhHSHJ1aaOQMrBv4Yo264hRN5LI8fINJnhIU5kIc21kNvRrMWk0UIdbWgnaWAG0hRfYjEC9MLqhzBBwa4dfDNVclz9doJt6b_GyXA57m1ULpxwWapN7BcBF1rL-Rqv56BMUSa9IzD6sxDQ',
  'https://lh3.googleusercontent.com/aida-public/AB6AXuDfjpIdspRV8KUifD-5faQpjEyc8vFcfZlGoXrKnxuGdcbf7FZSoQVi8lPx0XyjpZ0qgLj0wvrdSIyrUbhcbIkJ81sciGTQKPwo_uQ4fAT-H8rVRrQVl4PjVIai4lVZdQWaezzs5nkgGzwSS4V1eu0gbzQfQeoIV6ziSyhq7KCCmQxIvvbzO3bm8BpiszJJQNesT2OeZ74TxKs2YG12ZNmNOseGtbVb3Tq2vkN2vXFxpgX_LqQNGsQTPgQD8w2LmRb7QlyYfamcgF0',
  'https://lh3.googleusercontent.com/aida-public/AB6AXuAzOBNVsdDklXfmXBllQRR2ek6r6nX9DQmh0DAND88mfnon9uN0v9S8MW5PuDzTuyhJo3comHAQlg4rsZhT3s7leI_y07Shy2-J_3HP7CZcCji_JuC8vkD88c9wmX4MxUYc212kwOZuYNAi7IDQ31E7vEqiGX5kQFvoS5bbXU8qLoPTLY5JW2tni6ZK5tWBzbmz8eNiUD0ipRq3swkHaLxwCIzVqdIE0cBvp5dsrAJVFh7YeDu1qldO3_0XvGvxNL-z3ioeOwWnXIQ',
];

class PostRepository {
  static Future<List<PostModel>> getFeedPosts({int page = 0}) async {
    await Future.delayed(const Duration(milliseconds: 600));
    final users = StoryRepository.sampleUsers;
    final basePosts = [
      PostModel(
        id: 'p1',
        user: users[3], // amalfi_coasts
        imageUrls: [_postImages[0], _postImages[1], _postImages[2]],
        caption: 'Exploring the hidden gems of the Mediterranean. Summer never ends here! 🍋🇮🇹',
        location: 'Positano, Italy',
        likeCount: 4821,
        commentCount: 143,
        timestamp: DateTime.now().subtract(const Duration(days: 0, hours: 6)),
        isLiked: false,
        type: PostType.carousel,
        likedByUsername: 'nature_pro',
      ),
      PostModel(
        id: 'p2',
        user: users[4], // joshua_l
        imageUrls: [_postImages[3]],
        caption: 'Golden hour hits different in the mountains. Capturing the peace and the light...',
        location: 'Swiss Alps',
        likeCount: 12300,
        commentCount: 256,
        timestamp: DateTime.now().subtract(const Duration(days: 1)),
        isLiked: true,
        likedByUsername: 'wanderlust',
      ),
      PostModel(
        id: 'p3',
        user: users[0], // traveler_vibe
        imageUrls: [_postImages[4], _postImages[5]],
        caption: 'Every sunset is an opportunity to reset. 🌅',
        location: 'Santorini, Greece',
        likeCount: 8900,
        commentCount: 321,
        timestamp: DateTime.now().subtract(const Duration(days: 2)),
        type: PostType.carousel,
        likedByUsername: 'pixel_adven',
      ),
      PostModel(
        id: 'p4',
        user: users[1], // wanderlust
        imageUrls: [_postImages[6]],
        caption: 'Lost in the sound of waves 🌊 #beachlife #summer',
        location: 'Maldives',
        likeCount: 6200,
        commentCount: 178,
        timestamp: DateTime.now().subtract(const Duration(days: 3)),
        isLiked: false,
      ),
      PostModel(
        id: 'p5',
        user: users[2], // pixel_adven
        imageUrls: [_postImages[7], _postImages[8], _postImages[0]],
        caption: 'Three days, three cities, one lens 📸',
        location: 'Europe Tour',
        likeCount: 3400,
        commentCount: 92,
        timestamp: DateTime.now().subtract(const Duration(days: 5)),
        type: PostType.carousel,
      ),
    ];
    
    if (page == 0) return basePosts;
    
    return basePosts.map((p) => PostModel(
      id: '${p.id}_page$page',
      user: p.user,
      imageUrls: p.imageUrls,
      caption: p.caption,
      location: p.location,
      likeCount: p.likeCount,
      commentCount: p.commentCount,
      timestamp: p.timestamp.subtract(Duration(days: page * 5)),
      isLiked: p.isLiked,
      type: p.type,
      likedByUsername: p.likedByUsername,
    )).toList();
  }

  static List<String> getExploreImages() => _postImages;

  static Future<List<PostModel>> getReelPosts({int page = 0}) async {
    await Future.delayed(const Duration(milliseconds: 400));
    final users = StoryRepository.sampleUsers;
    final base = [
      PostModel(
        id: 'r1',
        user: users[4],
        imageUrls: [_postImages[3]],
        caption: 'Golden hour hits different in the mountains 🏔️',
        likeCount: 44600,
        commentCount: 1234,
        timestamp: DateTime.now().subtract(const Duration(hours: 3)),
        type: PostType.reel,
      ),
      PostModel(
        id: 'r2',
        user: users[0],
        imageUrls: [_postImages[4]],
        caption: 'Travel tip: always find the rooftop bar 🍹',
        likeCount: 28900,
        commentCount: 876,
        timestamp: DateTime.now().subtract(const Duration(hours: 7)),
        type: PostType.reel,
      ),
      PostModel(
        id: 'r3',
        user: users[1],
        imageUrls: [_postImages[5]],
        caption: 'Ocean therapy session 🌊🧘',
        likeCount: 19200,
        commentCount: 543,
        timestamp: DateTime.now().subtract(const Duration(hours: 12)),
        type: PostType.reel,
      ),
    ];
    if (page == 0) return base;
    return base.map((p) => PostModel(
      id: '${p.id}_p$page',
      user: p.user,
      imageUrls: p.imageUrls,
      caption: p.caption,
      likeCount: p.likeCount,
      commentCount: p.commentCount,
      timestamp: p.timestamp.subtract(Duration(days: page * 2)), // Adjust timestamp for pagination
      type: p.type,
    )).toList();
  }

  static Future<List<PostModel>> getProfilePosts({int page = 0}) async {
    await Future.delayed(const Duration(milliseconds: 300));
    final me = StoryRepository.sampleUsers[5];
    final base = List.generate(9, (i) => PostModel(
      id: 'my${i}_p$page',
      user: me,
      imageUrls: [_postImages[(i + page * 9) % _postImages.length]],
      caption: 'Memory #${i + page * 9}',
      likeCount: 100 + i * 50,
      commentCount: 10 + i,
      timestamp: DateTime.now().subtract(Duration(days: i * 3 + page * 27)),
    ));
    return base;
  }
}
