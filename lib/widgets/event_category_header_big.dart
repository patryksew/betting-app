import 'package:flutter/material.dart';
import 'package:fuksiarz/models/event_category.dart';
import 'package:fuksiarz/providers/expanded_categories_provider.dart';
import 'package:provider/provider.dart';

class EventCategoryHeaderBig extends StatelessWidget {
  final bool isExpanded;
  final int eventsCount;
  final EventCategory category;

  const EventCategoryHeaderBig(
      {super.key, required this.isExpanded, required this.eventsCount, required this.category});

  @override
  Widget build(BuildContext context) {
    return TextButton(
      style: TextButton.styleFrom(
        padding: const EdgeInsets.all(0),
        minimumSize: Size.zero,
        fixedSize: const Size.fromHeight(50),
      ),
      onPressed: () {
        Provider.of<ExpandedCategoriesProvider>(context, listen: false).toogleExpanded(category);
      },
      child: SizedBox(
        height: 50,
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Container(
              margin: const EdgeInsets.symmetric(horizontal: 10),
              child: Text(
                category.displayName,
                style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 14),
              ),
            ),
            Container(
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(25),
                color: Theme.of(context).dividerColor,
              ),
              padding: const EdgeInsets.symmetric(vertical: 4.5, horizontal: 8),
              child: Text(
                eventsCount.toString(),
                style: const TextStyle(fontSize: 12, fontWeight: FontWeight.w500),
              ),
            ),
            const Spacer(),
            Container(
              decoration: BoxDecoration(
                border: Border.all(color: Theme.of(context).dividerColor),
                borderRadius: BorderRadius.circular(5),
              ),
              margin: const EdgeInsets.only(right: 10),
              height: 30,
              width: 30,
              child: isExpanded ? const Icon(Icons.keyboard_arrow_down) : const Icon(Icons.keyboard_arrow_up),
            ),
          ],
        ),
      ),
    );
  }
}
