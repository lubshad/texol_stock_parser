import 'package:basic_template/basic_template.dart';
import 'package:flutter/material.dart';
import 'package:texol_stock_parser/domain/usecases/get_stock_details.dart';
import 'package:texol_stock_parser/utils/extensions.dart';

class HomeController extends ChangeNotifier {
  GetStockDetails getStockDetails = GetStockDetails(Get.find());

  AppError? appError;
  bool isLoading = true;
  makeLoading() {
    isLoading = true;
    notifyListeners();
  }

  makeNotLoading() {
    isLoading = false;
    notifyListeners();
  }

  retry() async {
    appError = null;
    makeLoading();
    getData();
  }

  getData() async {
    final response = await getStockDetails(NoParams());
    response.fold((l) => l.handleError(), (r) => setData(r));
    makeNotLoading();
  }

  List stockCategoryList = [];

  setData(List r) {
    stockCategoryList.clear();
    for (var category in r) {
      category["color"] =
          category["color"] == "red" ? Colors.red : Colors.green;
      stockCategoryList.add(category);
    }
  }
}
