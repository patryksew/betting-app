import 'package:flutter/material.dart';
import 'package:fuksiarz/models/event_category.dart';
import 'package:fuksiarz/providers/events_by_categories_provider.dart';
import 'package:fuksiarz/screens/main_screen/bodies/my_body.dart';
import 'package:fuksiarz/screens/main_screen/widgets/sliver_filter_bar.dart';
import 'package:fuksiarz/services/events_by_category_service.dart';
import 'package:provider/provider.dart';

import 'widgets/sliver_header.dart';
import 'widgets/sliver_search_button.dart';
import 'widgets/sliver_nav_bar.dart';

class MainScreen extends StatefulWidget {
  const MainScreen({super.key});

  @override
  State<MainScreen> createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen> with SingleTickerProviderStateMixin {
  late final TabController _tabController;

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 7, vsync: this, initialIndex: 1);
    _tabController.addListener(() {
      setState(() {});
    });
  }

  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }

  //Those widgets wrapped with SliverToBoxAdapter are here only for demonstration.
  //When others screens are implemented, they will be moved to other widgets (like my screen)
  final List<Widget> bodies = [
    const SliverToBoxAdapter(
      child: Center(child: Text('OFERTA')),
    ),
    const MyBody(),
    const SliverToBoxAdapter(
      child: Center(child: Text('LIVE')),
    ),
    const SliverToBoxAdapter(
      child: Center(child: Text('HOT')),
    ),
    const SliverToBoxAdapter(
      child: Center(child: Text('CASHBACK')),
    ),
    const SliverToBoxAdapter(
      child: Center(child: Text('MEGA BOOST')),
    ),
    const SliverToBoxAdapter(
      child: Center(child: Text('TV')),
    ),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: ChangeNotifierProvider(
          create: (_) => EventsByCategoriesProvider(),
          builder: (_, __) => CustomScrollView(
            slivers: [
              const SliverHeader(),
              const SliverSearchButton(),
              SliverNavBar(controller: _tabController),
              SliverFilterBar(controller: _tabController),
              bodies[_tabController.index],
            ],
          ),
        ),
      ),
    );
  }
}
