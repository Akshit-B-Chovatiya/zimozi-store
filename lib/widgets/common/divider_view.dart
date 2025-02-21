import 'package:flutter/material.dart';
import 'package:zimozi_store/config/app_colors.dart';

class DividerView extends StatelessWidget {
  const DividerView(
      {super.key,
      this.leftMargin = 0,
      this.rightMargin = 0,
      this.topMargin = 0,
      this.bottomMargin = 0,
      this.color = AppColors.liteGreyColor,
      this.height = 5,
      this.thickness = 0.8});

  final double leftMargin;
  final double rightMargin;
  final double topMargin;
  final double bottomMargin;
  final Color color;
  final double height;
  final double thickness;

  @override
  Widget build(BuildContext context) {
    return Container(
        margin: EdgeInsets.only(left: leftMargin, right: rightMargin, top: topMargin, bottom: bottomMargin),
        child: Divider(color: color, height: height, thickness: thickness));
  }
}
