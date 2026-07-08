// lib/data/models/category_model.dart

class CategoryModel {
  final String id;
  final String name;
  final String? nameEn;
  final String? description;
  final String icon;
  final String color;
  final int contentCount;
  final bool isFeatured;
  final String? parentId;

  const CategoryModel({
    required this.id,
    required this.name,
    this.nameEn,
    this.description,
    required this.icon,
    required this.color,
    this.contentCount = 0,
    this.isFeatured = false,
    this.parentId,
  });

  factory CategoryModel.fromJson(Map<String, dynamic> json) => CategoryModel(
    id: json['id'] as String,
    name: json['name'] as String,
    nameEn: json['nameEn'] as String?,
    description: json['description'] as String?,
    icon: json['icon'] as String,
    color: json['color'] as String,
    contentCount: json['contentCount'] as int? ?? 0,
    isFeatured: json['isFeatured'] as bool? ?? false,
    parentId: json['parentId'] as String?,
  );

  Map<String, dynamic> toJson() => {
    'id': id,
    'name': name,
    'nameEn': nameEn,
    'description': description,
    'icon': icon,
    'color': color,
    'contentCount': contentCount,
    'isFeatured': isFeatured,
    'parentId': parentId,
  };
}

// ─── COMMENT ────────────────────────────────────────────────────────────────
class CommentModel {
  final String id;
  final String contentId;
  final String userId;
  final String userName;
  final String? userAvatar;
  final String text;
  final int likesCount;
  final bool isLiked;
  final String? parentId;
  final List<CommentModel> replies;
  final DateTime createdAt;

  const CommentModel({
    required this.id,
    required this.contentId,
    required this.userId,
    required this.userName,
    this.userAvatar,
    required this.text,
    this.likesCount = 0,
    this.isLiked = false,
    this.parentId,
    this.replies = const [],
    required this.createdAt,
  });

  factory CommentModel.fromJson(Map<String, dynamic> json) => CommentModel(
    id: json['id'] as String,
    contentId: json['contentId'] as String,
    userId: json['userId'] as String,
    userName: json['userName'] as String,
    userAvatar: json['userAvatar'] as String?,
    text: json['text'] as String,
    likesCount: json['likesCount'] as int? ?? 0,
    isLiked: json['isLiked'] as bool? ?? false,
    parentId: json['parentId'] as String?,
    replies:
        (json['replies'] as List<dynamic>?)
            ?.map((r) => CommentModel.fromJson(r))
            .toList() ??
        [],
    createdAt: DateTime.parse(json['createdAt'] as String),
  );

  Map<String, dynamic> toJson() => {
    'id': id,
    'contentId': contentId,
    'userId': userId,
    'userName': userName,
    'userAvatar': userAvatar,
    'text': text,
    'likesCount': likesCount,
    'isLiked': isLiked,
    'parentId': parentId,
    'replies': replies.map((r) => r.toJson()).toList(),
    'createdAt': createdAt.toIso8601String(),
  };
}

// ─── NOTIFICATION ────────────────────────────────────────────────────────────
enum NotificationType {
  proverb,
  newContent,
  comment,
  like,
  follow,
  badge,
  reminder,
  system,
}

class NotificationModel {
  final String id;
  final NotificationType type;
  final String title;
  final String body;
  final String? imageUrl;
  final String? actionUrl;
  final bool isRead;
  final DateTime createdAt;

  const NotificationModel({
    required this.id,
    required this.type,
    required this.title,
    required this.body,
    this.imageUrl,
    this.actionUrl,
    this.isRead = false,
    required this.createdAt,
  });

  factory NotificationModel.fromJson(Map<String, dynamic> json) =>
      NotificationModel(
        id: json['id'] as String,
        type: NotificationType.values.firstWhere((e) => e.name == json['type']),
        title: json['title'] as String,
        body: json['body'] as String,
        imageUrl: json['imageUrl'] as String?,
        actionUrl: json['actionUrl'] as String?,
        isRead: json['isRead'] as bool? ?? false,
        createdAt: DateTime.parse(json['createdAt'] as String),
      );

  Map<String, dynamic> toJson() => {
    'id': id,
    'type': type.name,
    'title': title,
    'body': body,
    'imageUrl': imageUrl,
    'actionUrl': actionUrl,
    'isRead': isRead,
    'createdAt': createdAt.toIso8601String(),
  };
}
