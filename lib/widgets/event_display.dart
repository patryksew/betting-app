import 'package:flutter/material.dart';
import 'package:fuksiarz/models/event.dart';
import 'package:fuksiarz/widgets/odds_button.dart';
import 'package:intl/intl.dart';

class EventDisplay extends StatelessWidget {
  final Event event;
  final ValueNotifier<bool>? expandedNotifier;

  const EventDisplay(this.event, {super.key, this.expandedNotifier});

  Widget body(BuildContext context) => Container(
        width: double.infinity,
        height: 110,
        margin: const EdgeInsets.symmetric(vertical: 10, horizontal: 10),
        padding: const EdgeInsets.all(10),
        decoration: BoxDecoration(
          border: Border.all(color: Theme.of(context).dividerColor),
          borderRadius: BorderRadius.circular(10),
        ),
        child: Column(
          children: [
            Row(
              children: [
                Text(
                  '${event.category3} ${DateFormat('MM.dd').format(event.eventStart)}',
                  style: const TextStyle(
                    fontSize: 8,
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ],
            ),
            const SizedBox(height: 10),
            Row(
              children: [
                Text(
                  DateFormat.Hm().format(event.eventStart),
                  style: const TextStyle(
                    fontSize: 8,
                    fontWeight: FontWeight.w600,
                  ),
                ),
                Expanded(
                  child: Container(
                    margin: const EdgeInsets.symmetric(horizontal: 10),
                    height: 1,
                    color: Theme.of(context).dividerColor,
                  ),
                ),
                Text(
                  '+${event.gamesCount}',
                  style: TextStyle(
                    fontSize: 8,
                    fontWeight: FontWeight.bold,
                    color: Theme.of(context).primaryColor,
                  ),
                ),
              ],
            ),
            const SizedBox(height: 10),
            Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        event.participants[0],
                        maxLines: 2,
                        style: const TextStyle(
                          overflow: TextOverflow.ellipsis,
                          fontSize: 10,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                      Text(
                        event.participants[1],
                        maxLines: 2,
                        style: const TextStyle(
                          overflow: TextOverflow.ellipsis,
                          fontSize: 10,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                    ],
                  ),
                ),
                if (event.outcomesOdds.length <= 3)
                  OddsButtons(event.outcomesOdds)
                else
                  ElevatedButton(
                    onPressed: () {},
                    style: ElevatedButton.styleFrom(
                      side: BorderSide(color: Theme.of(context).dividerColor),
                      elevation: 0,
                      fixedSize: const Size(159, 45),
                      padding: const EdgeInsets.all(0),
                      minimumSize: Size.zero,
                      foregroundColor: Colors.black,
                      backgroundColor: Colors.white,
                    ),
                    child: const Text(
                      'DO WYDARZENIA',
                      style: TextStyle(fontWeight: FontWeight.bold, fontSize: 12),
                    ),
                  )
              ],
            ),
          ],
        ),
      );

  @override
  Widget build(BuildContext context) {
    print('Event display');

    if (expandedNotifier == null) return body(context);

    return ValueListenableBuilder(
      valueListenable: expandedNotifier!,
      builder: (context, expanded, child) => expanded ? body(context) : const SizedBox.shrink(),
    );
  }
}
