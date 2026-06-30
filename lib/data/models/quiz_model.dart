// lib/data/models/quiz_model.dart

class QuizQuestion {
  final String id;
  final String question;
  final List<String> options;
  final int correctIndex;
  final String? explanation;
  final String? imageUrl;

  const QuizQuestion({
    required this.id,
    required this.question,
    required this.options,
    required this.correctIndex,
    this.explanation,
    this.imageUrl,
  });

  factory QuizQuestion.fromJson(Map<String, dynamic> json) =>
      QuizQuestion(
        id: json['id'] as String,
        question: json['question'] as String,
        options: List<String>.from(json['options']),
        correctIndex: json['correctIndex'] as int,
        explanation: json['explanation'] as String?,
        imageUrl: json['imageUrl'] as String?,
      );

  Map<String, dynamic> toJson() => {
        'id': id,
        'question': question,
        'options': options,
        'correctIndex': correctIndex,
        'explanation': explanation,
        'imageUrl': imageUrl,
      };
}

class QuizModel {
  final String id;
  final String contentId;
  final String title;
  final List<QuizQuestion> questions;
  final int xpReward;
  final String? badgeId;

  const QuizModel({
    required this.id,
    required this.contentId,
    required this.title,
    required this.questions,
    this.xpReward = 50,
    this.badgeId,
  });

  factory QuizModel.fromJson(Map<String, dynamic> json) => QuizModel(
        id: json['id'] as String,
        contentId: json['contentId'] as String,
        title: json['title'] as String,
        questions: (json['questions'] as List<dynamic>)
            .map((q) => QuizQuestion.fromJson(q))
            .toList(),
        xpReward: json['xpReward'] as int? ?? 50,
        badgeId: json['badgeId'] as String?,
      );

  Map<String, dynamic> toJson() => {
        'id': id,
        'contentId': contentId,
        'title': title,
        'questions': questions.map((q) => q.toJson()).toList(),
        'xpReward': xpReward,
        'badgeId': badgeId,
      };
}

// ─── PLAYLIST ────────────────────────────────────────────────────────────────
class PlaylistModel {
  final String id;
  final String userId;
  final String title;
  final String? description;
  final String? coverImage;
  final List<String> contentIds;
  final bool isPublic;
  final DateTime createdAt;

  const PlaylistModel({
    required this.id,
    required this.userId,
    required this.title,
    this.description,
    this.coverImage,
    this.contentIds = const [],
    this.isPublic = false,
    required this.createdAt,
  });

  int get count => contentIds.length;

  factory PlaylistModel.fromJson(Map<String, dynamic> json) =>
      PlaylistModel(
        id: json['id'] as String,
        userId: json['userId'] as String,
        title: json['title'] as String,
        description: json['description'] as String?,
        coverImage: json['coverImage'] as String?,
        contentIds: List<String>.from(json['contentIds'] ?? []),
        isPublic: json['isPublic'] as bool? ?? false,
        createdAt: DateTime.parse(json['createdAt'] as String),
      );

  Map<String, dynamic> toJson() => {
        'id': id,
        'userId': userId,
        'title': title,
        'description': description,
        'coverImage': coverImage,
        'contentIds': contentIds,
        'isPublic': isPublic,
        'createdAt': createdAt.toIso8601String(),
      };
}

// ─── SETTINGS ────────────────────────────────────────────────────────────────
class AppSettings {
  final String theme; // 'dark' | 'light' | 'system'
  final String language;
  final String fontFamily;
  final double fontSize;
  final bool notificationsEnabled;
  final bool dailyProverbEnabled;
  final bool downloadOverWifiOnly;
  final String audioQuality; // 'low' | 'medium' | 'high'
  final String videoQuality; // '360p' | '720p' | '1080p'
  final bool autoplay;
  final double playbackSpeed;
  final bool accessibilityLargeText;

  const AppSettings({
    this.theme = 'dark',
    this.language = 'fr',
    this.fontFamily = 'DM Sans',
    this.fontSize = 16,
    this.notificationsEnabled = true,
    this.dailyProverbEnabled = true,
    this.downloadOverWifiOnly = true,
    this.audioQuality = 'high',
    this.videoQuality = '720p',
    this.autoplay = true,
    this.playbackSpeed = 1.0,
    this.accessibilityLargeText = false,
  });

  factory AppSettings.fromJson(Map<String, dynamic> json) => AppSettings(
        theme: json['theme'] as String? ?? 'dark',
        language: json['language'] as String? ?? 'fr',
        fontFamily: json['fontFamily'] as String? ?? 'DM Sans',
        fontSize: (json['fontSize'] as num?)?.toDouble() ?? 16,
        notificationsEnabled:
            json['notificationsEnabled'] as bool? ?? true,
        dailyProverbEnabled:
            json['dailyProverbEnabled'] as bool? ?? true,
        downloadOverWifiOnly:
            json['downloadOverWifiOnly'] as bool? ?? true,
        audioQuality: json['audioQuality'] as String? ?? 'high',
        videoQuality: json['videoQuality'] as String? ?? '720p',
        autoplay: json['autoplay'] as bool? ?? true,
        playbackSpeed:
            (json['playbackSpeed'] as num?)?.toDouble() ?? 1.0,
        accessibilityLargeText:
            json['accessibilityLargeText'] as bool? ?? false,
      );

  Map<String, dynamic> toJson() => {
        'theme': theme,
        'language': language,
        'fontFamily': fontFamily,
        'fontSize': fontSize,
        'notificationsEnabled': notificationsEnabled,
        'dailyProverbEnabled': dailyProverbEnabled,
        'downloadOverWifiOnly': downloadOverWifiOnly,
        'audioQuality': audioQuality,
        'videoQuality': videoQuality,
        'autoplay': autoplay,
        'playbackSpeed': playbackSpeed,
        'accessibilityLargeText': accessibilityLargeText,
      };

  AppSettings copyWith({
    String? theme,
    String? language,
    String? fontFamily,
    double? fontSize,
    bool? notificationsEnabled,
    bool? dailyProverbEnabled,
    bool? downloadOverWifiOnly,
    String? audioQuality,
    String? videoQuality,
    bool? autoplay,
    double? playbackSpeed,
    bool? accessibilityLargeText,
  }) =>
      AppSettings(
        theme: theme ?? this.theme,
        language: language ?? this.language,
        fontFamily: fontFamily ?? this.fontFamily,
        fontSize: fontSize ?? this.fontSize,
        notificationsEnabled:
            notificationsEnabled ?? this.notificationsEnabled,
        dailyProverbEnabled:
            dailyProverbEnabled ?? this.dailyProverbEnabled,
        downloadOverWifiOnly:
            downloadOverWifiOnly ?? this.downloadOverWifiOnly,
        audioQuality: audioQuality ?? this.audioQuality,
        videoQuality: videoQuality ?? this.videoQuality,
        autoplay: autoplay ?? this.autoplay,
        playbackSpeed: playbackSpeed ?? this.playbackSpeed,
        accessibilityLargeText:
            accessibilityLargeText ?? this.accessibilityLargeText,
      );
}
