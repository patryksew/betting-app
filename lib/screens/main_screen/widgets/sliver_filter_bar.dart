import 'package:flutter/material.dart';
import 'package:fuksiarz/models/event_category.dart';
import 'package:fuksiarz/providers/events_by_categories_provider.dart';
import 'package:provider/provider.dart';

class SliverFilterBar extends StatefulWidget {
  const SliverFilterBar({super.key, required TabController controller}) : _tabController = controller;

  final TabController _tabController;

  @override
  State<SliverFilterBar> createState() => _SliverFilterBarState();
}

class _SliverFilterBarState extends State<SliverFilterBar> {
  @override
  void initState() {
    super.initState();

    widget._tabController.addListener(() {
      setState(() {});
    });
  }

  @override
  Widget build(BuildContext context) {
    return SliverPersistentHeader(
      pinned: true,
      delegate: _SliverFilterDelegate(widget._tabController),
    );
  }
}

class _SliverFilterDelegate extends SliverPersistentHeaderDelegate {
  final TabController _tabController;
  final ScrollController _scrollController = ScrollController();

  _SliverFilterDelegate(this._tabController);

  @override
  Widget build(BuildContext context, double shrinkOffset, bool overlapsContent) {
    return Container(
      decoration: BoxDecoration(
        color: Theme.of(context).scaffoldBackgroundColor,
        border: Border(
          bottom: BorderSide(color: Theme.of(context).dividerColor),
        ),
      ),
      height: 50,
      child: Row(
        children: [
          IconButton(onPressed: () {}, icon: const Icon(Icons.tune)),
          Expanded(
            child: SingleChildScrollView(
              controller: _scrollController,
              scrollDirection: Axis.horizontal,
              child: Row(children: getChildren(_tabController.index)),
            ),
          ),
        ],
      ),
    );
  }

  List<Widget> getChildren(int index) {
    switch (index) {
      case 1:
        final categories = [
          EventCategory([1], ['Piłka nożna']),
          EventCategory([2], ['Koszykówka']),
          EventCategory([3], ['Baseball']),
          EventCategory([4], ['Hokej na lodzie']),
          EventCategory([5], ['Tenis']),
          EventCategory([6], ['Piłka ręczna']),
          EventCategory([7], ['Unihokej']),
        ];
        return categories.map((e) => _Item(category: e)).toList();
      default:
        return [];
    }
  }

  @override
  double get maxExtent => 50;

  @override
  double get minExtent => 50;

  @override
  bool shouldRebuild(covariant SliverPersistentHeaderDelegate oldDelegate) => true;
}

class _Item extends StatelessWidget {
  final EventCategory category;

  const _Item({super.key, required this.category});

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(right: 10),
      height: 30,
      child: TextButton(
        style: TextButton.styleFrom(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(25),
            side: BorderSide(color: Theme.of(context).dividerColor),
          ),
          padding: const EdgeInsets.all(9.5),
          backgroundColor: Provider.of<EventsByCategoriesProvider>(context).isSelected(category)
              ? Theme.of(context).primaryColor
              : Theme.of(context).scaffoldBackgroundColor,
        ),
        onPressed: () {
          Provider.of<EventsByCategoriesProvider>(context, listen: false).toogleCategory(category);
        },
        child: Text(
          category.displayName,
          style: TextStyle(
            fontWeight: FontWeight.bold,
            fontSize: 10,
            color: Provider.of<EventsByCategoriesProvider>(context).isSelected(category) ? Colors.white : Colors.grey,
          ),
        ),
      ),
    );
  }
}
