import 'package:equatable/equatable.dart';

class EventCategory with EquatableMixin {
  final List<int> ids;

  final List<String> names;

  EventCategory(this.ids, this.names);

  String get fullDisplayName {
    return '${names[0]} > ${names[1]} > ${names[2]}';
  }

  @override
  List<Object?> get props => ids;
}
