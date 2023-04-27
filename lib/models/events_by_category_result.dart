import 'package:flutter/material.dart';
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

  factory EventsByCategoryResult.fromJson(List data) {
    final Map<EventCategory, Map<EventCategory, List<Event>>> events = {};

    for (final rawEvent in data) {
      final eventTopCategory = EventCategory([rawEvent['category1Id']], [rawEvent['category1Name']]);

      events.putIfAbsent(eventTopCategory, () => {});

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
