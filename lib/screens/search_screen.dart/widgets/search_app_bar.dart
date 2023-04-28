import 'dart:math';

import 'package:flutter/material.dart';

class SearchAppBar extends StatelessWidget implements PreferredSizeWidget {
  final TextEditingController controller;
  final Function(String) onChanged;

  const SearchAppBar({
    super.key,
    required this.controller,
    required this.onChanged,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 30),
      height: double.infinity,
      child: TextField(
        onChanged: onChanged,
        controller: controller,
        style: const TextStyle(
          fontSize: 12,
          fontWeight: FontWeight.w600,
        ),
        decoration: InputDecoration(
          fillColor: Colors.white,
          filled: true,
          prefixIcon: IconButton(onPressed: Navigator.of(context).pop, icon: const Icon(Icons.chevron_left)),
          suffixIcon: IconButton(
              onPressed: () {
                controller.clear();
                onChanged('');
              },
              icon: Transform.rotate(angle: pi / 4, child: const Icon(Icons.add_circle))),
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(5),
            borderSide: BorderSide(color: Theme.of(context).dividerColor),
          ),
        ),
      ),
    );
  }

  @override
  Size get preferredSize => const Size.fromHeight(115);
}
