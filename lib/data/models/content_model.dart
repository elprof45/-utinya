// lib/data/models/content_model.dart

enum ContentType {
  book,
  story,
  tale,
  proverb,
  mythology,
  legend,
  history,
  discovery,
  biography,
  poetry,
  quote,
  podcast,
  documentary,
  video,
  audiobook,
  article,
  markdown,
  image,
  illustration,
  photoAlbum,
}

enum ContentFormat { text, audio, video, mixed }

enum AfricanRegion {
  westAfrica,
  centralAfrica,
  eastAfrica,
  southernAfrica,
  northAfrica,
  panAfrica,
}

class ContentModel {
  final String id;
  final ContentType type;
  final ContentFormat format;
  final String title;
  final String? subtitle;
  final String description;
  final String? content; // texte ou markdown
  final String? audioUrl;
  final String? videoUrl;
  final String coverImage;
  final List<String> images;
  final String authorId;
  final String authorName;
  final String? authorAvatar;
  final String? country;
  final AfricanRegion? region;
  final String language;
  final List<String> tags;
  final List<String> categoryIds;
  final int? durationSeconds; // audio/vidéo
  final int? readingTimeMinutes; // texte
  final int? pageCount;
  final int likesCount;
  final int viewsCount;
  final int commentsCount;
  final int bookmarksCount;
  final int downloadsCount;
  final double rating;
  final int ratingsCount;
  final bool isFeatured;
  final bool isTrending;
  final bool isNew;
  final bool isPremium;
  final bool isDownloadable;
  final bool hasAudio; // narration IA disponible
  final bool hasSyncedText; // effet karaoké
  final String? syncedTextUrl; // JSON avec timestamps
  final List<String>? quizIds;
  final DateTime publishedAt;
  final DateTime? updatedAt;
  final Map<String, dynamic>? metadata;

  const ContentModel({
    required this.id,
    required this.type,
    required this.format,
    required this.title,
    this.subtitle,
    required this.description,
    this.content,
    this.audioUrl,
    this.videoUrl,
    required this.coverImage,
    this.images = const [],
    required this.authorId,
    required this.authorName,
    this.authorAvatar,
    this.country,
    this.region,
    required this.language,
    this.tags = const [],
    this.categoryIds = const [],
    this.durationSeconds,
    this.readingTimeMinutes,
    this.pageCount,
    this.likesCount = 0,
    this.viewsCount = 0,
    this.commentsCount = 0,
    this.bookmarksCount = 0,
    this.downloadsCount = 0,
    this.rating = 0,
    this.ratingsCount = 0,
    this.isFeatured = false,
    this.isTrending = false,
    this.isNew = false,
    this.isPremium = false,
    this.isDownloadable = true,
    this.hasAudio = false,
    this.hasSyncedText = false,
    this.syncedTextUrl,
    this.quizIds,
    required this.publishedAt,
    this.updatedAt,
    this.metadata,
  });

  factory ContentModel.fromJson(Map<String, dynamic> json) =>
      ContentModel(
        id: json['id'] as String,
        type: ContentType.values.firstWhere(
          (e) => e.name == json['type'],
          orElse: () => ContentType.article,
        ),
        format: ContentFormat.values.firstWhere(
          (e) => e.name == json['format'],
          orElse: () => ContentFormat.text,
        ),
        title: json['title'] as String,
        subtitle: json['subtitle'] as String?,
        description: json['description'] as String,
        content: json['content'] as String?,
        audioUrl: json['audioUrl'] as String?,
        videoUrl: json['videoUrl'] as String?,
        coverImage: json['coverImage'] as String,
        images: List<String>.from(json['images'] ?? []),
        authorId: json['authorId'] as String,
        authorName: json['authorName'] as String,
        authorAvatar: json['authorAvatar'] as String?,
        country: json['country'] as String?,
        region: json['region'] != null
            ? AfricanRegion.values.firstWhere(
                (e) => e.name == json['region'],
                orElse: () => AfricanRegion.panAfrica,
              )
            : null,
        language: json['language'] as String? ?? 'fr',
        tags: List<String>.from(json['tags'] ?? []),
        categoryIds: List<String>.from(json['categoryIds'] ?? []),
        durationSeconds: json['durationSeconds'] as int?,
        readingTimeMinutes: json['readingTimeMinutes'] as int?,
        pageCount: json['pageCount'] as int?,
        likesCount: json['likesCount'] as int? ?? 0,
        viewsCount: json['viewsCount'] as int? ?? 0,
        commentsCount: json['commentsCount'] as int? ?? 0,
        bookmarksCount: json['bookmarksCount'] as int? ?? 0,
        downloadsCount: json['downloadsCount'] as int? ?? 0,
        rating: (json['rating'] as num?)?.toDouble() ?? 0,
        ratingsCount: json['ratingsCount'] as int? ?? 0,
        isFeatured: json['isFeatured'] as bool? ?? false,
        isTrending: json['isTrending'] as bool? ?? false,
        isNew: json['isNew'] as bool? ?? false,
        isPremium: json['isPremium'] as bool? ?? false,
        isDownloadable: json['isDownloadable'] as bool? ?? true,
        hasAudio: json['hasAudio'] as bool? ?? false,
        hasSyncedText: json['hasSyncedText'] as bool? ?? false,
        syncedTextUrl: json['syncedTextUrl'] as String?,
        quizIds: json['quizIds'] != null
            ? List<String>.from(json['quizIds'])
            : null,
        publishedAt:
            DateTime.parse(json['publishedAt'] as String),
        updatedAt: json['updatedAt'] != null
            ? DateTime.parse(json['updatedAt'] as String)
            : null,
        metadata: json['metadata'] as Map<String, dynamic>?,
      );

