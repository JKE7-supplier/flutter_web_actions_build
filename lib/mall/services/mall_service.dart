import 'package:dio/dio.dart';
import 'package:flutter_web_actions_build/mall/services/mall_response.dart';
import 'package:flutter_web_actions_build/network/base_service.dart';

class MallService extends BaseService {
  Future<MallResponse> fetchACPConfiguration() async {
    try {
      // Response res = await getJson("/shdr-acp-java/api/v1/f3c36826f4a3e93e/content?language=zh", null);
      Response res = await getJson("/api/mall/poc", null);
      List list = res.data;
      MallResponse _response = MallResponse();
      if (list.isEmpty) {
        _response.isSuccess = false;
        return Future.value(_response);
      }
      _response.isSuccess = true;
      _response.statusCode = 0;
      for (var item in list) {
        Map<String, dynamic> properties = item['properties'];
        if (properties['title'] == "Home Page Configuration") {
          MallBean bean = MallBean.fromMap(properties);
          _response.bean = bean;
        }
      }
      return Future.value(_response);
    } catch (err) {
      rethrow;
    }
  }
}
// class MallService extends FlutterMethodChannel {
//   static const String _fetchACPConfiguration = "fetchACPConfiguration";
//
//   MallService() : super(CommonConstants.MALL_NETWORK_CHANNEL);
//
//   Future<MallResponse> fetchACPConfiguration() {
//     PageInfo _pageInfo = PageInfo()..appRevampTitle = "票务及年卡预订";
//
//     List<CategoriesEntity> _categories = [];
//     CategoryValueEntity _categoryValueEntity1 = CategoryValueEntity()
//       ..id = "ThemePark"
//       ..name = "门票";
//     CategoryValueEntity _categoryValueEntity2 = CategoryValueEntity()
//       ..id = "AnnualPass"
//       ..name = "年卡";
//     CategoryValueEntity _categoryValueEntity3 = CategoryValueEntity()
//       ..id = "Services"
//       ..name = "服务";
//     CategoryValueEntity _categoryValueEntity4 = CategoryValueEntity()
//       ..id = "Hotels"
//       ..name = "酒店";
//     CategoryValueEntity _categoryValueEntity5 = CategoryValueEntity()
//       ..id = "Activity"
//       ..name = "活动";
//     CategoryValueEntity _categoryValueEntity6 = CategoryValueEntity()
//       ..id = "Dining"
//       ..name = "餐饮";
//
//     CategoriesEntity _categoriesEntity1 = CategoriesEntity()..value = _categoryValueEntity1;
//     CategoriesEntity _categoriesEntity2 = CategoriesEntity()..value = _categoryValueEntity2;
//     CategoriesEntity _categoriesEntity3 = CategoriesEntity()..value = _categoryValueEntity3;
//     CategoriesEntity _categoriesEntity4 = CategoriesEntity()..value = _categoryValueEntity4;
//     CategoriesEntity _categoriesEntity5 = CategoriesEntity()..value = _categoryValueEntity5;
//     CategoriesEntity _categoriesEntity6 = CategoriesEntity()..value = _categoryValueEntity6;
//
//     List<ProductEntity> _products = [];
//     ProductValueEntity _productValueEntity1 = ProductValueEntity()
//       ..name = "迪士尼童话婚礼"
//       ..id = "eventWeddings"
//       ..categoryId = "Activity"
//       ..appEnabled = true
//       ..btnText = "查询价格"
//       ..productImg = "https://static.shanghaidisneyresort.com/f3c36826f4a3e93e/media/611f845d883ae75b/2209wedding.png";
//     ProductValueEntity _productValueEntity2 = ProductValueEntity()
//       ..name = "一日票"
//       ..id = "shdr-theme-park-women-day-ticket"
//       ..categoryId = "ThemePark"
//       ..appEnabled = true
//       ..btnText = "查询价格"
//       ..productImg = "https://static.shanghaidisneyresort.com/f3c36826f4a3e93e/media/aaac344e0e63df13/2403Womenicon.JPG";
//     ProductValueEntity _productValueEntity3 = ProductValueEntity()
//       ..name = "上海迪士尼乐园年卡"
//       ..id = "shdr-pearl-annualpass"
//       ..categoryId = "AnnualPass"
//       ..appEnabled = true
//       ..btnText = "¥ 365 起"
//       ..productImg = "https://static.shanghaidisneyresort.com/f3c36826f4a3e93e/media/473a21b5e0b7646b/2309AP_Icon.jpg";
//     ProductValueEntity _productValueEntity4 = ProductValueEntity()
//       ..name = "迪士尼礼宾服务"
//       ..id = "shdr-theme-park-concierge-services"
//       ..categoryId = "Services"
//       ..appEnabled = true
//       ..btnText = "查询价格"
//       ..productImg = "https://static.shanghaidisneyresort.com/f3c36826f4a3e93e/media/80af55551ef6e250/迪士尼礼宾服务.jpg";
//     ProductValueEntity _productValueEntity5 = ProductValueEntity()
//       ..name = "上海迪士尼乐园酒店"
//       ..id = "shdr-theme-park-hotels"
//       ..categoryId = "Hotels"
//       ..appEnabled = true
//       ..btnText = "查询价格"
//       ..productImg = "https://static.shanghaidisneyresort.com/f3c36826f4a3e93e/media/65096f0fabf48be9/h1.png";
//     ProductValueEntity _productValueEntity6 = ProductValueEntity()
//       ..name = "节日庆典主题桶兑换券"
//       ..id = "holiday-themed-bucket"
//       ..categoryId = "Dining"
//       ..appEnabled = true
//       ..btnText = "查询价格"
//       ..productImg = "https://static.shanghaidisneyresort.com/f3c36826f4a3e93e/media/287f00db27a04a12/1115-hoilday-bucket-icon.jpg";
//     ProductValueEntity _productValueEntity7 = ProductValueEntity()
//       ..name = "迪士尼童话婚礼"
//       ..id = "eventWeddings"
//       ..categoryId = "Activity"
//       ..appEnabled = true
//       ..btnText = "查询价格"
//       ..productImg = "https://static.shanghaidisneyresort.com/f3c36826f4a3e93e/media/611f845d883ae75b/2209wedding.png";
//     ProductValueEntity _productValueEntity8 = ProductValueEntity()
//       ..name = "一日票"
//       ..id = "shdr-theme-park-women-day-ticket"
//       ..categoryId = "ThemePark"
//       ..appEnabled = true
//       ..btnText = "查询价格"
//       ..productImg = "https://static.shanghaidisneyresort.com/f3c36826f4a3e93e/media/aaac344e0e63df13/2403Womenicon.JPG";
//     ProductValueEntity _productValueEntity9 = ProductValueEntity()
//       ..name = "迪士尼童话婚礼"
//       ..id = "eventWeddings"
//       ..categoryId = "Activity"
//       ..appEnabled = true
//       ..btnText = "查询价格"
//       ..productImg = "https://static.shanghaidisneyresort.com/f3c36826f4a3e93e/media/611f845d883ae75b/2209wedding.png";
//     ProductValueEntity _productValueEntity10 = ProductValueEntity()
//       ..name = "上海迪士尼乐园年卡"
//       ..id = "shdr-pearl-annualpass"
//       ..categoryId = "AnnualPass"
//       ..appEnabled = true
//       ..btnText = "¥ 365 起"
//       ..productImg = "https://static.shanghaidisneyresort.com/f3c36826f4a3e93e/media/473a21b5e0b7646b/2309AP_Icon.jpg";
//
//     ProductEntity _productEntity1 = ProductEntity()..value = _productValueEntity1;
//     ProductEntity _productEntity2 = ProductEntity()..value = _productValueEntity2;
//     ProductEntity _productEntity3 = ProductEntity()..value = _productValueEntity3;
//     ProductEntity _productEntity4 = ProductEntity()..value = _productValueEntity4;
//     ProductEntity _productEntity5 = ProductEntity()..value = _productValueEntity5;
//     ProductEntity _productEntity6 = ProductEntity()..value = _productValueEntity6;
//     ProductEntity _productEntity7 = ProductEntity()..value = _productValueEntity7;
//     ProductEntity _productEntity8 = ProductEntity()..value = _productValueEntity8;
//     ProductEntity _productEntity9 = ProductEntity()..value = _productValueEntity9;
//     ProductEntity _productEntity10 = ProductEntity()..value = _productValueEntity10;
//
//     _categories.add(_categoriesEntity1);
//     _categories.add(_categoriesEntity2);
//     _categories.add(_categoriesEntity3);
//     _categories.add(_categoriesEntity4);
//     _categories.add(_categoriesEntity5);
//     _categories.add(_categoriesEntity6);
//
//     _products.add(_productEntity1);
//     _products.add(_productEntity2);
//     _products.add(_productEntity3);
//     _products.add(_productEntity4);
//     _products.add(_productEntity5);
//     _products.add(_productEntity6);
//     _products.add(_productEntity7);
//     _products.add(_productEntity8);
//     _products.add(_productEntity9);
//     _products.add(_productEntity10);
//
//     MallBean _bean = MallBean()
//       ..pageInfo = _pageInfo
//       ..categories = _categories
//       ..products = _products;
//     MallResponse _response = MallResponse()
//       ..isSuccess = true
//       ..statusCode = 0
//       ..bean = _bean;
//     // return Future.value(_response);
//     return callNative(_fetchACPConfiguration, null).then((value) => MallResponse.fromMap(jsonDecode(value)));
//   }
// }
