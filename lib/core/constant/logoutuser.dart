
import 'package:flutter/material.dart';
import 'package:partner/core/Utils/pref_res.dart';



import 'global.dart';

class LogoutUser {
  void logout(BuildContext context) {
    Global.storageServices.remove(PrefConst.deviceToken);
    Global.storageServices.remove(PrefConst.DEVICE_ID);

    Navigator.of(context)
        .pushNamedAndRemoveUntil('/SIGN_IN', (Route<dynamic> route) => false);
  }
}
