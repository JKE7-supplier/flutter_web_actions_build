import 'dart:async';

import 'package:flutter/cupertino.dart';
import 'package:flutter_web_actions_build/viewmodel/base_view_model.dart';
import 'package:url_launcher/url_launcher.dart';

class JSBridgeViewModel extends BaseViewModel {
  String _inputText = '';
  StreamController<String> inputStream = StreamController<String>();
  StreamController<String> resultStream = StreamController<String>();

  void updateInput(String text) {
    _inputText = text;
    inputStream.sink.add(text);
  }

  Future<void> onButtonPressed() async {
    resultStream.sink.add(_inputText);
  }

  Future<void> openDisneyApp() async {
    // 通过 url_launcher 打开 App Link
    final uri = Uri.parse('https://shdr.cn/g');
    final launched = await launchUrl(uri, mode: LaunchMode.externalApplication);
    resultStream.sink.add(launched ? '已尝试拉起 Disney App' : '拉起失败');
  }

  Future<void> openDisneyAppByPackage() async {
    // 通过包名拉起 App，使用 intent:// scheme
    final uri = Uri.parse('intent://com.disney.shanghaidisneyland_goo/#Intent;scheme=https;package=com.disney.shanghaidisneyland_goo;end');
    final launched = await launchUrl(uri, mode: LaunchMode.externalApplication);
    resultStream.sink.add(launched ? '已尝试通过包名拉起 Disney App' : '拉起失败');
  }

  @override
  void doInit(BuildContext context) {}

  @override
  void dispose() {
    inputStream.close();
    resultStream.close();
  }
}
