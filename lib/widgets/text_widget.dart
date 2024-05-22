import 'package:flutter/material.dart';

class TextWidget extends StatelessWidget {
  double? padding = 0;
  double? margin = 0;
  double? paddingLeft = 0;
  double? paddingRight = 0;
  double? paddingTop = 0;
  double? paddingBottom = 0;
  double? marginLeft = 0;
  double? marginRight = 0;
  double? marginTop = 0;
  double? marginBottom = 0;
  double? fontSize = 0;
  Color? textColor = Colors.black;
  Color? backgroundColor = Colors.transparent;
  AlignmentGeometry? alignment = Alignment.center;
  double? cornerRadius = 0;
  double? borderWidth = 0;
  Color? borderColor = Colors.transparent;
  String content = "";
  bool? singleLine = false;
  FontWeight? fontWeight = FontWeight.normal;
  bool? isCenter = false;
  int? maxLines = 0;
  VoidCallback? onClick;

  TextWidget(this.content,
      {this.textColor,
      this.backgroundColor,
      this.padding,
      this.paddingTop,
      this.paddingBottom,
      this.paddingRight,
      this.paddingLeft,
      this.cornerRadius,
      this.borderColor,
      this.borderWidth,
      this.marginBottom,
      this.marginLeft,
      this.marginRight,
      this.marginTop,
      this.margin,
      this.fontSize,
      this.singleLine,
      this.fontWeight,
      this.isCenter,
      this.maxLines,
      this.onClick}) {
    if (padding != null) {
      if (padding != null && padding! > 0) {
        paddingLeft = padding;
        paddingRight = padding;
        paddingBottom = padding;
        paddingTop = padding;
      }
    }

    if (margin != null) {
      if (margin != null && margin! > 0) {
        marginLeft = margin;
        marginTop = margin;
        marginRight = margin;
        marginBottom = margin;
      }
    }

    if (onClick == Null) {
      onClick = () {};
    }
  }

  @override
  Widget build(BuildContext context) {
    return Container(
        margin: EdgeInsets.fromLTRB(marginLeft ?? 0, marginTop ?? 0, marginRight ?? 0, marginBottom ?? 0),
        decoration: BoxDecoration(
          border: Border.all(width: borderWidth ?? 0, color: borderColor ?? Colors.transparent),
          color: backgroundColor,
          borderRadius: BorderRadius.all(Radius.circular(cornerRadius ?? 0)),
        ),
        padding: EdgeInsets.fromLTRB(paddingLeft ?? 0, paddingTop ?? 0, paddingRight ?? 0, paddingBottom ?? 0),
        child: GestureDetector(
          onTap: onClick,
          child: Text(
            content,
            textAlign: isCenter ?? false ? TextAlign.center : TextAlign.start,
            maxLines: maxLines,
            style: TextStyle(
                decoration: TextDecoration.none,
                color: textColor,
                fontSize: fontSize ?? 14,
                fontWeight: fontWeight ?? FontWeight.normal,
                overflow: singleLine ?? false ? TextOverflow.ellipsis : TextOverflow.clip),
          ),
        ));
  }
}
