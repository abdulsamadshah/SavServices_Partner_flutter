
import 'package:dio/dio.dart';
import 'package:partner/core/Utils/urls.dart';
import 'package:partner/data/http/http_util.dart';
import 'package:partner/data/models/CateogoryListRes.dart';
import 'package:partner/data/models/CommonPostRes.dart';
import 'package:partner/data/models/Product/ProductDetailRes.dart';
import 'package:partner/data/models/Product/ProductRes.dart';

class ProductRepo{
  static Future<ProductRes> getProductData(String endPoint)async{
    var result = await HttpUtil().get("/admin/$endPoint");
    return ProductRes.fromJson(result);
  }

  static Future<CommonPostRes> Product_Status({required int productId}) async {
    var response =
    await HttpUtil().get("${Urls.productStatus}$productId",);
    return CommonPostRes.fromJson(response);
  }

  static Future<ProductDetailRes> getProductDetail({required int productId}) async {
    var response =
    await HttpUtil().get("${Urls.productDetail}$productId",);
    return ProductDetailRes.fromJson(response);
  }


  static Future<CateogoryListRes> getCategoryList() async {
    var response = await HttpUtil().get(Urls.getCategory,);
    return CateogoryListRes.fromJson(response);
  }

  static Future<CommonPostRes> createProduct(FormData data) async {
    var response = await HttpUtil().post(Urls.createProduct,type: "formdata",formdata: data);
    return CommonPostRes.fromJson(response);
  }

  static Future<CommonPostRes> updateProduct(FormData data,{required int productId}) async {
    var response = await HttpUtil().patch("${Urls.updateProduct}/$productId",type: "formdata",formdata: data);
    return CommonPostRes.fromJson(response);
  }


  static Future<CommonPostRes> createGroup(FormData data) async {
    var response = await HttpUtil().post(Urls.createCategory,type: "formdata",formdata: data,);
    return CommonPostRes.fromJson(response);
  }
}