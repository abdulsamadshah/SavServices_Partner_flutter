
import 'package:dio/dio.dart';
import 'package:partner/core/Utils/urls.dart';
import 'package:partner/data/http/http_util.dart';
import 'package:partner/data/models/CommonPostRes.dart';

import '../models/PersonalDetail_Res.dart';

class AuthRepo {
  static Future<CommonPostRes> login({dynamic param}) async {
    var response = await HttpUtil().post(Urls.login, data: param);
    return CommonPostRes.fromJson(response);
  }




  static logOut({FormData? param}) async {
    var response = await HttpUtil().authPost("/logout");
    return CommonPostRes.fromJson(response);
  }

  static ResendOtp({dynamic param}) async {
    var response = await HttpUtil().post("/resend-otp", data: param);
    return CommonPostRes.fromJson(response);
  }
}
