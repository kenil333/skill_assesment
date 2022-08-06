import 'dart:io';

import 'package:flutter/material.dart';
import 'package:get/get.dart';

import './../../utils/app_colors.dart';
import './../../utils/app_texts.dart';
import './../../presentation/controllers/json_data_controller.dart';
import './../../presentation/widgets/custom_textfeild.dart';

class ConfirmScreen extends StatefulWidget {
  const ConfirmScreen({Key? key}) : super(key: key);

  @override
  State<ConfirmScreen> createState() => _ConfirmScreenState();
}

class _ConfirmScreenState extends State<ConfirmScreen> {
  final JsonDataController controller = Get.find();
  final TextEditingController title = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: AppColors.primaryColor,
        title: const Text(AppTexts.confirmScreen),
      ),
      bottomNavigationBar: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Row(
            children: [
              const SizedBox(width: 20),
              Expanded(
                child: InkWell(
                  onTap: () {
                    controller.selectedIma.value = "";
                    Navigator.of(context).pop();
                  },
                  child: Container(
                    width: double.infinity,
                    height: 50,
                    decoration: BoxDecoration(
                      color: AppColors.primaryColor,
                      borderRadius: BorderRadius.circular(15),
                    ),
                    child: const Center(
                      child: Text(
                        "Cancel",
                        style: TextStyle(
                          fontSize: 20,
                          color: AppColors.white,
                        ),
                      ),
                    ),
                  ),
                ),
              ),
              const SizedBox(width: 20),
              Expanded(
                child: InkWell(
                  onTap: () async {
                    if (title.text.isNotEmpty) {
                      await controller.addItem(title.text);
                      controller.selectedIma.value = "";
                      Navigator.of(context).pop();
                    } else {
                      Get.snackbar(
                        AppTexts.alertstr,
                        AppTexts.addtitle,
                        backgroundColor: AppColors.primaryColor,
                        colorText: AppColors.white,
                      );
                    }
                  },
                  child: Container(
                    width: double.infinity,
                    height: 50,
                    decoration: BoxDecoration(
                      color: AppColors.primaryColor,
                      borderRadius: BorderRadius.circular(15),
                    ),
                    child: const Center(
                      child: Text(
                        "Add",
                        style: TextStyle(
                          fontSize: 20,
                          color: AppColors.white,
                        ),
                      ),
                    ),
                  ),
                ),
              ),
              const SizedBox(width: 20),
            ],
          ),
          SizedBox(height: MediaQuery.of(context).padding.bottom + 10),
        ],
      ),
      body: Column(
        children: [
          const SizedBox(height: 20),
          Row(
            children: [
              Expanded(child: Container()),
              Image.file(
                File(controller.selectedIma.value),
                height: 200,
                fit: BoxFit.contain,
              ),
              Expanded(child: Container()),
            ],
          ),
          const SizedBox(height: 30),
          CustomTextFeild(
            controller: title,
            hintstr: AppTexts.titlestr,
          ),
        ],
      ),
    );
  }
}
