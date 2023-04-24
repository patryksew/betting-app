import 'package:flutter/material.dart';
import 'package:fuksiarz/models/event.dart';
import 'package:fuksiarz/models/event_category.dart';

@immutable
class SearchResult {
  final Map<EventCategory, List<Event>> events;
  final bool hasError;
  final String? errorMessage;
  final bool isEmpty;

  const SearchResult(this.events, {this.hasError = false, this.isEmpty = false, this.errorMessage});

  SearchResult.empty()
      : events = {},
        hasError = false,
        errorMessage = null,
        isEmpty = true;

  SearchResult.error(String this.errorMessage)
      : events = {},
        hasError = true,
        isEmpty = true;

  factory SearchResult.fromJson(List data) {
    final Map<EventCategory, List<Event>> events = {};

    for (final rawEvent in data) {
      final eventCategory = EventCategory(
        [
          rawEvent['category1Id'],
          rawEvent['category2Id'],
          rawEvent['category3Id'],
        ],
        [
          rawEvent['category1Name'],
          rawEvent['category2Name'],
          rawEvent['category3Name'],
        ],
      );

      final event = Event.fromJson(rawEvent);

      events.putIfAbsent(eventCategory, () => []);
      events[eventCategory]!.add(event);
    }

    return SearchResult(events);
  }
}
