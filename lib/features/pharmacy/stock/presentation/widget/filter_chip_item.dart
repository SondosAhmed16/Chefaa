import 'package:chefaa/core/resources/color.dart';
import 'package:chefaa/core/resources/style.dart';
import 'package:flutter/material.dart';

class FilterChipItem extends StatelessWidget {
  final String label;
  final String value;
  final bool isSelected;
  final Function(bool) onSelected;

  const FilterChipItem({
    super.key,
    required this.label,
    required this.value,
    required this.isSelected,
    required this.onSelected,
  });

  @override
  Widget build(BuildContext context) {
    return ChoiceChip(
      label: Text(label),
      selected: isSelected,
      selectedColor: ColorManager.primary,
      labelStyle: getMediumStyle(
        color: isSelected ? ColorManager.white : ColorManager.black,
        fontSize: 14,
      ),
      onSelected: onSelected,
    );
  }
}
