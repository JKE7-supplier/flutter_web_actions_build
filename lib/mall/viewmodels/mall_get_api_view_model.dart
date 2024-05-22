import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_web_actions_build/mall/services/mall_response.dart';
import 'package:flutter_web_actions_build/mall/services/mall_service.dart';
import 'package:flutter_web_actions_build/viewmodel/base_view_model.dart';

/**
 * Created by Nick on 2023/12/21
 */
class MallGetApiViewModel extends BaseViewModel {
  final _mallService = MallService();

  @override
  void doInit(BuildContext context) {}

  @override
  void dispose() {}

  Future<MallResponse> fetchACPConfiguration() async {
    MallResponse _response = await _mallService.fetchACPConfiguration();
    return Future.value(_response);
  }
}
