import 'dart:collection';

import 'package:flutter/material.dart';
import 'package:fuksiarz/models/event_category.dart';

class ExpandedCategoriesProvider extends ChangeNotifier {
  final HashSet<EventCategory> _collapsedCategories = HashSet<EventCategory>();

  void toogleExpanded(EventCategory category) {
    if (_collapsedCategories.contains(category)) {
      _collapsedCategories.remove(category);
    } else {
      _collapsedCategories.add(category);
    }

    notifyListeners();
  }

  bool isExpanded(EventCategory category) => !_collapsedCategories.contains(category);
}