  Map<String, dynamic> toJson() => {
        'id': id,
        'type': type.name,
        'format': format.name,
        'title': title,
        'subtitle': subtitle,
        'description': description,
        'content': content,
        'audioUrl': audioUrl,
        'videoUrl': videoUrl,
        'coverImage': coverImage,
        'images': images,
        'authorId': authorId,
        'authorName': authorName,
        'authorAvatar': authorAvatar,
        'country': country,
        'region': region?.name,
        'language': language,
        'tags': tags,
        'categoryIds': categoryIds,
        'durationSeconds': durationSeconds,
        'readingTimeMinutes': readingTimeMinutes,
        'pageCount': pageCount,
        'likesCount': likesCount,
        'viewsCount': viewsCount,
        'commentsCount': commentsCount,
        'bookmarksCount': bookmarksCount,
        'downloadsCount': downloadsCount,
        'rating': rating,
        'ratingsCount': ratingsCount,
        'isFeatured': isFeatured,
        'isTrending': isTrending,
        'isNew': isNew,
        'isPremium': isPremium,
        'isDownloadable': isDownloadable,
        'hasAudio': hasAudio,
        'hasSyncedText': hasSyncedText,
        'syncedTextUrl': syncedTextUrl,
        'quizIds': quizIds,
        'publishedAt': publishedAt.toIso8601String(),
        'updatedAt': updatedAt?.toIso8601String(),
        'metadata': metadata,
      };

  // Helpers
  String get formattedDuration {
    if (durationSeconds == null) return '';
    final hours = durationSeconds! ~/ 3600;
    final minutes = (durationSeconds! % 3600) ~/ 60;
    if (hours > 0) return '${hours}h ${minutes}min';
    return '${minutes}min';
  }

  String get typeLabel {
    switch (type) {
      case ContentType.book:
        return 'Livre';
      case ContentType.story:
        return 'Histoire';
      case ContentType.tale:
        return 'Conte';
      case ContentType.proverb:
        return 'Proverbe';
      case ContentType.mythology:
        return 'Mythologie';
      case ContentType.legend:
        return 'Légende';
      case ContentType.history:
        return 'Histoire';
      case ContentType.discovery:
        return 'Découverte';
      case ContentType.biography:
        return 'Biographie';
      case ContentType.poetry:
        return 'Poésie';
      case ContentType.quote:
        return 'Citation';
      case ContentType.podcast:
        return 'Podcast';
      case ContentType.documentary:
        return 'Documentaire';
      case ContentType.video:
        return 'Vidéo';
      case ContentType.audiobook:
        return 'Livre Audio';
      case ContentType.article:
        return 'Article';
      case ContentType.markdown:
        return 'Article';
      case ContentType.image:
        return 'Image';
      case ContentType.illustration:
        return 'Illustration';
      case ContentType.photoAlbum:
        return 'Album Photo';
    }
  }

  bool get isAudio =>
      format == ContentFormat.audio ||
      type == ContentType.audiobook ||
      type == ContentType.podcast;

  bool get isVideo =>
      format == ContentFormat.video ||
      type == ContentType.video ||
      type == ContentType.documentary;

  bool get isReadable =>
      format == ContentFormat.text ||
      format == ContentFormat.mixed ||
      content != null;
}

// Synced Text for karaoke-style reading
class SyncedSegment {
  final int startMs;
  final int endMs;
  final String text;
  final int index;

  const SyncedSegment({
    required this.startMs,
    required this.endMs,
    required this.text,
    required this.index,
  });

  factory SyncedSegment.fromJson(Map<String, dynamic> json) =>
      SyncedSegment(
        startMs: json['startMs'] as int,
        endMs: json['endMs'] as int,
        text: json['text'] as String,
        index: json['index'] as int,
      );
}
