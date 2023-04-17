import 'package:flutter/material.dart';
import 'package:fuksiarz/widgets/sliver_header.dart';

class MainScreen extends StatefulWidget {
  const MainScreen({super.key});

  @override
  State<MainScreen> createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen> {
  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      body: SafeArea(
        child: CustomScrollView(
          slivers: <Widget>[
            SliverHeader(),
            SliverAppBar(
              pinned: true,
              title: TextField(
                decoration: InputDecoration(
                  hintText: 'Wyszukaj',
                  contentPadding: EdgeInsets.all(8),
                  border: OutlineInputBorder(),
                ),
              ),
            ),
            SliverToBoxAdapter(
              child: SizedBox(
                height: 2000,
                child: Center(
                  child: Text('Zawartość'),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
