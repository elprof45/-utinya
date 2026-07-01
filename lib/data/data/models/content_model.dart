import 'package:flutter/material.dart';

enum ContentType { audio, video, text, image }

/// Author / narrator / griot profile attached to a piece of content.
class AuthorModel {
  final String id;
  final String name;
  final String role;
  final int avatarColorIndex;
  final String bio;
  final int followers;
  bool isSubscribed;

  AuthorModel({
    required this.id,
    required this.name,
    required this.role,
    required this.avatarColorIndex,
    required this.bio,
    this.followers = 0,
    this.isSubscribed = false,
  });
}

/// A single piece of cultural content: tale, proverb, history chronicle,
/// audio narration, video, or illustrated gallery.
class ContentModel {
  final String id;
  final String title;
  final String subtitle;
  final String category;
  final String region;
  final String language;
  final ContentType type;
  final int coverIndex;
  final int durationSeconds;
  final AuthorModel author;
  final String body; // markdown body
  final List<String> mediaLabels; // simulated video/image carousel frames
  final List<String> tags;
  bool isFeatured;
  int likes;
  int commentsCount;
  int shares;
  bool isLiked;
  bool isBookmarked;
  final String dateAdded;

  ContentModel({
    required this.id,
    required this.title,
    required this.subtitle,
    required this.category,
    required this.region,
    required this.language,
    required this.type,
    required this.coverIndex,
    required this.author,
    required this.body,
    this.durationSeconds = 0,
    this.mediaLabels = const [],
    this.tags = const [],
    this.isFeatured = false,
    this.likes = 0,
    this.commentsCount = 0,
    this.shares = 0,
    this.isLiked = false,
    this.isBookmarked = false,
    this.dateAdded = '',
  });

  IconData get typeIcon {
    switch (type) {
      case ContentType.audio:
        return Icons.headphones_rounded;
      case ContentType.video:
        return Icons.play_circle_fill_rounded;
      case ContentType.text:
        return Icons.menu_book_rounded;
      case ContentType.image:
        return Icons.photo_library_rounded;
    }
  }

  String get typeLabel {
    switch (type) {
      case ContentType.audio:
        return 'Audio';
      case ContentType.video:
        return 'Video';
      case ContentType.text:
        return 'Story';
      case ContentType.image:
        return 'Gallery';
    }
  }

  String get durationLabel {
    if (durationSeconds <= 0) return '';
    final m = durationSeconds ~/ 60;
    final s = durationSeconds % 60;
    return '${m}m ${s.toString().padLeft(2, '0')}s';
  }
}
