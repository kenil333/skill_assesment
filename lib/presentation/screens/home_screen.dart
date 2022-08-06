import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:reorderable_grid_view/reorderable_grid_view.dart';

import './../../utils/app_colors.dart';
import './../../utils/app_texts.dart';
import './../controllers/json_data_controller.dart';
import './confirm_screen.dart';
import './../widgets/bottom_sheet_widget.dart';
import './../widgets/grid_item_widget.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  JsonDataController controller = Get.put(JsonDataController());

  @override
  void initState() {
    super.initState();
    Future.delayed(const Duration(seconds: 0)).then((value) async {
      await controller.readJsonData();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButton: FloatingActionButton(
        backgroundColor: AppColors.orange,
        onPressed: () {
          showModalBottomSheet(
            context: context,
            shape: const RoundedRectangleBorder(
              borderRadius: BorderRadius.vertical(
                top: Radius.circular(20),
              ),
            ),
            clipBehavior: Clip.antiAliasWithSaveLayer,
            builder: (context) => BottomSheetWidget(
              navigateFunction: (String path) {
                controller.selectedIma.value = path;
                Navigator.of(context).pop();
                Navigator.of(context).push(
                  MaterialPageRoute(
                    builder: (context) => const ConfirmScreen(),
                  ),
                );
              },
            ),
          );
        },
        child: const Center(
          child: Icon(
            Icons.add,
            color: AppColors.white,
            size: 30,
          ),
        ),
      ),
      appBar: AppBar(
        backgroundColor: AppColors.primaryColor,
        centerTitle: true,
        title: const Text(AppTexts.homeAppBarTitle),
      ),
      body: Obx(
        () => !controller.loadingData.value
            ? ReorderableGridView.builder(
                padding: const EdgeInsets.symmetric(
                  vertical: 15,
                  horizontal: 8,
                ),
                itemCount: controller.jsonDataModelList.length,
                itemBuilder: (context, index) => GridItemWidget(
                  key: ValueKey(index),
                  model: controller.jsonDataModelList[index],
                ),
                onReorder: controller.reorderCallBack,
                gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisSpacing: 8,
                  mainAxisSpacing: 10,
                  crossAxisCount: 4,
                ),
              )
            : const Center(
                child: CircularProgressIndicator(),
              ),
      ),
    );
  }
}
