import 'package:flutter/cupertino.dart';
import 'package:flutter_web_actions_build/utils/text_style_extensions.dart';

class MulanTextStyle {
  // This class is not meant to be instantiated or extended; this constructor
  // prevents instantiation and extension.
  MulanTextStyle._();

  static TextStyle headline1 = const TextStyle(fontSize: 20).bold.textHeight(1.3);

  static TextStyle headline2 = const TextStyle(fontSize: 18).bold.textHeight(1.333);

  static TextStyle headline3 = const TextStyle(fontSize: 16).bold.textHeight(1.375);

  static TextStyle headline4 = const TextStyle(fontSize: 14).bold.textHeight(1.429);

  static TextStyle body1 = const TextStyle(fontSize: 16).regular.textHeight(1.375);

  static TextStyle body2 = const TextStyle(fontSize: 14).regular.textHeight(1.429);

  static TextStyle body3 = const TextStyle(fontSize: 12).regular.textHeight(1.5);

  static TextStyle other = const TextStyle(fontSize: 10).regular.textHeight(1.6);
}
