

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:partner/core/Utils/color_res.dart';

class Loading {


  showloading(context) {
    return showDialog(
        barrierDismissible: false,
        context: context,
        builder: (ctx) => WillPopScope(
            onWillPop: () async {
              return false;
            },
            child: Center(
              child: SizedBox(
                  height: 70.h,
                  width: 70.w,
                  child: const CircularProgressIndicator(
                    backgroundColor: Color(0xffD0D0D0),
                    color: ColorRes.primaryYellow,
                    strokeWidth: 10,
                  )),
            )
            // Lottie.asset("assets/svg/loader.json"),
            ));
  }

  dismissloading(
    context,
  ) {
    Navigator.pop(context);
  }
}
