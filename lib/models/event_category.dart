import 'package:equatable/equatable.dart';

class EventCategory with EquatableMixin {
  final List<int> ids;

  final List<String> names;

  EventCategory(this.ids, this.names);

  factory EventCategory.fromId(int id) {
    return EventCategory([id], []);
  }

  String get displayName {
    String value = names[0];

    for (var i = 1; i < names.length; i++) {
      value += ' > ${names[i]}';
    }

    return value;
  }

  @override
  List<Object?> get props => ids;
}
