// lib/data/models/user_model.dart

import 'badge_model.dart';

enum AuthProvider { email, google, apple, phone, anonymous }

class UserModel {
  final String id;
  final String? name;
  final String? email;
  final String? phone;
  final String? avatar;
  final String? bio;
  final AuthProvider provider;
  final List<String> languages;
  final List<String> interests;
  final List<String> following;
  final List<String> followers;
  final List<String> bookmarks;
  final List<String> downloads;
  final List<String> likedContent;
  final List<BadgeModel> badges;
  final int readingStreak;
  final int totalReadingMinutes;
  final int totalListeningMinutes;
  final int level;
  final int xp;
  final int dailyGoalMinutes;
  final bool isPremium;
  final bool notificationsEnabled;
  final DateTime createdAt;
  final DateTime? lastActiveAt;
  final Map<String, dynamic>? preferences;

  const UserModel({
    required this.id,
    this.name,
    this.email,
    this.phone,
    this.avatar,
    this.bio,
    this.provider = AuthProvider.anonymous,
    this.languages = const ['fr'],
    this.interests = const [],
    this.following = const [],
    this.followers = const [],
    this.bookmarks = const [],
    this.downloads = const [],
    this.likedContent = const [],
    this.badges = const [],
    this.readingStreak = 0,
    this.totalReadingMinutes = 0,
    this.totalListeningMinutes = 0,
    this.level = 1,
    this.xp = 0,
    this.dailyGoalMinutes = 30,
    this.isPremium = false,
    this.notificationsEnabled = true,
    required this.createdAt,
    this.lastActiveAt,
    this.preferences,
  });

  factory UserModel.anonymous() => UserModel(
        id: 'anonymous_${DateTime.now().millisecondsSinceEpoch}',
        provider: AuthProvider.anonymous,
        createdAt: DateTime.now(),
      );

  factory UserModel.fromJson(Map<String, dynamic> json) => UserModel(
        id: json['id'] as String,
        name: json['name'] as String?,
        email: json['email'] as String?,
        phone: json['phone'] as String?,
        avatar: json['avatar'] as String?,
        bio: json['bio'] as String?,
        provider: AuthProvider.values.firstWhere(
          (e) => e.name == json['provider'],
          orElse: () => AuthProvider.email,
        ),
        languages: List<String>.from(json['languages'] ?? ['fr']),
        interests: List<String>.from(json['interests'] ?? []),
        following: List<String>.from(json['following'] ?? []),
        followers: List<String>.from(json['followers'] ?? []),
        bookmarks: List<String>.from(json['bookmarks'] ?? []),
        downloads: List<String>.from(json['downloads'] ?? []),
        likedContent: List<String>.from(json['likedContent'] ?? []),
        badges: (json['badges'] as List<dynamic>?)
                ?.map((b) => BadgeModel.fromJson(b))
                .toList() ??
            [],
        readingStreak: json['readingStreak'] as int? ?? 0,
        totalReadingMinutes: json['totalReadingMinutes'] as int? ?? 0,
        totalListeningMinutes:
            json['totalListeningMinutes'] as int? ?? 0,
        level: json['level'] as int? ?? 1,
        xp: json['xp'] as int? ?? 0,
        dailyGoalMinutes: json['dailyGoalMinutes'] as int? ?? 30,
        isPremium: json['isPremium'] as bool? ?? false,
        notificationsEnabled:
            json['notificationsEnabled'] as bool? ?? true,
        createdAt: DateTime.parse(json['createdAt'] as String),
        lastActiveAt: json['lastActiveAt'] != null
            ? DateTime.parse(json['lastActiveAt'] as String)
            : null,
        preferences: json['preferences'] as Map<String, dynamic>?,
      );

  Map<String, dynamic> toJson() => {
        'id': id,
        'name': name,
        'email': email,
        'phone': phone,
        'avatar': avatar,
        'bio': bio,
        'provider': provider.name,
        'languages': languages,
        'interests': interests,
        'following': following,
        'followers': followers,
        'bookmarks': bookmarks,
        'downloads': downloads,
        'likedContent': likedContent,
        'badges': badges.map((b) => b.toJson()).toList(),
        'readingStreak': readingStreak,
        'totalReadingMinutes': totalReadingMinutes,
        'totalListeningMinutes': totalListeningMinutes,
        'level': level,
        'xp': xp,
        'dailyGoalMinutes': dailyGoalMinutes,
        'isPremium': isPremium,
        'notificationsEnabled': notificationsEnabled,
        'createdAt': createdAt.toIso8601String(),
        'lastActiveAt': lastActiveAt?.toIso8601String(),
        'preferences': preferences,
      };

  UserModel copyWith({
    String? name,
    String? email,
    String? avatar,
    String? bio,
    List<String>? languages,
    List<String>? interests,
    List<String>? bookmarks,
    List<BadgeModel>? badges,
    int? readingStreak,
    int? totalReadingMinutes,
    int? totalListeningMinutes,
    int? level,
    int? xp,
    bool? isPremium,
  }) =>
      UserModel(
        id: id,
        name: name ?? this.name,
        email: email ?? this.email,
        phone: phone,
        avatar: avatar ?? this.avatar,
        bio: bio ?? this.bio,
        provider: provider,
        languages: languages ?? this.languages,
        interests: interests ?? this.interests,
        following: following,
        followers: followers,
        bookmarks: bookmarks ?? this.bookmarks,
        downloads: downloads,
        likedContent: likedContent,
        badges: badges ?? this.badges,
        readingStreak: readingStreak ?? this.readingStreak,
        totalReadingMinutes:
            totalReadingMinutes ?? this.totalReadingMinutes,
        totalListeningMinutes:
            totalListeningMinutes ?? this.totalListeningMinutes,
        level: level ?? this.level,
        xp: xp ?? this.xp,
        dailyGoalMinutes: dailyGoalMinutes,
        isPremium: isPremium ?? this.isPremium,
        notificationsEnabled: notificationsEnabled,
        createdAt: createdAt,
        lastActiveAt: DateTime.now(),
      );

  // XP pour le prochain niveau
  int get xpForNextLevel => level * 500;
  double get levelProgress => xp / xpForNextLevel;
  bool get isAnonymous => provider == AuthProvider.anonymous;
  String get displayName => name ?? 'Lecteur Africain';
  String get initials {
    if (name == null || name!.isEmpty) return 'A';
    final parts = name!.trim().split(' ');
    if (parts.length == 1) return parts[0][0].toUpperCase();
    return '${parts[0][0]}${parts[1][0]}'.toUpperCase();
  }
}
