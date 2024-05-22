import 'package:flutter/material.dart';
import 'package:flutter_web_actions_build/mall/themes/mulan_colors.dart';
import 'dart:ui' as ui;

import 'package:flutter_web_actions_build/widgets/text_widget.dart';

class TabBarWidget extends StatefulWidget {
  late List<String> list;
  ValueChanged<int>? onTap;
  TabIndexController? indexController;

  TabBarWidget({key, required this.list, this.onTap, this.indexController}) : super(key: key);

  @override
  _TabBarWidgetState createState() => _TabBarWidgetState();
}

const tabIndicatorWidth = 30.0;
const tabIndicatorHeight = 4.0;

class _TabBarWidgetState extends State<TabBarWidget> with AutomaticKeepAliveClientMixin, SingleTickerProviderStateMixin {
  int _select = 0;
  late TabController _tabController;

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: widget.list.length, vsync: this)
      ..addListener(() {
        setState(() {
          _select = _tabController.index;
        });
      });
    widget.indexController?.addListener(() {
      setState(() {
        if (widget.indexController!.index >= 0) {
          _tabController.index = widget.indexController!.index;
        }
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    super.build(context);
    return Container(
      color: Colors.white,
      width: MediaQuery.of(context).size.width,
      height: 46,
      child: TabBar(
        tabs: _tabs(),
        indicatorColor: Colors.transparent,
        tabAlignment: TabAlignment.start,
        indicatorPadding: const EdgeInsets.fromLTRB(10, 0, 10, 0),
        isScrollable: true,
        controller: _tabController,
        onTap: widget.onTap,
      ),
    );
  }

  List<Widget> _tabs() {
    List<Widget> listTab = [];
    for (int i = 0; i < widget.list.length; i++) {
      listTab.add(Tab(
          child: SizedBox(
        height: 46,
        child: Column(
          children: [
            Container(
              alignment: Alignment.center,
              constraints: const BoxConstraints(minWidth: tabIndicatorWidth),
              child: TextWidget(
                widget.list[i],
                paddingTop: 12,
                paddingBottom: 4,
                fontSize: 16,
                textColor: MulanColors.black,
                fontWeight: _select == i ? FontWeight.w700 : FontWeight.normal,
              ),
            ),
            Visibility(
              visible: _select == i,
              maintainAnimation: true,
              maintainSize: true,
              maintainState: true,
              child: CustomPaint(
                size: const Size(tabIndicatorWidth, tabIndicatorHeight),
                painter: _RRectPainter(),
              ),
            ),
          ],
        ),
      )));
    }
    return listTab;
  }

  @override
  bool get wantKeepAlive => true;

  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }
}

class _RRectPainter extends CustomPainter {
  final Paint _paint = Paint()
    ..color = MulanColors.blue
    ..shader = ui.Gradient.linear(const Offset(0, 0), const Offset(tabIndicatorWidth, 0), [MulanColors.blueStartColor, MulanColors.blueEndColor])
    ..strokeCap = StrokeCap.round
    ..isAntiAlias = true
    ..style = PaintingStyle.fill
    ..strokeWidth = 2;

  @override
  void paint(Canvas canvas, Size size) {
    Rect rect = const Rect.fromLTWH(0, 0, tabIndicatorWidth, tabIndicatorHeight);
    RRect rRect = RRect.fromRectAndRadius(rect, const Radius.circular(3));
    canvas.drawRRect(rRect, _paint);
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) {
    return true;
  }
}

class TabIndexController extends ChangeNotifier {
  int index;

  TabIndexController({this.index = -1});

  trigger() {
    notifyListeners();
  }
}