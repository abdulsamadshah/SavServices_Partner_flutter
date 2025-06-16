import 'dart:developer';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:partner/core/Utils/color_res.dart';



import 'package:partner/presentation/common_widget/common_widget.dart';

import '../../../gen/fonts.gen.dart';

class DialogBox {
  static Future<void> confirmationDialog(BuildContext context,
      {String? title,
      String? desc,
      String lefButtonName = "NO",
      String rightButtonName = "YES",
      void Function()? leftButtonOntap,
      rightButtonOntap}) {
    return showCupertinoDialog(
      context: context,
      builder: (BuildContext context) {
        return CupertinoAlertDialog(
          title: Padding(
            padding: EdgeInsets.symmetric(horizontal: 15.w),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                SizedBox(
                  height: 15.h,
                ),
                reausabletext(
                  title!.tr,
                  fontfamily: FontFamily.interSemiBold,
                  fontsize: 17,
                  align: TextAlign.center,
                ),
                desc == null
                    ? const SizedBox()
                    : reausabletext(
                        desc.tr,
                        fontfamily: FontFamily.interMedium,
                        fontsize: 13,
                      ),
              ],
            ),
          ),
          actions: <Widget>[
            CupertinoDialogAction(
              onPressed: leftButtonOntap,
              child: reausabletext(
                lefButtonName.tr,
                color: context.isDarkMode
                    ? ColorRes.white
                    : ColorRes.black,
                fontsize: 16,
              ),
            ),
            CupertinoDialogAction(
              onPressed: rightButtonOntap,
              child: reausabletext(rightButtonName.tr,
                  color: ColorRes.appColor, fontsize: 16),
            ),
          ],
        );
      },
    );
  }


}
