import 'dart:convert';
import 'dart:io';
import 'dart:typed_data';

import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:path_provider/path_provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

import './../../utils/app_assets.dart';
import './../../data/models/json_data_model.dart';
import './../../data/helper/sharedpreferance_helper.dart';

class JsonDataController extends GetxController {
  RxList<JsonDataModel> jsonDataModelList = <JsonDataModel>[].obs;
  RxString selectedIma = "".obs;
  RxBool loadingData = true.obs;
  RxString dirpath = "".obs;
  RxString dataFilePath = "".obs;

  void setListofJsonData(String response) {
    List jsonResponse = jsonDecode(response) as List;
    jsonDataModelList.value =
        jsonResponse.map((e) => JsonDataModel.fromJson(e)).toList();
    loadingData.value = false;
  }

  Future<void> readJsonData() async {
    dirpath.value = (await getApplicationDocumentsDirectory()).path;
    dataFilePath.value = "${dirpath.value}/data.json";
    final SharedPreferanceHelper cacheHelper = SharedPreferanceHelper(
      prefs: await SharedPreferences.getInstance(),
    );
    if (cacheHelper.getFlag) {
      if (dataFilePath.value.isNotEmpty) {
        setListofJsonData(File(dataFilePath.value).readAsStringSync());
      }
    } else {
      final String response = await rootBundle.loadString(AppAssets.dataURL);
      if (dataFilePath.value.isNotEmpty) {
        File(dataFilePath.value).writeAsStringSync(response);
      }
      await cacheHelper.setFlag(true);
      setListofJsonData(response);
    }
  }

  void reorderCallBack(int oldIndex, int newIndex) async {
    final element = jsonDataModelList.removeAt(oldIndex);
    jsonDataModelList.insert(newIndex, element);
    for (int i = 0; i < jsonDataModelList.length; i++) {
      jsonDataModelList[i].order = i.toString();
    }
    List<Map> mapList =
        jsonDataModelList.map((element) => element.toJson()).toList();
    if (dataFilePath.value.isNotEmpty) {
      File(dataFilePath.value).writeAsStringSync(jsonEncode(mapList));
    }
  }

  Future<void> addItem(String title) async {
    final String uuid = DateTime.now().millisecondsSinceEpoch.toString();
    final Directory imadir = Directory("$dirpath/images");
    final File imafile = File("$dirpath/images/$uuid.jpg");
    final Uint8List byteData = File(selectedIma.value).readAsBytesSync();
    if (!imadir.existsSync()) {
      imadir.createSync(recursive: true);
    }
    if (!imafile.existsSync()) {
      imafile.createSync(recursive: true);
    }
    imafile.writeAsBytesSync(byteData);
    final JsonDataModel model = JsonDataModel(
      id: uuid,
      title: title,
      image: imafile.path,
      order: "0",
    );
    List<JsonDataModel> listofdata = [];
    listofdata.add(model);
    for (int i = 0; i < jsonDataModelList.length; i++) {
      jsonDataModelList[i].order =
          (int.parse(jsonDataModelList[i].order) + 1).toString();
      listofdata.add(jsonDataModelList[i]);
    }
    jsonDataModelList.value = listofdata;
    List<Map> mapList =
        jsonDataModelList.map((element) => element.toJson()).toList();
    if (dataFilePath.value.isNotEmpty) {
      File(dataFilePath.value).writeAsStringSync(jsonEncode(mapList));
    }
  }
}
