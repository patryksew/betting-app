import 'package:flutter/material.dart';

class SearchResultStatus extends StatelessWidget {
  final Icon icon;
  final String title;
  final String? message;

  const SearchResultStatus({super.key, required this.icon, required this.title, this.message});

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 20),
      child: Center(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            const Spacer(),
            icon,
            const SizedBox(height: 28),
            Text(
              title,
              textAlign: TextAlign.center,
              style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
            ),
            const SizedBox(height: 8),
            if (message != null)
              Text(
                message!,
                textAlign: TextAlign.center,
                style: const TextStyle(fontWeight: FontWeight.w600, fontSize: 10),
              ),
            const Spacer(flex: 2),
          ],
        ),
      ),
    );
  }
}
