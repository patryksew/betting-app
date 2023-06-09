import 'package:flutter/material.dart';
import 'package:fuksiarz/models/event.dart';
import 'package:fuksiarz/models/event_category.dart';
import 'package:fuksiarz/providers/expanded_categories_provider.dart';
import 'package:fuksiarz/widgets/event_category_header_big.dart';
import 'package:fuksiarz/widgets/event_category_header_small.dart';
import 'package:fuksiarz/widgets/event_display.dart';
import 'package:provider/provider.dart';

class EventsByCategoriesList extends StatelessWidget {
  final Map<EventCategory, Map<EventCategory, List<Event>>> result;

  const EventsByCategoriesList({super.key, required this.result});

  @override
  Widget build(BuildContext context) {
    List<Widget> items = [];
    Function(EventCategory category) isExpanded = Provider.of<ExpandedCategoriesProvider>(context).isExpanded;

    for (var entry in result.entries) {
      EventCategory category = entry.key;
      Map<EventCategory, List<Event>> subcategories = entry.value;

      int eventsCount = 0;

      for (List<Event> eventsList in subcategories.values) {
        eventsCount += eventsList.length;
      }

      items.add(EventCategoryHeaderBig(
        eventsCount: eventsCount,
        category: category,
      ));

      if (isExpanded(category)) {
        subcategories.forEach((EventCategory category, List<Event> events) {
          items.add(EventCategoryHeaderSmall(currentCategory: category));

          for (Event event in events) {
            items.add(EventDisplay(
              event,
            ));
          }
        });
      }

      items.add(Container(
        height: 1,
        width: double.infinity,
        decoration: BoxDecoration(border: Border(bottom: BorderSide(color: Theme.of(context).dividerColor))),
      ));
    }

    return SliverList(
      delegate: SliverChildBuilderDelegate(
        (context, index) {
          return items[index];
        },
        childCount: items.length,
      ),
    );
  }
}
