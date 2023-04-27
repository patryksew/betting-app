import 'package:flutter/material.dart';
import 'package:fuksiarz/models/event.dart';
import 'package:fuksiarz/models/event_category.dart';
import 'package:fuksiarz/widgets/event_category_header_small.dart';
import 'package:fuksiarz/widgets/event_display.dart';

class SearchResults extends StatelessWidget {
  final Map<EventCategory, List<Event>> events;
  final bool shouldScroll;

  const SearchResults(this.events, {this.shouldScroll = true, super.key});

  @override
  Widget build(BuildContext context) {
    final items = [];

    events.forEach((key, value) {
      items.add(EventCategoryHeaderSmall(currentCategory: key));
      for (Event event in value) {
        items.add(EventDisplay(event));
      }
    });

    return ListView.builder(
      physics: shouldScroll ? null : const NeverScrollableScrollPhysics(),
      shrinkWrap: true,
      addAutomaticKeepAlives: true,
      itemCount: items.length,
      itemBuilder: (_, index) {
        // final EventCategory currentCategory = categoriesList[index];
        // final eventsToDisplay = events[currentCategory]!.map((Event event) => EventDisplay(event)).toList();

        print('Result');

        return items[index];

        // return Column(
        //   crossAxisAlignment: CrossAxisAlignment.start,
        //   children: [
        //     EventCategoryHeaderSmall(currentCategory: currentCategory),
        //     ...eventsToDisplay,
        //   ],
        // );
      },
    );
  }
}
