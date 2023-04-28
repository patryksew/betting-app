import 'dart:convert';

import 'package:flutter/foundation.dart';
import 'package:fuksiarz/models/events_by_category_result.dart';
import 'package:http/http.dart' as http;

class EventsByCategoriesService {
  static const apiHost = 'fuksiarz.pl';

  Future<EventsByCategoryResult> getEventsForCategories(List<int> categories) async {
    if (categories.isEmpty) return EventsByCategoryResult.empty();

    categories.sort();

    try {
      final events = await _getEvents(categories);
      return EventsByCategoryResult.fromJson(events, categories);
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

    final bodyUtf8Decoded = await compute(utf8.decode, response.bodyBytes);
    final responseBody = await compute(json.decode, bodyUtf8Decoded);

    if (responseBody['code'] != 200) {
      throw Exception(responseBody["description"]);
    }
    return responseBody['data'];
  }
}
