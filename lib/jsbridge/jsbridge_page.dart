import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_web_actions_build/jsbridge/viewmodels/jsbridge_view_model.dart';

import '../viewmodel/viewmodel_provider.dart';

class JSBridgePage extends StatefulWidget {
  static const String routeName = "/jsbridge";

  const JSBridgePage({super.key});

  @override
  _JSBridgePageState createState() => _JSBridgePageState();
}

class _JSBridgePageState extends State<JSBridgePage> {
  late JSBridgeViewModel _viewModel;
  final TextEditingController _textController = TextEditingController();

  @override
  void initState() {
    super.initState();
    _viewModel = ViewModelProvider.of(context);
  }

  @override
  void dispose() {
    _textController.dispose();
    _viewModel.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('JSBridge Test'),
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              'JSBridge Name',
              style: TextStyle(fontSize: 16, fontWeight: FontWeight.w500),
            ),
            const SizedBox(height: 8),
            TextField(
              controller: _textController,
              inputFormatters: [
                FilteringTextInputFormatter.allow(RegExp(r'^[a-zA-Z0-9]+$')),
              ],
              decoration: const InputDecoration(
                hintText: 'Enter English and numbers only',
                border: OutlineInputBorder(),
              ),
              onChanged: (value) {
                _viewModel.updateInput(value);
              },
            ),
            const SizedBox(height: 24),
            SizedBox(
              width: double.infinity,
              child: ElevatedButton(
                onPressed: () {
                  _viewModel.onButtonPressed();
                },
                child: const Text('Call JSBridge'),
              ),
            ),
            const SizedBox(height: 24),
            SizedBox(
              width: double.infinity,
              child: ElevatedButton(
                onPressed: () {
                  _viewModel.openDisneyApp();
                },
                child: const Text('通过“scheme”打开Disney App'),
              ),
            ),
            const SizedBox(height: 16),
            SizedBox(
              width: double.infinity,
              child: ElevatedButton(
                onPressed: () {
                  _viewModel.openDisneyAppByPackage();
                },
                child: const Text('通过包名打开Disney App'),
              ),
            ),
            const SizedBox(height: 24),
            const Text(
              'Result:',
              style: TextStyle(fontSize: 16, fontWeight: FontWeight.w500),
            ),
            const SizedBox(height: 8),
            StreamBuilder<String>(
              stream: _viewModel.resultStream.stream,
              builder: (context, snapshot) {
                return Container(
                  width: double.infinity,
                  padding: const EdgeInsets.all(16),
                  decoration: BoxDecoration(
                    color: Colors.grey[200],
                    borderRadius: BorderRadius.circular(8),
                  ),
                  child: Text(
                    snapshot.data ?? '',
                    style: const TextStyle(fontSize: 14),
                  ),
                );
              },
            ),
          ],
        ),
      ),
    );
  }
}
