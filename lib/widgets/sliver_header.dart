import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class SliverHeader extends StatelessWidget {
  const SliverHeader({super.key});

  @override
  Widget build(BuildContext context) {
    return SliverAppBar(
      title: SvgPicture.asset("assets/fuksiarz_logo.svg"),
      actions: [
        ElevatedButton.icon(
          style: ElevatedButton.styleFrom(shape: const StadiumBorder(), padding: const EdgeInsets.all(0)),
          onPressed: () {},
          icon: const Icon(Icons.add_circle_outlined),
          label: const Text("34,93 zł"),
        )
      ],
      floating: true,
      snap: true,
    );
  }
}
