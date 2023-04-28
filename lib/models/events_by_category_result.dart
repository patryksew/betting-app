import 'package:flutter/material.dart';
import 'package:fuksiarz/global/available_categories.dart';
import 'package:fuksiarz/models/event.dart';
import 'package:fuksiarz/models/event_category.dart';

@immutable
class EventsByCategoryResult {
  final Map<EventCategory, Map<EventCategory, List<Event>>> events;
  final bool hasError;
  final String? errorMessage;
  final bool isEmpty;

  const EventsByCategoryResult(this.events, {this.hasError = false, this.isEmpty = false, this.errorMessage});

  EventsByCategoryResult.empty()
      : events = {},
        hasError = false,
        errorMessage = null,
        isEmpty = true;

  EventsByCategoryResult.error(String this.errorMessage)
      : events = {},
        hasError = true,
        isEmpty = true;

  factory EventsByCategoryResult.fromJson(List data, List<int> selectedCategoriesIds) {
    final Map<EventCategory, Map<EventCategory, List<Event>>> events = {};

    //Adding level 0 categories, because I think it's the most efficient way to have events sorted
    final selectedCategories =
        availableCategories.where((category) => selectedCategoriesIds.contains(category.ids[0])).toList();

    for (final category in selectedCategories) {
      events.putIfAbsent(category, () => {});
    }

    for (final rawEvent in data) {
      final eventTopCategory = EventCategory([rawEvent['category1Id']], [rawEvent['category1Name']]);

      final eventCategory = EventCategory(
        [
          rawEvent['category2Id'],
          rawEvent['category3Id'],
        ],
        [
          rawEvent['category2Name'],
          rawEvent['category3Name'],
        ],
      );

      events[eventTopCategory]!.putIfAbsent(eventCategory, () => []);

      final event = Event.fromJson(rawEvent);
      events[eventTopCategory]![eventCategory]!.add(event);
    }

    return EventsByCategoryResult(events);
  }
}
