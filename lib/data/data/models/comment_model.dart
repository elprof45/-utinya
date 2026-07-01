class CommentModel {
  final String id;
  final String authorName;
  final int avatarColorIndex;
  final String text;
  final String timeAgo;
  int likes;

  CommentModel({
    required this.id,
    required this.authorName,
    required this.avatarColorIndex,
    required this.text,
    required this.timeAgo,
    this.likes = 0,
  });
}
