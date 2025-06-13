import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:partner/core/Utils/color_res.dart';
import 'package:partner/core/Utils/const_res.dart';
import 'package:partner/gen/fonts.gen.dart';

Widget commonTabBar(
  BuildContext context, {
  required TabController tabController,
  required void Function(int) ontap,
  required List<Widget> tabs,
  bool isScrollable = false,
}) {
  return Container(
    padding: EdgeInsets.only(bottom: 7.h,top: 7.h),
    color:  ColorRes.primaryYellow,
    child: TabBar(
      controller: tabController,
      padding: EdgeInsets.zero,
      tabAlignment: isScrollable == true ? TabAlignment.start : null,
      isScrollable: isScrollable,
      dividerColor: Colors.transparent,
      indicatorColor: Colors.white,
      indicator: BoxDecoration(
          color:  Colors.transparent),
      labelColor:  ColorRes.primaryYellow,
      labelStyle: TextStyle(fontFamily: FontFamily.interMedium),
      unselectedLabelColor: Colors.white,
      unselectedLabelStyle:
      const TextStyle(fontFamily: FontFamily.interRegular),
      labelPadding:
      EdgeInsets.only(left: 10.w, top: 5.h, right: 10.w, bottom: 5.h),
      indicatorPadding:
      REdgeInsets.only(left: 25.w, right: 20.w, top: 10.h, bottom: 0),
      onTap: ontap,
      tabs: tabs,
    ),
  );
}



Widget AddProductBtnWidget({void Function()? ontap}) {
  return FloatingActionButton(
    backgroundColor: ColorRes.primaryYellow,
    onPressed: ontap,
    child: Icon(Icons.add, size: 30.sp, color: Colors.white),
  );
}
