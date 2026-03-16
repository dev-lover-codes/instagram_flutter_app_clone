import '../models/user_model.dart';
import '../models/story_model.dart';

// Sample remote images (from Stitch templates)
const _avatars = [
  'https://lh3.googleusercontent.com/aida-public/AB6AXuDo_OTA9oWbnuJqQm0zTLxKYFD_akdTbuG53qOdOf8Dq7e2kfjJDCdznB0Z8sZnYRn-PrW_YYNCndk5mf0Rb5CSXa5ba2zNXB8tp0YlCbvYqTVIYZ_QJgCAW1VC8NKpA_7rOVU651QTXdv5RIvYnQcZtINFkHJvdo_QCUIxsLtMlp77F4qQ7Kg5szmhq1gq9uttJBcg68iaeVLYVafXXR6UiPIDqRDhLjBADVeB6zWQUjx767Vhx5skh7FOsgy5isHRJWam0zDC3ek',
  'https://lh3.googleusercontent.com/aida-public/AB6AXuAXOXjF919HvX8eyzIyP0dRyZabwi3JgGZMhwfVsEFQ4fGfqJiu9UeEeer5pukzkepuJZ8dTv3zUW-7e3Pd4Hb8LceFMBedNDv7J4F9s0mREJWEFmRbRfNN21wHBZKsJL4DBHg8pLKa9RUornPswKEU8SpkYVY4Olp_XmT89603nOBT73fv-2QE8H7SDGeZ9Q8sJsS_-IPpUiwU3ZyfqOCODyPQggths3Ropf3W_KahBcKHaRJIA39p148QhFyemd8MGfKeKi5t9EU',
  'https://lh3.googleusercontent.com/aida-public/AB6AXuBEjQ-dmixBD_lq8xxZA_fJaqUKwPk0DlKxGmjB0Sav8X90UTasv4uXhGoCnNT4Lv-L3Un8ScVKLcWF-z4_G6jyphZcJFG4YAzseQhtb9kRW6DTrB2k_RCr7-rf7Z2ZkHf-b-o2MpSWSOn9P8-V3XWpcI2SgUZVvPuBpVPYExb2Iz5gVisZd3SWf_JZJmlKhveohywq5UHUIGY3A3Vp1eyTlkyAc_pM9Ona-RfbCj8hber2DWcKTZhF0HrMSwGBxKYj5cFZqFw-waU',
  'https://lh3.googleusercontent.com/aida-public/AB6AXuCTHYvWJdszEg-yUOafKI22U-mRITijBXwyfeHfBoKSD7KPxuYaHwK8DcBxV6kXOsTsh03vrgIzUIrNFoeQO8iSBniFmWCEootAlAlta-W2yHxI1N3IUBUzs2cT49-sUnYwfZj1BrLdXCx8CE1AIAY7SIewgoVxEixz1M_Rv13hKmC39U2fvIb8DSwvke2V6O4tHxMPxoG5ti6P8_5xdEuqU5WJaHi9bMJINktvnvLaa6AMROwr7AXqaqrue6fY4yLVm1qOzV9Simo',
  'https://lh3.googleusercontent.com/aida-public/AB6AXuCtrh9b6ZeMA_gPsQmWafBIiBJjMfoOY5ACWuyB_bWusctFQcyudFMIUUQiQhM5CYe-dyDJ__vDvCxPCScQAGyK2vc9iBWG5r6fWoysHfEodqLMXkMgjmmHyZq147Q8O7Etu14hQYzq86qsWavaXozcDiU5x8Ru7N4G7ajQFyrE7-ZC23ggHDy1uVaMXb7yRlgez3z-yX4o0GxH6Ddo3zFEchk3bpslM4GZ8xxG9oE1pZSRnNEQia_CQ0EOUVzDzAYqMq-pbfAqr0U',
  'https://lh3.googleusercontent.com/aida-public/AB6AXuBz5fY-HgnGaJSxvLNiN-TVplo1ueKdQEl3lIJwtV3kjrwqm0leKRk4UxB0IOeX2RDqx2khCB7C2xG1pvMh8cn7zd1dv0tFLz4m-wYGxUImPoYka5BsQUJDujUWNLF9U9wRX6Q6dlwKYau3w9ypFLWErYnzWKL_rnGENdigVR4c5xtusxV0AQTI7AjdMa4BK0VjThEDVGYyDUhvIShnuk_RuKhtbIcWlvM3qSPSAiNMGkb8WTO4SuOtvxsf3ZMoRDspC9OWdibQaWQ',
];

