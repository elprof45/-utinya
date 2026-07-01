enum HistoryType { played, read, bookmarked }

class HistoryEntryModel {
  final String contentId;
  final HistoryType type;
  final String timestamp;
  final double progress;

  HistoryEntryModel({
    required this.contentId,
    required this.type,
    required this.timestamp,
    this.progress = 0.0,
  });
}
