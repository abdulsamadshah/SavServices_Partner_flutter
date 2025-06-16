
import 'package:partner/data/http/http_util.dart';
import 'package:partner/data/models/Product/ProductRes.dart';

class ProductRepo{
  static Future<ProductRes> getProductData(String endPoint)async{
    var result = await HttpUtil().get("/admin/$endPoint");
    return ProductRes.fromJson(result);
  }
}