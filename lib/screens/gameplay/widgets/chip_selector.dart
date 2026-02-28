import 'package:flutter/material.dart';

class ChipSelector extends StatelessWidget {
  final List<int> chipValues;
  final int selectedValue;
  final ValueChanged<int> onChipSelected;

  const ChipSelector({
    super.key,
    this.chipValues = const [100, 500, 1000, 5000, 10000],
    required this.selectedValue,
    required this.onChipSelected,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(vertical: 12, horizontal: 8),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: chipValues.map((value) {
          final isSelected = selectedValue == value;
          return _ChipButton(
            value: value,
            isSelected: isSelected,
            onTap: () => onChipSelected(value),
          );
        }).toList(),
      ),
    );
  }
}

class _ChipButton extends StatelessWidget {
  final int value;
  final bool isSelected;
  final VoidCallback onTap;

  const _ChipButton({
    required this.value,
    required this.isSelected,
    required this.onTap,
  });

  Color get _chipColor {
    if (value >= 10000) return const Color(0xFFE91E63);
    if (value >= 5000) return const Color(0xFF9C27B0);
    if (value >= 1000) return const Color(0xFF2196F3);
    if (value >= 500) return const Color(0xFF4CAF50);
    return const Color(0xFFFFC107);
  }

  String get _displayValue {
    if (value >= 1000) return '${value ~/ 1000}K';
    return value.toString();
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 200),
        width: 56,
        height: 56,
        decoration: BoxDecoration(
          shape: BoxShape.circle,
          gradient: LinearGradient(
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
            colors: isSelected
                ? [
                    _chipColor,
                    _chipColor.withOpacity(0.7),
                  ]
                : [
                    _chipColor.withOpacity(0.5),
                    _chipColor.withOpacity(0.3),
                  ],
          ),
          boxShadow: [
            BoxShadow(
              color: _chipColor.withOpacity(isSelected ? 0.5 : 0.2),
              blurRadius: isSelected ? 12 : 6,
              offset: const Offset(0, 4),
            ),
            BoxShadow(
              color: Colors.white.withOpacity(0.2),
              blurRadius: 2,
              offset: const Offset(-1, -1),
            ),
          ],
          border: Border.all(
            color: isSelected ? Colors.white : Colors.white.withOpacity(0.3),
            width: isSelected ? 3 : 1,
          ),
        ),
        child: Center(
          child: Text(
            _displayValue,
            style: TextStyle(
              fontSize: 12,
              fontWeight: FontWeight.bold,
              color: isSelected ? Colors.white : Colors.white.withOpacity(0.9),
            ),
          ),
        ),
      ),
    );
  }
}
