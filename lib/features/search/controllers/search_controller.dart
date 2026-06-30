// lib/features/search/controllers/search_controller.dart

import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'package:egliloo/data/datasources/local/mock_data.dart';
import 'package:egliloo/data/models/content_model.dart';

class AppSearchController extends GetxController {
  final TextEditingController searchController = TextEditingController();

  final RxString query = ''.obs;
  final RxList<ContentModel> results = <ContentModel>[].obs;
  final RxBool isSearching = false.obs;
  final RxList<String> history = <String>[].obs;
  final RxString selectedFilter = 'Tout'.obs;

  final List<String> filters = const [
    'Tout',
    'Livres',
    'Contes',
    'Podcasts',
    'Vidéos',
    'Proverbes',
  ];

  final List<String> suggestions = const [
    'Anansi',
    'Mansa Musa',
    'Ubuntu',
    'Shango',
    'Griots',
    'Yoruba',
    'Ashanti',
    'Sahara',
  ];

  late final Worker _queryWorker;
  late final VoidCallback _textListener;

  @override
  void onInit() {
    super.onInit();

    history.assignAll(['Mansa Musa', 'Anansi', 'Ubuntu']);

    _textListener = () {
      final text = searchController.text;
      if (query.value != text) {
        query.value = text;
      }
    };
    searchController.addListener(_textListener);

    _queryWorker = debounce<String>(
      query,
      (_) => _applySearch(),
      time: const Duration(milliseconds: 300),
    );
  }

  void _applySearch() {
    final q = query.value.trim();

    if (q.isEmpty) {
      results.clear();
      isSearching.value = false;
      return;
    }

    isSearching.value = true;

    try {
      final baseResults = MockData.search(q);
      final filteredResults = baseResults
          .where(_matchesFilter)
          .toList(growable: false);

      results.assignAll(filteredResults);
      _addToHistory(q);
    } catch (_) {
      results.clear();
      Get.snackbar(
        'Erreur',
        'Impossible d’effectuer la recherche',
        snackPosition: SnackPosition.BOTTOM,
      );
    } finally {
      isSearching.value = false;
    }
  }

  bool _matchesFilter(ContentModel item) {
    final filter = selectedFilter.value.toLowerCase().trim();
    final type = item.typeLabel.toLowerCase().trim();

    switch (filter) {
      case 'tout':
        return true;
      case 'livres':
        return type.contains('livre') || type.contains('book');
      case 'contes':
        return type.contains('conte') || type.contains('story');
      case 'podcasts':
        return type.contains('podcast');
      case 'vidéos':
      case 'videos':
        return type.contains('vidéo') || type.contains('video');
      case 'proverbes':
        return type.contains('proverbe') || type.contains('proverb');
      default:
        return true;
    }
  }

  void _addToHistory(String item) {
    final value = item.trim();
    if (value.isEmpty) return;

    history.remove(value);
    history.insert(0, value);

    if (history.length > 10) {
      history.removeRange(10, history.length);
    }
  }

  void selectSuggestion(String s) {
    searchController.text = s;
    searchController.selection = TextSelection.fromPosition(
      TextPosition(offset: s.length),
    );
  }

  void clearSearch() {
    searchController.clear();
    query.value = '';
    results.clear();
  }

  void removeHistory(String item) {
    history.remove(item);
  }

  void setFilter(String f) {
    selectedFilter.value = f;
    if (query.value.trim().isNotEmpty) {
      _applySearch();
    }
  }

  @override
  void onClose() {
    _queryWorker.dispose();
    searchController.removeListener(_textListener);
    searchController.dispose();
    super.onClose();
  }
}
