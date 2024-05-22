import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_web_actions_build/mall/services/mall_response.dart';
import 'package:flutter_web_actions_build/mall/themes/mulan_colors.dart';
import 'package:flutter_web_actions_build/mall/themes/mulan_text_style.dart';
import 'package:flutter_web_actions_build/utils/text_style_extensions.dart';
import 'package:flutter_web_actions_build/widgets/text_widget.dart';

class MallListItemWidget extends StatefulWidget {
  final ProductEntity product;

  const MallListItemWidget({Key? key, required this.product}) : super(key: key);

  @override
  _MallListItemWidgetState createState() => _MallListItemWidgetState();
}

class _MallListItemWidgetState extends State<MallListItemWidget> {
  @override
  Widget build(BuildContext context) {
    String imgUrl = widget.product.value.productImg;
    if (imgUrl.isEmpty) {
      imgUrl = widget.product.value.headImg;
    }

    String tag = _getTagNameByTagId(widget.product.value.appTagId);

    return Container(
        padding: const EdgeInsets.fromLTRB(5, 10, 5, 10),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            ClipRRect(
              borderRadius: BorderRadius.circular(5),
              child: CachedNetworkImage(
                height: 86,
                width: 86,
                imageUrl: imgUrl,
              ),
            ),
            const SizedBox(width: 8),
            Expanded(
                child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                TextWidget(
                  widget.product.value.name,
                  fontSize: 14,
                  maxLines: 2,
                  fontWeight: FontWeight.bold,
                ),
                TextWidget(
                  widget.product.value.description,
                  paddingTop: 3,
                  fontSize: 12,
                  textColor: MulanColors.gray,
                  maxLines: 2,
                ),
                const SizedBox(height: 5),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Visibility(
                        visible: tag.isNotEmpty == true,
                        child: Container(
                          height: 19,
                          padding: const EdgeInsets.fromLTRB(2, 0, 2, 0),
                          decoration: BoxDecoration(border: Border.all(color: MulanColors.orange, width: 0.5), borderRadius: const BorderRadius.all(Radius.circular(2.0))),
                          child: Text(tag, style: MulanTextStyle.body3.textColor(MulanColors.orange)),
                        )),
                    TextWidget(
                      "查询价格 >",
                      fontSize: 14,
                      fontWeight: FontWeight.bold,
                      textColor: MulanColors.blue,
                    )
                  ],
                )
              ],
            )),
          ],
        ));
  }

  // TODO： Just for test, will replace with "tags" value.
  _getTagNameByTagId(String tagId) {
    String tag = "";
    if (tagId.isEmpty) tag = "";
    switch (tagId) {
      case 'coupon-applicable':
        tag = "可用券";
        break;
      case 'new-1':
        tag = "上新";
        break;
      case 'recommend':
        tag = "推荐";
        break;
      default:
        return "";
    }
    return tag;
  }
}
