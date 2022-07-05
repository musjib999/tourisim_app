import 'package:flutter/material.dart';

class FadedBackgroundContainer extends StatelessWidget {
  final Icon icon;
  final BoxShape? shape;
  final double? size;
  final Color color;
  const FadedBackgroundContainer({
    Key? key,
    required this.icon,
    this.shape = BoxShape.rectangle,
    this.color = Colors.white,
    this.size,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      width: size,
      height: size,
      decoration: BoxDecoration(
        shape: shape as BoxShape,
        color: color.withOpacity(0.3),
        borderRadius:
            shape == BoxShape.rectangle ? BorderRadius.circular(8.0) : null,
      ),
      child: icon,
    );
  }
}