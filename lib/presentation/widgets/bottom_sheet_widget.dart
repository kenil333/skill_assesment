import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';

import './../../utils/app_assets.dart';
import './../../utils/app_colors.dart';
import './../../utils/app_texts.dart';
import './image_picker_option.dart';

class BottomSheetWidget extends StatelessWidget {
  final Function navigateFunction;
  const BottomSheetWidget({
    Key? key,
    required this.navigateFunction,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final ImagePicker picker = ImagePicker();
    return Container(
      decoration: const BoxDecoration(
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(10.0),
          topRight: Radius.circular(10.0),
        ),
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          ImagePickerOptions(
            title: AppTexts.camera,
            imageIcon: AppAssets.camera,
            onClick: () async {
              final XFile? file = await picker.pickImage(
                source: ImageSource.camera,
              );
              if (file != null) {
                navigateFunction(file.path);
              } else {
                Get.snackbar(
                  AppTexts.alertstr,
                  AppTexts.selectImageError,
                  backgroundColor: AppColors.primaryColor,
                  colorText: AppColors.white,
                );
              }
            },
          ),
          Container(
            height: 0.7,
            width: Get.size.width,
            color: AppColors.black.withOpacity(0.2),
          ),
          ImagePickerOptions(
            title: AppTexts.gallery,
            imageIcon: AppAssets.gallery,
            onClick: () async {
              final XFile? file = await picker.pickImage(
                source: ImageSource.gallery,
              );
              if (file != null) {
                navigateFunction(file.path);
              } else {
                Get.snackbar(
                  AppTexts.alertstr,
                  AppTexts.selectImageError,
                  backgroundColor: AppColors.primaryColor,
                  colorText: AppColors.white,
                );
              }
            },
          ),
        ],
      ),
    );
  }
}
