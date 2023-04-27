import 'dart:async';
import 'dart:convert';

import 'package:fuksiarz/models/search_result.dart';
import 'package:http/http.dart' as http;

class SearchService {
  static const apiHost = 'fuksiarz.pl';

  Future<SearchResult> getSearchResult(String pattern) async {
    try {
      final eventsIds = await _getEventsIds(pattern);
      if (eventsIds.isEmpty) return SearchResult.empty();
      final eventsDetails = await _getEventsDetails(eventsIds);

      return SearchResult.fromJson(eventsDetails);
    } on Exception catch (e) {
      return SearchResult.error(e.toString());
    }
  }

  Future<List<int>> _getEventsIds(String pattern) async {
    final body = jsonEncode({
      "areas": ["LIVE_EVENT", "PREMATCH_EVENT"],
      "languageCode": "pl",
      "mergeLanguages": "true",
      "modes": ["PREFIX", "INFIX"],
      "pattern": pattern,
    });

    final response = await http.post(
      Uri(scheme: 'https', host: apiHost, path: '/rest/search/events/quick-search'),
      headers: {
        'Content-type': 'application/json',
      },
      body: body,
    );

    final responseBody = json.decode(utf8.decode(response.bodyBytes));
    if (responseBody['code'] != 200) {
      throw Exception(responseBody["description"]);
    }

    final List<int> ids = [];

    for (final event in responseBody['data']) {
      ids.add(event['id']);
    }

    return ids;
  }

  Future<List> _getEventsDetails(List<int> ids) async {
    String parsedIds = '';
    for (final id in ids) {
      parsedIds += ',$id';
    }
    parsedIds = parsedIds.substring(1);

    final response = await http.get(Uri(scheme: 'https', host: apiHost, path: '/rest/market/events/multi/$parsedIds'));

    final responseBody = json.decode(utf8.decode(response.bodyBytes));

    if (responseBody['code'] != 200) {
      throw Exception(responseBody["description"]);
    }

    return responseBody['data'];
  }
}
