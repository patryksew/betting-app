import 'package:flutter/material.dart';
import 'package:fuksiarz/screens/search_screen.dart/search_screen.dart';

class SliverSearchButton extends StatelessWidget {
  const SliverSearchButton({super.key});

  @override
  Widget build(BuildContext context) {
    return SliverPersistentHeader(
      pinned: true,
      delegate: _SliverSearchButtonDelegate(),
    );
  }
}

class _SliverSearchButtonDelegate extends SliverPersistentHeaderDelegate {
  @override
  Widget build(BuildContext context, double shrinkOffset, bool overlapsContent) {
    return Container(
      height: 67,
      color: Theme.of(context).scaffoldBackgroundColor,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Container(
            height: 37,
            margin: const EdgeInsets.only(top: 15, left: 10, right: 10),
            child: TextButton(
              style: TextButton.styleFrom(
                fixedSize: const Size.fromHeight(37),
                backgroundColor: Colors.white,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(5),
                  side: BorderSide(
                    color: Theme.of(context).dividerColor,
                  ),
                ),
                padding: const EdgeInsets.all(10),
              ),
              onPressed: () {
                Navigator.of(context).push(MaterialPageRoute(builder: (_) => const SearchScreen()));
              },
              child: Row(
                children: const [
                  Icon(
                    Icons.search,
                    size: 18,
                  ),
                  Text(
                    "CZEGO SZUKASZ",
                    style: TextStyle(fontWeight: FontWeight.w500, fontSize: 10),
                  ),
                ],
              ),
            ),
          ),
          Container(
            color: Theme.of(context).dividerColor,
            height: 1,
          ),
        ],
      ),
    );
  }

  @override
  double get maxExtent => 67;

  @override
  double get minExtent => 67;

  @override
  bool shouldRebuild(covariant SliverPersistentHeaderDelegate oldDelegate) {
    return true;
  }
}
