// lib/data/models/author_model.dart

class AuthorModel {
  final String id;
  final String name;
  final String? avatar;
  final String? bio;
  final String? country;
  final String? website;
  final int contentCount;
  final int followersCount;
  final bool isVerified;
  final List<String> genres;

  const AuthorModel({
    required this.id,
    required this.name,
    this.avatar,
    this.bio,
    this.country,
    this.website,
    this.contentCount = 0,
    this.followersCount = 0,
    this.isVerified = false,
    this.genres = const [],
  });

  factory AuthorModel.fromJson(Map<String, dynamic> json) =>
      AuthorModel(
        id: json['id'] as String,
        name: json['name'] as String,
        avatar: json['avatar'] as String?,
        bio: json['bio'] as String?,
        country: json['country'] as String?,
        website: json['website'] as String?,
        contentCount: json['contentCount'] as int? ?? 0,
        followersCount: json['followersCount'] as int? ?? 0,
        isVerified: json['isVerified'] as bool? ?? false,
        genres: List<String>.from(json['genres'] ?? []),
      );

  Map<String, dynamic> toJson() => {
        'id': id,
        'name': name,
        'avatar': avatar,
        'bio': bio,
        'country': country,
        'website': website,
        'contentCount': contentCount,
        'followersCount': followersCount,
        'isVerified': isVerified,
        'genres': genres,
      };
}
