import 'package:flutter/material.dart';
import 'package:fuksiarz/models/event_category.dart';

class EventCategoryHeaderSmall extends StatelessWidget {
  const EventCategoryHeaderSmall({
    super.key,
    required this.currentCategory,
  });

  final EventCategory currentCategory;

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 10),
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
        ],
      ),
    );
  }
}
