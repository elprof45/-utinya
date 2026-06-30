// lib/data/models/badge_model.dart

enum BadgeType {
  firstRead,
  streak3,
  streak7,
  streak30,
  reader100,
  audioListener,
  explorer,
  commenter,
  sharer,
  level5,
  level10,
  premium,
  earlyAdopter,
}

class BadgeModel {
  final String id;
  final BadgeType type;
  final String title;
  final String description;
  final String icon;
  final DateTime earnedAt;

  const BadgeModel({
    required this.id,
    required this.type,
    required this.title,
    required this.description,
    required this.icon,
    required this.earnedAt,
  });

  factory BadgeModel.fromJson(Map<String, dynamic> json) => BadgeModel(
        id: json['id'] as String,
        type: BadgeType.values
            .firstWhere((e) => e.name == json['type']),
        title: json['title'] as String,
        description: json['description'] as String,
        icon: json['icon'] as String,
        earnedAt: DateTime.parse(json['earnedAt'] as String),
      );

  Map<String, dynamic> toJson() => {
        'id': id,
        'type': type.name,
        'title': title,
        'description': description,
        'icon': icon,
        'earnedAt': earnedAt.toIso8601String(),
      };
}
