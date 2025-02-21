import 'package:flutter/material.dart';
import 'package:zimozi_store/config/app_colors.dart';
import 'package:zimozi_store/widgets/common/image_view.dart';
import 'package:zimozi_store/widgets/common/text_widgets.dart';

class AccountTilesView extends StatelessWidget {
  const AccountTilesView({super.key, required this.title, required this.icon,
  required this.onPressed});

  final String title;
  final String icon;
  final Function() onPressed;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onPressed,
      child: Container(
        padding: EdgeInsets.symmetric(vertical: 12),
        child: Row(
          children: [
            ImageView(imageUrl: icon, isSVG: true, color: AppColors.orangeColor,
            height: 20,width: 20),
            SizedBox(width: 10),
            Expanded(child: MediumTextView(data: title)),
            Icon(Icons.navigate_next)
          ],
        ),
      ),
    );
  }
}
