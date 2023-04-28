import 'package:flutter/material.dart';
import 'package:fuksiarz/models/search_result.dart';
import 'package:fuksiarz/screens/search_screen.dart/widgets/recommended_products.dart';
import 'package:fuksiarz/screens/search_screen.dart/widgets/search_results.dart';
import 'package:fuksiarz/services/search_service.dart';
import 'package:fuksiarz/widgets/search_result_status.dart';

import 'widgets/search_app_bar.dart';

class SearchScreen extends StatefulWidget {
  const SearchScreen({super.key});

  @override
  State<SearchScreen> createState() => _SearchScreenState();
}

class _SearchScreenState extends State<SearchScreen> {
  final TextEditingController searchTextController = TextEditingController();
  final searchService = SearchService();

  bool phraseTooShort = false;
  bool phraseEmpty = true;
  Future<SearchResult>? searchResultFuture;

  void onSearchChange(String pattern) async {
    phraseTooShort = false;
    phraseEmpty = false;

    if (pattern.isEmpty) {
      setState(() {
        phraseEmpty = true;
        searchResultFuture = null;
      });
      return;
    }

    if (pattern.length < 3) {
      setState(() {
        phraseTooShort = true;
        searchResultFuture = null;
      });
      return;
    }
    setState(() {
      searchResultFuture = searchService.getSearchResult(pattern);
    });
  }

  Widget getBody() {
    if (phraseTooShort) {
      return SearchResultStatus(
          icon: Icon(
            Icons.search_off,
            color: Theme.of(context).primaryColor,
            size: 84,
          ),
          title: "Wyszukiwana fraza musi być min. 3 znakowa");
    }
    if (phraseEmpty) {
      return const RecommendedProducts();
    }

    return FutureBuilder(
      future: searchResultFuture,
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const Center(
            child: CircularProgressIndicator(),
          );
        }

        if (snapshot.data == null || snapshot.data!.hasError) {
          return SearchResultStatus(
            icon: Icon(
              Icons.error_outline,
              color: Theme.of(context).primaryColor,
              size: 84,
            ),
            title: "Wystąpił błąd",
            message: "Spróbuj ponownie lub skontaktuj się z administratorem aplikacji.\n${snapshot.data?.errorMessage}",
          );
        }

        if (snapshot.data!.isEmpty) {
          return SearchResultStatus(
            icon: Icon(
              Icons.warning_rounded,
              color: Theme.of(context).primaryColor,
              size: 84,
            ),
            title: 'BRAK WYNIKÓW',
            message: 'SPRÓBUJ INNEGO ZAPYTANIA',
          );
        }

        return SearchResults(snapshot.data!.events);
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: SearchAppBar(
          controller: searchTextController,
          onChanged: onSearchChange,
        ),
        body: getBody(),
      ),
    );
  }
}