const _storyImages = [
  'https://lh3.googleusercontent.com/aida-public/AB6AXuB9E7s3JK4jPdzbclb-WExVk64pMfOECwu0btUSvO4e1fdU54CjOZ2z_UnPsRbakIxePhNnJziAQwLTkscFBjp6jb-YdtiMTeaARkGolCUj6WA2-oaXNcIj6IqO4bSdt4BLfa-1jJ7PpiTS8F1pI_xcHym-_7I8JV7EiAAiDM2Fzxemk1odK79wwEHR8b6eldsvxWpZEUHjjWXgwXk7SMfbaHyIhAA-Z1Lls33AyQVkP3nKEuUBHerZuu_7SoApUX79u6jLzshaREE',
  'https://lh3.googleusercontent.com/aida-public/AB6AXuAL1wQrsBkYlqtwQyY1x17EAILputnxSmNUD1hg39mHBo2RwICPTnEECjxtObMWldYCpv0hr2rTqoYhylmVsiRALo6kpOUFW92sjjZijYPQyoot_BtJuN9UU4LiHBFIIdhmsP5Vh1WZQSN_VXYpIyvafEFeGGl5WE5aXoEANAn46MXOT3gkVwyWIY41oOfkT-ftH-Pn5OR4ANP1g_iQxQqwUe5k2IzbIPX6lhy-62KJLPh0zZYq-90qRGGmT5k0jL3vKV1fy4pfK9I',
  'https://lh3.googleusercontent.com/aida-public/AB6AXuAAkyvB0Brra7sh0TFLPw4fU2tFBu_i-aZx1m4QiGEoU-F89IPqTlLja_Vqb19qAsqwrt_BBd37dSYhi0zQS_If--hp9zMS4GKJ-pqX2nuGNzI-rlmh-01UU_t8uYH3oPvkcXv-y6aQzyWOhxPyb3faKfE1tErHjuSoNgemTeCxaJGhuKj6FpW67PLrc6meB8Lw7AhIY8fA-TWYwDbvRes73ypno4faZ1Nh5cKzyfHqzRgSxht5TwN356_VwZTpHY7VyG6tpX8fiFA',
  'https://lh3.googleusercontent.com/aida-public/AB6AXuD9PRlQQLJz1Ul3OPrGjKkHZr9_5aRD1JigGZY0dXAXCtilT3-uzSyKocKB3bnyx7ZyTfls-JrnQOEJNqnU8NKVdgv3UGTuyiaRMO0_GHCL1VFeDcYBWjVfa4AU8b1t4PMvfH-Lz5trdXhv9zS62HiCXB2VxM3SImb4GsGXGqaRKntH7Bdqx3vGE4AcT0VUa7L6dab7Z3lAX5gFid-75_TD7fObalk4lZWDeXAfPZxN6sofUPiRd1BvyGEBcOESHgJikUYDfSchexI',
];

final _sampleUsers = [
  UserModel(
    id: '1',
    username: 'traveler_vibe',
    displayName: 'Traveler Vibe',
    avatarUrl: _avatars[0],
    isVerified: true,
    hasStory: true,
    isLive: true,
    postCount: 142,
    followerCount: 12400,
    followingCount: 380,
    bio: 'Adventure seeker 🌍✈️',
  ),
  UserModel(
    id: '2',
    username: 'wanderlust',
    displayName: 'Wanderlust',
    avatarUrl: _avatars[1],
    hasStory: true,
    postCount: 98,
    followerCount: 5600,
    followingCount: 210,
    bio: 'Chasing sunsets 🌅',
  ),
  UserModel(
    id: '3',
    username: 'pixel_adven',
    displayName: 'Pixel Adventures',
    avatarUrl: _avatars[2],
    hasStory: true,
    postCount: 67,
    followerCount: 3200,
    followingCount: 180,
    bio: 'Photography & Life 📸',
  ),
  UserModel(
    id: '4',
    username: 'amalfi_coasts',
    displayName: 'Amalfi Coasts',
    avatarUrl: _avatars[3],
    isVerified: true,
    hasStory: false,
    postCount: 84,
    followerCount: 843,
    followingCount: 456,
    bio: 'Exploring the hidden gems of the Mediterranean. Summer never ends here! 🍋🇮🇹',
    website: 'amalficoasts.com',
  ),
  UserModel(
    id: '5',
    username: 'joshua_l',
    displayName: 'Joshua L',
    avatarUrl: _avatars[4],
    hasStory: true,
    postCount: 55,
    followerCount: 9800,
    followingCount: 420,
    bio: 'Mountain photographer 🏔️',
  ),
  UserModel(
    id: '6',
    username: 'me',
    displayName: 'You',
    avatarUrl: _avatars[5],
    hasStory: false,
    postCount: 12,
    followerCount: 340,
    followingCount: 280,
    bio: 'Living life ✨',
  ),
];

class StoryRepository {
  static List<StoryModel> getStories() {
    return [
      StoryModel(
        id: 's1',
        user: _sampleUsers[0],
        imageUrl: _storyImages[0],
        timestamp: DateTime.now().subtract(const Duration(hours: 2)),
      ),
      StoryModel(
        id: 's2',
        user: _sampleUsers[1],
        imageUrl: _storyImages[1],
        timestamp: DateTime.now().subtract(const Duration(hours: 5)),
        isSeen: true,
      ),
      StoryModel(
        id: 's3',
        user: _sampleUsers[2],
        imageUrl: _storyImages[2],
        timestamp: DateTime.now().subtract(const Duration(hours: 8)),
      ),
      StoryModel(
        id: 's4',
        user: _sampleUsers[4],
        imageUrl: _storyImages[3],
        timestamp: DateTime.now().subtract(const Duration(hours: 10)),
      ),
      StoryModel(
        id: 's5',
        user: _sampleUsers[3],
        imageUrl: _storyImages[0],
        timestamp: DateTime.now().subtract(const Duration(hours: 12)),
      ),
    ];
  }

  static UserModel get currentUser => _sampleUsers[5];
  static List<UserModel> get sampleUsers => _sampleUsers;
}
