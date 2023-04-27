import 'dart:math';

class Event {
  final int id;
  final DateTime eventStart;
  final int gamesCount;
  final List<String> participants;
  final List<double> outcomesOdds;
  final String category3;

  Event({
    required this.id,
    required this.eventStart,
    required this.gamesCount,
    required this.participants,
    required this.outcomesOdds,
    required this.category3,
  });

  //TODO remove later
  static final random = Random();
  factory Event.example() {
    return Event(
      id: random.nextInt(10000),
      eventStart: DateTime.fromMillisecondsSinceEpoch(random.nextInt(1682419093)),
      gamesCount: random.nextInt(100),
      participants: [random.nextInt(100).toString(), random.nextInt(100).toString()],
      outcomesOdds: [random.nextInt(1000) / 100, random.nextInt(1000) / 100],
      category3: random.nextInt(3).toString(),
    );
  }

  factory Event.fromJson(Map data) {
    final eventStart = DateTime.fromMillisecondsSinceEpoch(data['eventStart']);
    final List<String> participants = (data['eventName'] as String).split(' - ');
    final List outcomes = data['eventGames'][0]['outcomes'];
    final List<double> outcomesOdds = [];
    for (var outcome in outcomes) {
      outcomesOdds.add(outcome['outcomeOdds']);
    }

    return Event(
      id: data['eventId'],
      eventStart: eventStart,
      gamesCount: data['gamesCount'],
      participants: participants,
      outcomesOdds: outcomesOdds,
      category3: data['category3Name'],
    );
  }

  @override
  String toString() {
    final String message = '$id $participants';
    return message;
  }
}
