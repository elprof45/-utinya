import 'package:get/get.dart';
import '../../../app/data/models/content_model.dart';
import '../../../app/data/models/history_entry_model.dart';
import '../../../app/data/providers/mock_data_provider.dart';
import '../../../app/routes/app_routes.dart';

class HistoryController extends GetxController {
  final RxList<HistoryEntryModel> _entries = MockDataProvider.historyEntries.obs;

  List<MapEntry<HistoryEntryModel, ContentModel>> _entriesOfType(HistoryType type) {
    final result = <MapEntry<HistoryEntryModel, ContentModel>>[];
    for (final entry in _entries.where((e) => e.type == type)) {
      final content = MockDataProvider.contentById(entry.contentId);
      if (content != null) result.add(MapEntry(entry, content));
    }
    return result;
  }

  List<MapEntry<HistoryEntryModel, ContentModel>> get recentlyPlayed => _entriesOfType(HistoryType.played);
  List<MapEntry<HistoryEntryModel, ContentModel>> get readStories => _entriesOfType(HistoryType.read);
  List<MapEntry<HistoryEntryModel, ContentModel>> get bookmarked => _entriesOfType(HistoryType.bookmarked);

  void removeEntry(HistoryEntryModel entry) => _entries.remove(entry);

  void clearAll() => _entries.clear();

  void openDetail(ContentModel content) => Get.toNamed(Routes.detail, arguments: content);
}
