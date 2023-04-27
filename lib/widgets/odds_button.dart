import 'package:flutter/material.dart';

class OddsButtons extends StatefulWidget {
  final List<double> odds;

  const OddsButtons(this.odds, {super.key});

  @override
  State<OddsButtons> createState() => _OddsButtonsState();
}

class _OddsButtonsState extends State<OddsButtons> with AutomaticKeepAliveClientMixin {
  int? _selectedButtonIndex;

  @override
  Widget build(BuildContext context) {
    super.build(context);
    return Row(
      children: getButtons(),
    );
  }

  List<Widget> getButtons() {
    if (widget.odds.length == 2) {
      return [
        _buildButton(0, '1', widget.odds[0]),
        const SizedBox(width: 6),
        _buildButton(1, '2', widget.odds[1]),
      ];
    }

    return [
      _buildButton(0, '1', widget.odds[0]),
      const SizedBox(width: 6),
      _buildButton(1, 'X', widget.odds[1]),
      const SizedBox(width: 6),
      _buildButton(2, '2', widget.odds[2]),
    ];
  }

  Widget _buildButton(int index, String name, double odds) {
    bool isSelected = index == _selectedButtonIndex;

    return ElevatedButton(
      onPressed: () {
        setState(() {
          if (_selectedButtonIndex == index) {
            _selectedButtonIndex = null;
          } else {
            _selectedButtonIndex = index;
          }
          updateKeepAlive();
        });
      },
      style: ElevatedButton.styleFrom(
        side: isSelected ? null : BorderSide(color: Theme.of(context).dividerColor),
        elevation: 0,
        fixedSize: const Size(49, 45),
        padding: const EdgeInsets.all(0),
        minimumSize: Size.zero,
        foregroundColor: isSelected ? Colors.white : Colors.black,
        backgroundColor: isSelected ? Theme.of(context).primaryColor : Colors.white,
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text(
            name,
            style: const TextStyle(fontSize: 8),
          ),
          Text(
            odds.toString(),
            style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 12),
          ),
        ],
      ),
    );
  }

  @override
  bool get wantKeepAlive => _selectedButtonIndex != null;
}
