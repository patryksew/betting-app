import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class SliverHeader extends StatelessWidget {
  const SliverHeader({super.key});

  @override
  Widget build(BuildContext context) {
    return SliverPersistentHeader(
      delegate: _SliverHeaderDelegate(),
      floating: true,
      pinned: false,
    );
  }
}

class _SliverHeaderDelegate extends SliverPersistentHeaderDelegate {
  @override
  Widget build(BuildContext context, double shrinkOffset, bool overlapsContent) {
    return Container(
      height: 70,
      color: Theme.of(context).scaffoldBackgroundColor,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Container(
                margin: const EdgeInsets.only(left: 20, top: 27.5),
                child: SvgPicture.asset(
                  "assets/fuksiarz_logo.svg",
                  height: 20,
                ),
              ),
              Container(
                margin: const EdgeInsets.only(right: 20, top: 20),
                height: 35,
                child: TextButton.icon(
                  style: TextButton.styleFrom(
                    shape: const StadiumBorder(),
                    padding: const EdgeInsets.symmetric(horizontal: 10),
                    backgroundColor: Colors.transparent,
                    side: BorderSide(
                      color: Theme.of(context).dividerColor,
                    ),
                  ),
                  onPressed: () {},
                  icon: Icon(
                    Icons.add_circle_outlined,
                    color: Theme.of(context).primaryColor,
                  ),
                  label: const Text(
                    "34,93 zł",
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 12,
                    ),
                  ),
                ),
              )
            ],
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
  bool shouldRebuild(covariant SliverPersistentHeaderDelegate oldDelegate) => false;
}
