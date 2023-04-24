import 'package:flutter/material.dart';

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
    _tabController = TabController(length: 8, vsync: this, initialIndex: 1);
  }

  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: CustomScrollView(
          slivers: [
            const SliverHeader(),
            const SliverSearchButton(),
            SliverNavBar(controller: _tabController),
            SliverToBoxAdapter(
              child: SizedBox(
                height: 1000,
                child: TabBarView(
                  controller: _tabController,
                  children: const [
                    Center(child: Text('OFERTA')),
                    Center(child: Text('MOJE')),
                    Center(child: Text('LIVE')),
                    Center(child: Text('HOT')),
                    Center(child: Text('CASHBACK')),
                    Center(child: Icon(Icons.calendar_month_outlined)),
                    Center(child: Text('MEGA BOOST')),
                    Center(child: Text('TV')),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
