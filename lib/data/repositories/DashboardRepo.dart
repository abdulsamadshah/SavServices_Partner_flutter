import 'package:partner/data/http/http_util.dart';
import 'package:partner/data/models/DashboardData.dart';

class DashBoardRepo{
  static Future<DashboardData> getDashboardData({required var param}) async {
    var response = await HttpUtil().post("/Zecapis/misdata",data: param);
    return DashboardData.fromJson(response);
  }
}