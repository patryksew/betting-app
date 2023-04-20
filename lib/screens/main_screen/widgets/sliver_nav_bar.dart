import 'package:flutter/material.dart';

class SliverNavBar extends StatelessWidget {
  const SliverNavBar({super.key, required TabController controller}) : _tabController = controller;

  final TabController _tabController;

  @override
  Widget build(BuildContext context) {
    return SliverPersistentHeader(
      pinned: true,
      delegate: _CustomSliverPersistentHeaderDelegate(_tabController),
    );
  }
}

class _CustomSliverPersistentHeaderDelegate extends SliverPersistentHeaderDelegate {
  final TabController _tabController;
  final ScrollController _scrollController = ScrollController();

  _CustomSliverPersistentHeaderDelegate(this._tabController);

  final TextStyle _textStyle = const TextStyle(
    fontSize: 10,
    fontWeight: FontWeight.bold,
  );

  @override
  Widget build(BuildContext context, double shrinkOffset, bool overlapsContent) {
    return Container(
      color: Theme.of(context).scaffoldBackgroundColor,
      child: SingleChildScrollView(
        controller: _scrollController,
        scrollDirection: Axis.horizontal,
        child: Row(
          children: [
            _TabBarItem(
              index: 0,
              tabController: _tabController,
              scrollController: _scrollController,
              child: Text(
                'OFERTA',
                style: _textStyle,
              ),
            ),
            _TabBarItem(
              index: 1,
              tabController: _tabController,
              scrollController: _scrollController,
              child: Text(
                'MOJE',
                style: _textStyle,
              ),
            ),
            _TabBarItem(
              index: 2,
              tabController: _tabController,
              scrollController: _scrollController,
              child: Row(
                children: [
                  Text(
                    'LIVE',
                    style: _textStyle,
                  ),
                  Container(
                    margin: const EdgeInsets.only(left: 3),
                    width: 6,
                    height: 6,
                    decoration: const BoxDecoration(
                      shape: BoxShape.circle,
                      color: Color.fromRGBO(39, 194, 41, 1),
                    ),
                  ),
                ],
              ),
            ),
            _TabBarItem(
              index: 3,
              tabController: _tabController,
              scrollController: _scrollController,
              child: Text(
                'HOT',
                style: _textStyle,
              ),
            ),
            _TabBarItem(
              index: 4,
              tabController: _tabController,
              scrollController: _scrollController,
              child: Text(
                'CASHBACK',
                style: _textStyle,
              ),
            ),
            _TabBarItem(
              index: 5,
              tabController: _tabController,
              scrollController: _scrollController,
              child: const Icon(
                Icons.calendar_month_outlined,
                size: 24,
              ),
            ),
            _TabBarItem(
              index: 6,
              tabController: _tabController,
              scrollController: _scrollController,
              child: Text(
                'MEGA BOOST',
                style: _textStyle,
              ),
            ),
            _TabBarItem(
              index: 7,
              tabController: _tabController,
              scrollController: _scrollController,
              child: Text(
                'TV',
                style: _textStyle,
              ),
            ),
          ],
        ),
      ),
    );
  }

  @override
  double get maxExtent => 45;

  @override
  double get minExtent => 45;

  @override
  bool shouldRebuild(covariant SliverPersistentHeaderDelegate oldDelegate) => true;
}

class _TabBarItem extends StatefulWidget {
  final int index;
  final Widget child;
  final TabController tabController;
  final ScrollController scrollController;

  const _TabBarItem(
      {required this.index, required this.child, required this.tabController, required this.scrollController});

  @override
  State<_TabBarItem> createState() => __TabBarItemState();
}

class __TabBarItemState extends State<_TabBarItem> {
  bool selected = false;

  @override
  void initState() {
    if (widget.index == widget.tabController.index) {
      setState(() {
        selected = true;
      });
    }
    widget.tabController.addListener(() {
      setState(() {
        if (widget.tabController.index == widget.index) {
          selected = true;
          final renderObject = context.findRenderObject();
          if (renderObject == null) return;
          Scrollable.of(context).position.ensureVisible(renderObject);
        } else {
          selected = false;
        }
      });
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return TextButton(
      onPressed: () {
        widget.tabController.animateTo(widget.index);
      },
      style: TextButton.styleFrom(
        padding: const EdgeInsets.all(0),
        shape: const RoundedRectangleBorder(),
        minimumSize: const Size(0, 0),
      ),
      child: ConstrainedBox(
        //To fill the whole button
        constraints: const BoxConstraints(minWidth: 48),
        child: Container(
          padding: EdgeInsets.symmetric(
            horizontal: selected ? 14 : 15,
            // vertical: 17,
          ),
          height: 45,
          decoration: BoxDecoration(
            border: !selected
                ? Border(
                    bottom: BorderSide(color: Theme.of(context).dividerColor),
                  )
                : Border.symmetric(
                    vertical: BorderSide(color: Theme.of(context).dividerColor),
                  ),
            gradient: selected
                ? null
                : const LinearGradient(
                    begin: Alignment.bottomCenter,
                    end: Alignment.topCenter,
                    colors: [
                      Color.fromRGBO(241, 241, 241, 1),
                      Color.fromRGBO(241, 241, 241, 0),
                    ],
                  ),
            color: Theme.of(context).scaffoldBackgroundColor,
          ),
          child: Center(child: widget.child),
        ),
      ),
    );
  }
}
