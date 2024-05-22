/// 执行动作后返回的结构
class ResponseResult<T> {
  /// 结果代码
  int code = 200;

  /// 返回消息
  String msg = "";

  /// 返回数据
  dynamic data;

  ResponseResult({required this.code, this.msg = "", this.data});

  ResponseResult.fromJson(Map<String, dynamic> json) {
    code = json['code'] ?? 200;
    msg = json['msg'];
    data = json['data'];
  }

  @override
  String toString() {
    return "statusCode" + code.toString() + "msg" + msg + "data" + data.toString();
  }
}
