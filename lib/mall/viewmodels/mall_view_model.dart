import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_web_actions_build/mall/services/mall_response.dart';
import 'package:flutter_web_actions_build/mall/viewmodels/mall_get_api_view_model.dart';
import 'package:flutter_web_actions_build/viewmodel/base_view_model.dart';

class MallViewModel extends BaseViewModel {
  final _mallGetApiViewModel = MallGetApiViewModel();

  List<String> tabName = [];
  List<ProductEntity> filterProducts = [];
  List<CategoriesEntity> filterCategories = [];

  StreamController<String> titleStream = StreamController();
  StreamController<List<String>> tabNameStream = StreamController();
  StreamController<List<ProductEntity>> productsItemSteam = StreamController();

  @override
  void doInit(BuildContext context) {
    WidgetsBinding.instance.addPostFrameCallback((_) {
      fetchACPConfiguration();
    });
  }

  @override
  void dispose() {}

  changeTab(int index) {}

  fetchACPConfiguration() async {
    // showFullScreenLoading(context);

    try {
      await Future.delayed(const Duration(milliseconds: 20));

      MallResponse response = await _mallGetApiViewModel.fetchACPConfiguration();
      if (response.isSuccess && response.bean != null) {
        String? title = response.bean?.pageInfo.appRevampTitle;
        titleStream.sink.add(title ?? "");

        List<ProductEntity>? products = response.bean?.products;

        if (products?.isNotEmpty == true) {
          filterProducts = products!.where((product) => product.value.appEnabled == true && product.value.stageOnly == false && product.value.name.isNotEmpty).toList();
          productsItemSteam.sink.add(filterProducts);
        }

        List<CategoriesEntity>? categories = response.bean?.categories;
        filterCategories.clear();
        if (categories?.isNotEmpty == true) {
          categories?.forEach((category) {
            if (filterProducts.isNotEmpty == true) {
              for (var product in filterProducts) {
                if (category.value.id == product.value.categoryId) {
                  category.enable = true;
                  if (!filterCategories.contains(category)) {
                    filterCategories.add(category);
                  }
                }
              }
            }
          });
          if (filterCategories.isNotEmpty == true) {
            filterCategories.forEach((element) {
              tabName.add(element.value.name ?? "");
            });
            tabNameStream.sink.add(tabName);
          }
        }
      }
    } finally {
      // dismissLoading(context);
    }
  }
}
