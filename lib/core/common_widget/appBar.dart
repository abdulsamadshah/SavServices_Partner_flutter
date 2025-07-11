
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:partner/core/Utils/color_res.dart';
import 'package:partner/gen/fonts.gen.dart';
import 'package:partner/presentation/common_widget/common_widget.dart';



PreferredSize mainAppBar(BuildContext context,
    {String? title, bool centerTitle = true,String? type,bool isLeading=true,List<Widget>? actions,bool? popValue}) {
  return PreferredSize(
    preferredSize: const Size.fromHeight(kToolbarHeight),
    child: Container(
      decoration: BoxDecoration(
        gradient: const LinearGradient(
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
          colors: [
            ColorRes.appColor,
            ColorRes.appColor,
          ],
        ),
        borderRadius: BorderRadius.vertical(
          bottom: Radius.circular( type=="custom"?15.r:0.r),
        ),
      ),
      child: AppBar(
        leading: isLeading==false?SizedBox():Padding(
          padding: EdgeInsets.only(left: 15.w),
          child: InkWell(
            onTap: () {
              Navigator.pop(context,popValue);
            },
            child: type=="custom"?CircleAvatar(
              radius: 15.r,
              backgroundColor: Colors.white,
              child: reausableIcon(
                icon: Icons.arrow_back_ios_outlined,
                color: Colors.black,
              ),
            ):reausableIcon(
              icon: Icons.arrow_back_ios_outlined,
              color: Colors.white,
            )
          ),
        ),
        centerTitle: centerTitle,
        elevation: 0,
        backgroundColor: Colors.transparent,
        title: reausabletext(
          title ?? "",
          color: Colors.white,
          fontfamily: FontFamily.interSemiBold,
        ),
        actions: actions,
      ),
    ),
  );
}


