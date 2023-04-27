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
