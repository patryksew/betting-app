import 'package:flutter/material.dart';
import 'package:fuksiarz/models/event_category.dart';
import 'package:fuksiarz/models/events_by_category_result.dart';
import 'package:fuksiarz/services/events_by_category_service.dart';
import 'package:shared_preferences/shared_preferences.dart';

class EventsByCategoriesProvider extends ChangeNotifier {
  List<EventCategory> _selectedCategories = [];
  final EventsByCategoriesService _service = EventsByCategoriesService();
  static const _prefsKey = 'filterSelectedCategories';

  EventsByCategoriesProvider() {
    SharedPreferences.getInstance().then((prefs) {
      final categoriesIds = prefs.getStringList(_prefsKey);
      if (categoriesIds == null) return;

      _selectedCategories = categoriesIds.map((id) => EventCategory.fromId(int.parse(id))).toList();
      notifyListeners();
    });
  }

  List<int> get categoriesId => _selectedCategories.map((category) => category.ids[0]).toList();

  void toogleCategory(EventCategory category) async {
    final index = _selectedCategories.indexOf(category);

    if (index == -1) {
      _selectedCategories.add(category);
    } else {
      _selectedCategories.removeAt(index);
    }

    notifyListeners();

    final prefs = await SharedPreferences.getInstance();

    //Categories are compared only based on id, also for filtering by sports only ids[0] is used
    prefs.setStringList(_prefsKey, _selectedCategories.map((category) => category.ids[0].toString()).toList());
  }

  Future<EventsByCategoryResult> get events => _service.getEventsForCategories(categoriesId);

  bool isSelected(EventCategory category) {
    return _selectedCategories.contains(category);
  }
}
