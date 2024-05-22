/* (c) Disney. All rights reserved. */
import 'package:flutter/material.dart';

import 'base_view_model.dart';

class ViewModelProvider<T extends BaseViewModel> extends StatefulWidget {
  final T viewModel;
  final Widget child;

  ViewModelProvider(@required this.viewModel, @required this.child);

  static T of<T extends BaseViewModel>(BuildContext context) {
    ViewModelProvider<T> provider = context.findAncestorWidgetOfExactType<ViewModelProvider<T>>()!;
      return provider.viewModel;
  }

  @override
  _ViewModelProviderState createState() => _ViewModelProviderState();
}

class _ViewModelProviderState extends State<ViewModelProvider> {

  @override
  Widget build(BuildContext context) {
    return MediaQuery(
      data: MediaQuery.of(context).copyWith(textScaleFactor: 1.0),
      child: widget.child,
    );
  }

  @override
  void dispose() {
    widget.viewModel.dispose();
    super.dispose();
  }
}