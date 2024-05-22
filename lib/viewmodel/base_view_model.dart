import 'package:flutter/widgets.dart';

abstract class BaseViewModel {
  // make doInit init only once
  bool _hasInit = false;
  late BuildContext context;

  // bool get hasInit => _hasInit;
  @mustCallSuper
  void init(BuildContext context) {
    this.context = context;
    if (!_hasInit) {
      doInit(context);
      _hasInit = true;
    }
  }

  @protected
  void doInit(BuildContext context);

  void dispose();
}
