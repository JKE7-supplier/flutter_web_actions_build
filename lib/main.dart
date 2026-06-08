import 'package:flutter/material.dart';
import 'package:flutter_web_actions_build/jsbridge/jsbridge_page.dart';
import 'package:flutter_web_actions_build/jsbridge/viewmodels/jsbridge_view_model.dart';
import 'package:flutter_web_actions_build/mall/mall_page.dart';
import 'package:flutter_web_actions_build/mall/viewmodels/mall_view_model.dart';
import 'package:flutter_web_actions_build/viewmodel/viewmodel_provider.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: DefaultTabController(
        length: 2,
        child: Scaffold(
          appBar: AppBar(
            backgroundColor: Theme.of(context).colorScheme.inversePrimary,
            title: const Text('Flutter Demo'),
            bottom: const TabBar(
              tabs: [
                Tab(text: 'JSBridge'),
                Tab(text: 'Home'),
              ],
            ),
          ),
          body: TabBarView(
            children: [
              ViewModelProvider(JSBridgeViewModel(), const JSBridgePage()),
              ViewModelProvider(MallViewModel(), const MallPage()),
            ],
          ),
        ),
      ),
    );
  }
}
