import 'dart:convert';

import 'package:fuksiarz/models/events_by_category_result.dart';
import 'package:http/http.dart' as http;

class EventsByCategoriesService {
  static const apiHost = 'fuksiarz.pl';

  Future<EventsByCategoryResult> getEventsForCategories(List<int> categories) async {
    if (categories.isEmpty) return EventsByCategoryResult.empty();

    categories.sort();

    try {
      final events = await _getEvents(categories);
      return EventsByCategoryResult.fromJson(events);
    } on Exception catch (e) {
      return EventsByCategoryResult.error(e.toString());
    }
  }

  Future<List> _getEvents(List<int> categories) async {
    String parsedCategories = '';
    for (final category in categories) {
      parsedCategories += ',$category';
    }
    parsedCategories = parsedCategories.substring(1);

    final response = await http
        .get(Uri(scheme: 'https', host: apiHost, path: '/rest/market/categories/multi/$parsedCategories/events'));

    final responseBody = json.decode(utf8.decode(response.bodyBytes));

    if (responseBody['code'] != 200) {
      throw Exception(responseBody["description"]);
    }
    return responseBody['data'];
  }
}
