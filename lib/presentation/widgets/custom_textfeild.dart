import 'package:flutter/material.dart';

import './../../utils/app_colors.dart';

class CustomTextFeild extends StatelessWidget {
  final TextEditingController controller;
  final String hintstr;
  const CustomTextFeild({
    Key? key,
    required this.controller,
    required this.hintstr,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(
        vertical: 8,
        horizontal: 18,
      ),
      margin: const EdgeInsets.symmetric(
        horizontal: 20,
        vertical: 10,
      ),
      decoration: BoxDecoration(
        color: AppColors.white,
        borderRadius: BorderRadius.circular(8),
        boxShadow: [
          BoxShadow(
            offset: const Offset(0, 10),
            blurRadius: 20,
            color: AppColors.grey.withOpacity(0.23),
          ),
        ],
      ),
      child: TextField(
        controller: controller,
        style: TextStyle(
          fontSize: 18,
          color: AppColors.black.withOpacity(0.8),
        ),
        decoration: InputDecoration(
          hintText: hintstr,
          border: InputBorder.none,
        ),
      ),
    );
  }
}
