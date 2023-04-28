import 'package:flutter/material.dart';
import 'package:fuksiarz/providers/events_by_categories_provider.dart';
import 'package:fuksiarz/providers/expanded_categories_provider.dart';
import 'package:fuksiarz/screens/main_screen/bodies/events_by_categories_list.dart';
import 'package:fuksiarz/widgets/search_result_status.dart';
import 'package:provider/provider.dart';

class MyBody extends StatelessWidget {
  const MyBody({super.key});

  @override
  Widget build(BuildContext context) {
    EventsByCategoriesProvider eventsByCategoriesProvider = Provider.of<EventsByCategoriesProvider>(context);

    return FutureBuilder(
        future: eventsByCategoriesProvider.events,
        builder: (_, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const SliverFillRemaining(
              child: Center(child: CircularProgressIndicator()),
            );
          }

          if (snapshot.data == null || snapshot.data!.hasError) {
            return SliverFillRemaining(
              hasScrollBody: false,
              child: Container(
                margin: const EdgeInsets.only(top: 50),
                child: SearchResultStatus(
                  icon: Icon(
                    Icons.error_outline,
                    color: Theme.of(context).primaryColor,
                    size: 84,
                  ),
                  title: "Wystąpił błąd",
                  message:
                      "Spróbuj ponownie lub skontaktuj się z administratorem aplikacji.\n${snapshot.data?.errorMessage}",
                ),
              ),
            );
          }

          if (snapshot.data!.isEmpty) {
            return SliverFillRemaining(
              hasScrollBody: false,
              child: Container(
                margin: const EdgeInsets.only(top: 50),
                child: const SearchResultStatus(
                  icon: Icon(
                    Icons.tune,
                    color: Colors.black54,
                    size: 84,
                  ),
                  title: 'BRAK WYNIKÓW',
                  message: 'WYBIERZ INNE KATEGORIE',
                ),
              ),
            );
          }

          return ChangeNotifierProvider(
              create: (_) => ExpandedCategoriesProvider(),
              builder: (_, __) => EventsByCategoriesList(result: snapshot.data!.events));
        });
  }
}
