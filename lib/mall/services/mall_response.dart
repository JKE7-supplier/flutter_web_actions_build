class MallResponse {
  int statusCode = -1;
  bool isSuccess = false;
  String message = '';
  MallBean? bean;

  static MallResponse fromMap(Map<String, dynamic> map) {
    if (map == null) {
      return MallResponse();
    }
    MallResponse response = MallResponse()
      ..statusCode = map['statusCode']
      ..message = map['message']
      ..isSuccess = map['isSuccess']
      ..bean = (map['body'] == null ? null : MallBean.fromMap(Map<String, dynamic>.from(map['body'])));
    return response;
  }

  Map toJson() => {
        "statusCode": statusCode,
        "isSuccess": isSuccess,
        "message": message,
        "body": bean,
      };
}

class MallBean {
  late String title;
  late PageInfo pageInfo;
  late List<CategoriesEntity> categories;
  late List<ProductEntity> products;

  static MallBean fromMap(Map<String, dynamic> map) {
    if (map == null) {
      return MallBean();
    }

    MallBean mallBean = MallBean()
      ..title = map['title'] ?? ""
      ..pageInfo = PageInfo.fromMap(Map<String, dynamic>.from(map['pageInfo']))
      ..categories = (map['categories'] as List).map((e) => CategoriesEntity.fromMap(e)).toList()
      ..products = (map['products'] as List).map((e) => ProductEntity.fromMap(e)).toList();
    return mallBean;
  }

  Map toJson() => {"title": title};
}

class PageInfo {
  String appRevampTitle = "";

  static PageInfo fromMap(Map<String, dynamic> map) {
    if (map == null) {
      return PageInfo();
    }
    PageInfo pageInfo = PageInfo()..appRevampTitle = map['appRevampTitle'];
    return pageInfo;
  }
}

class CategoriesEntity {
  late CategoryValueEntity value;
  bool enable = false; // True - Display in the tab

  static CategoriesEntity fromMap(Map<String, dynamic> map) {
    if (map == null) {
      return CategoriesEntity();
    }
    CategoriesEntity categoriesEntity = CategoriesEntity()..value = CategoryValueEntity.fromMap(Map<String, dynamic>.from(map['value']));
    return categoriesEntity;
  }
}

class CategoryValueEntity {
  String name = "";
  String id = "";

  static CategoryValueEntity fromMap(Map<String, dynamic> map) {
    if (map == null) {
      return CategoryValueEntity();
    }

    CategoryValueEntity entity = CategoryValueEntity()
      ..name = map['name']
      ..id = map['id'];
    return entity;
  }
}

class ProductEntity {
  late ProductValueEntity value;

  static ProductEntity fromMap(Map<String, dynamic> map) {
    if (map == null) {
      return ProductEntity();
    }
    ProductEntity productEntity = ProductEntity()..value = ProductValueEntity.fromMap(Map<String, dynamic>.from(map['value']));
    return productEntity;
  }
}

class ProductValueEntity {
  String btnText = "";
  String productImg = "";
  String headImg = "";
  bool appEnabled = false;
  bool stageOnly = false;
  String description = "";
  String priceStatus = "";
  String productDesc = "";
  int appRevampDisplayorder = 0;
  String appTagId = "";
  String minPrice = "";
  String id = "";
  String name = "";
  String categoryId = "";
  bool autoMation = false;

  static ProductValueEntity fromMap(Map<String, dynamic> map) {
    if (map == null) {
      return ProductValueEntity();
    }

    ProductValueEntity entity = ProductValueEntity()
      ..btnText = map['btnText'] ?? ""
      ..productImg = map['productImg'] ?? ""
      ..headImg = map['headImg'] ?? ""
      ..appEnabled = map['appEnabled'] ?? false
      ..stageOnly = map['stageOnly'] ?? false
      ..description = map['description'] ?? ""
      ..priceStatus = map['priceStatus'] ?? ""
      ..productDesc = map['productDesc'] ?? ""
      ..appRevampDisplayorder = map['appRevampDisplayorder'] ?? 0
      ..appTagId = map['appTagId'] ?? ""
      ..minPrice = map['minPrice'] ?? ""
      ..id = map['id'] ?? ""
      ..name = map['name'] ?? ""
      ..categoryId = map['categoryId'] ?? ""
      ..autoMation = map['autoMation'] ?? false;
    return entity;
  }
}
