import 'package:flutter/material.dart';

class RecommendedProducts extends StatelessWidget {
  const RecommendedProducts({super.key});

  List<Widget> getItems() {
    final List<String> items = [
      'cashback',
      'early_payout',
      'fuks_kreator',
      'fukso_mania',
      'mega_boost',
      'zaklad_bez_ryzyka',
    ];

    List<Widget> mappedItems = [];

    for (var item in items) {
      mappedItems.add(_Item(item));
      mappedItems.add(const SizedBox(width: 8));
    }

    mappedItems = mappedItems.sublist(0, mappedItems.length - 1);

    return mappedItems;
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        Container(
          margin: const EdgeInsets.symmetric(horizontal: 20),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              const Text(
                'POLECANE PRODUKTY:',
                style: TextStyle(fontWeight: FontWeight.bold, fontSize: 12),
              ),
              Text(
                'POKAŻ WSZYSTKIE',
                style: TextStyle(
                  fontSize: 12,
                  fontWeight: FontWeight.bold,
                  color: Theme.of(context).primaryColor,
                ),
              ),
            ],
          ),
        ),
        const SizedBox(
          height: 16,
        ),
        Container(
          margin: const EdgeInsets.symmetric(horizontal: 20),
          child: SingleChildScrollView(
            scrollDirection: Axis.horizontal,
            child: Row(
              children: getItems(),
            ),
          ),
        ),
      ],
    );
  }
}

class _Item extends StatelessWidget {
  final String name;

  const _Item(this.name);

  @override
  Widget build(BuildContext context) {
    return ClipRRect(
      clipBehavior: Clip.antiAlias,
      borderRadius: BorderRadius.circular(5),
      child: Image.asset(
        "assets/recommended_products/$name.jpg",
        width: 60,
        height: 80,
      ),
    );
  }
}
