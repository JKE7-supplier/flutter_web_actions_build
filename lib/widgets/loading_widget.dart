import 'package:flutter/material.dart';




class LoadingWidget extends Dialog {

  final String title;

  const LoadingWidget(this.title, {Key? key}) : super(key: key);



  @override
  Widget build(BuildContext context) {
    return Material(
      type: MaterialType.transparency,
      child: Center(
        child: SizedBox(
          width: 120.0,
          height: 120.0,
          child: Container(
            decoration: const ShapeDecoration(
              color: Color(0xffffffff),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.all(
                  Radius.circular(8.0),
                ),
              ),
            ),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: <Widget>[
                const CircularProgressIndicator(
                    valueColor: AlwaysStoppedAnimation(Color(0xffAA1F52))),
                Padding(
                  padding: const EdgeInsets.only(
                    top: 20.0,
                  ),
                  child: Text(title),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

}
