import 'package:flutter/material.dart';
import 'package:fuksiarz/models/event.dart';
import 'package:fuksiarz/models/event_category.dart';
import 'package:fuksiarz/widgets/event_display.dart';

class SearchResults extends StatelessWidget {
  final Map<EventCategory, List<Event>> events;
  final List<EventCategory> categoriesList;

  SearchResults(this.events, {super.key}) : categoriesList = events.keys.toList();

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      addAutomaticKeepAlives: true,
      itemCount: categoriesList.length,
      itemBuilder: (_, index) {
        final EventCategory currentCategory = categoriesList[index];
        final eventsToDisplay = events[currentCategory]!.map((Event event) => EventDisplay(event)).toList();

        return Container(
          margin: const EdgeInsets.symmetric(horizontal: 20),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                margin: const EdgeInsets.symmetric(vertical: 5),
                child: Text(
                  softWrap: true,
                  currentCategory.displayName,
                  style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 12),
                ),
              ),
              ...eventsToDisplay,
            ],
          ),
        );
      },
    );
  }
}
