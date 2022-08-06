import 'package:flutter/material.dart';

import './../../utils/app_colors.dart';
import './../../utils/app_textstyles.dart';

class ImagePickerOptions extends StatelessWidget {
  final String title;
  final String imageIcon;
  final Function onClick;
  const ImagePickerOptions({
    Key? key,
    required this.title,
    required this.imageIcon,
    required this.onClick,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        onClick();
      },
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 25),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Image(
              image: AssetImage(imageIcon),
              width: 35,
              color: AppColors.primaryColor,
            ),
            const SizedBox(
              width: 15,
            ),
            Text(
              title,
              style: AppTextStyle.h1,
            ),
            const SizedBox(
              width: 10,
            ),
          ],
        ),
      ),
    );
  }
}
