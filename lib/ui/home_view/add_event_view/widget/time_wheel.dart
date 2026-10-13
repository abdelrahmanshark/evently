import 'package:evently/utils/app_colors.dart';
import 'package:evently/utils/app_styles.dart';
import 'package:flutter/material.dart';
import 'package:wheel_picker/wheel_picker.dart';

class TimeWheel extends StatelessWidget {
  const TimeWheel({
    super.key,
    required this.itemCount,
    required this.labelOf,
    required this.onChanged,
    this.looping = true,
  });

  final int itemCount;

  /// Text shown for the item at an index.
  final String Function(int index) labelOf;
  final ValueChanged<int> onChanged;
  final bool looping;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: 40,
      child: WheelPicker(
        itemCount: itemCount,
        looping: looping,
        builder: (context, index) =>
            Text(labelOf(index), style: AppStyles.primaryBold20),
        selectedIndexColor: AppColors.primaryColor,
        style: const WheelPickerStyle(
          itemExtent: 50,
          squeeze: 1.25,
          diameterRatio: .8,
          surroundingOpacity: .25,
          magnification: 1.2,
        ),
        onIndexChanged: (index, interactionType) => onChanged(index),
      ),
    );
  }
}
