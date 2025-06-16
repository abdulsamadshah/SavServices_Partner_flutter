import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:partner/core/Utils/color_res.dart';
import 'package:partner/core/Utils/const_res.dart';
import 'package:partner/core/constant/appTheme.dart';
import 'package:partner/core/constant/html_utils.dart';
import 'package:partner/core/constant/utility.dart';
import 'package:partner/data/http/Constant.dart';
import 'package:partner/data/models/Product/ProductRes.dart';
import 'package:partner/gen/fonts.gen.dart';
import 'dart:io';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:dropdown_search/dropdown_search.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_widget_from_html/flutter_widget_from_html.dart';
import 'package:get/get.dart';
import 'package:partner/presentation/common_widget/common_widget.dart';
import 'package:skeletonizer/skeletonizer.dart';
import 'package:html/parser.dart' show parse;

Widget commonTabBar(
  BuildContext context, {
  required TabController tabController,
  required void Function(int) ontap,
  required List<Widget> tabs,
  bool isScrollable = false,
}) {
  return Container(
    padding: EdgeInsets.only(bottom: 7.h,top: 7.h),
    color:  ColorRes.appColor,
    child: TabBar(
      controller: tabController,
      padding: EdgeInsets.zero,
      tabAlignment: isScrollable == true ? TabAlignment.start : null,
      isScrollable: isScrollable,
      dividerColor: Colors.transparent,
      indicatorColor: Colors.white,
      indicator: BoxDecoration(
          color:  Colors.transparent),
      labelColor:  ColorRes.appColor,
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
    backgroundColor: ColorRes.appColor,
    onPressed: ontap,
    child: Icon(Icons.add, size: 30.sp, color: Colors.white),
  );
}






String htmlToPlainText(String htmlString) {
  final document = parse(htmlString);
  return parse(document.body?.text ?? "").documentElement?.text ?? "";
}

Widget Product_Ui(BuildContext context, ProductData product_item,
    { String? prouductStatus}) {
  return Padding(
    padding: EdgeInsets.symmetric(vertical: 6.h),
    child: InkWell(
      onTap: () {
        // Get.toNamed(Routes.Product_Detail, arguments: {
        //   "productid": product_item.productId.toString(),
        //   "type": product_item.verified,
        // })?.then((SelectedTab) {
        //   if (SelectedTab != null) {
        //     if (SelectedTab == "Updated") {
        //       controller?.Tab_selectedIndex.value = 1;
        //     } else {
        //       controller?.Tab_selectedIndex.value = SelectedTab;
        //       controller?.GetPending_Product_Data();
        //     }
        //   }
        // });
      },
      child: Container(
        padding: EdgeInsets.symmetric(horizontal: 10.w, vertical: 10.h),
        decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(10.r),
            color:  ColorRes.white,
            border: Border.all(color: const Color(0xffDEDEDE), width: 2.w)),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SizedBox(
                width: 80.w,
                height: 80.h,
                child: ClipRRect(
                  borderRadius: BorderRadius.all(Radius.circular(8.r)),
                  child: CachedNetworkImage(
                    imageUrl: Utility.isNotNullEmptyOrFalse(
                        product_item.productImage)
                        ? "${ConstRes.aImageBaseUrl}${product_item.productImage}"
                        : MyAppTheme.notFoundImg,
                    fit: BoxFit.fill,
                    placeholder: (context, string) => const Center(
                      child: CircularProgressIndicator(),
                    ),
                  ),
                )),
            Padding(
              padding: EdgeInsets.only(left: 10.w, top: 5.h),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          reausabletext(
                            '${product_item.productName}',
                            widths: 180,
                            maxline: 2,
                            align: TextAlign.start,
                            fontfamily: FontFamily.interMedium,
                            fontsize: 13,
                            fontweight: FontWeight.w500,
                          ),
                          SizedBox(
                            width: 182.w,
                            child: Text(
                              htmlToPlainText(sanitizeHtml(product_item.productDesc ?? '')),
                              maxLines: 2,
                              overflow: TextOverflow.ellipsis,
                              style: TextStyle(
                                fontSize: 13.sp,
                              ),
                            ),
                          ),
                          // SizedBox(
                          //   width: 182.w,
                          //   child: HtmlWidget(
                          //     sanitizeHtml(product_item.productShortDesc ?? "",)
                          //   ),
                          // ),
                        ],
                      ),

                      SizedBox(
                        width: 50.w,
                        child: product_item.productStatus == true
                            ? CupertinoSwitch(
                          value: product_item.productStatus==false
                              ? false
                              : product_item.productStatus==true
                              ? true
                              : false,
                          activeColor: ColorRes.appColor,
                          onChanged: (value) {
                            // controller?.Product_Status(context,
                            //     type: prouductStatus,
                            //     productid: int.parse(
                            //         product_item.productId.toString()));
                          },
                        )
                            : Container(),
                      ),
                    ],
                  ),
                  SizedBox(
                    height: 7.h,
                  ),
                  SizedBox(
                    width: 240.w,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        ReausableItems(
                            title: "₹Price",
                            value: product_item.productPrice),
                        ReausableItems(
                            title: "Category",
                            value: product_item.categoryId),
                        ReausableItems(
                            title: "Brand", value: "${product_item.brandName}"),
                      ],
                    ),
                  )
                ],
              ),
            )
          ],
        ),
      ),
    ),
  );
}

// Widget OutOfStock_Ui(BuildContext context, OutOf_StockData product_item,
//     {Product_Controller? controller, String? type}) {
//   return Padding(
//     padding: EdgeInsets.symmetric(vertical: 6.h),
//     child: InkWell(
//       onTap: () {
//         DialogBox.StockUpdateDialog(context,
//             productId: product_item.productId, controller: controller);
//       },
//       child: Container(
//         padding: EdgeInsets.symmetric(horizontal: 10.w, vertical: 10.h),
//         decoration: BoxDecoration(
//             borderRadius: BorderRadius.circular(10.r),
//             color: context.isDarkMode
//                 ? ToggleThemeData.darkThemeBackground
//                 : Colors.white,
//             border: Border.all(color: const Color(0xffDEDEDE), width: 2.w)),
//         child: Row(
//           crossAxisAlignment: CrossAxisAlignment.start,
//           children: [
//             SizedBox(
//                 width: 80.w,
//                 height: 80.h,
//                 child: ClipRRect(
//                   borderRadius: BorderRadius.all(Radius.circular(8.r)),
//                   child: CachedNetworkImage(
//                     imageUrl: type == "CoachMark"
//                         ? MyAppTheme.notFoundImg
//                         : "${Constant.ImagebaseUrl}${product_item.productImage}",
//                     fit: BoxFit.fill,
//                     placeholder: (context, string) => const Center(
//                       child: CircularProgressIndicator(),
//                     ),
//                   ),
//                 )),
//             Padding(
//               padding: EdgeInsets.only(left: 10.w, top: 5.h),
//               child: Column(
//                 crossAxisAlignment: CrossAxisAlignment.start,
//                 mainAxisAlignment: MainAxisAlignment.start,
//                 children: [
//                   Row(
//                     crossAxisAlignment: CrossAxisAlignment.start,
//                     children: [
//                       Column(
//                         crossAxisAlignment: CrossAxisAlignment.start,
//                         children: [
//                           reausabletext(
//                             '${product_item.productName}',
//                             widths: 185,
//                             maxline: 2,
//                             align: TextAlign.start,
//                             fontfamily: FontFamily.interMedium,
//                             fontsize: 13,
//                             fontweight: FontWeight.w500,
//                           ),
//                         ],
//                       ),
//                     ],
//                   ),
//                   SizedBox(
//                     height: 7.h,
//                   ),
//                   SizedBox(
//                     width: 240.w,
//                     child: Row(
//                       mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                       crossAxisAlignment: CrossAxisAlignment.start,
//                       children: [
//                         ReausableItems(
//                             title: "${product_item.quantity}", value: AppText.qty.tr),
//                         ReausableItems(
//                             title: "${product_item.productCategory}",
//                             value: AppText.category.tr),
//                         ReausableItems(
//                             title: "${product_item.brand}", value: AppText.brand.tr),
//                       ],
//                     ),
//                   )
//                 ],
//               ),
//             )
//           ],
//         ),
//       ),
//     ),
//   );
// }

Widget ReausableItems({required String title, value}) {
  return Column(
    crossAxisAlignment: CrossAxisAlignment.start,
    mainAxisAlignment: MainAxisAlignment.spaceBetween,
    children: [
      reausabletext(
        title,
        align: TextAlign.start,
        fontfamily: FontFamily.interBold,
        fontsize: 14,
        widths: 70,
        textoverflow: TextOverflow.ellipsis,
        maxline: 1,
        fontweight: FontWeight.w500,
      ),
      reausabletext(
        '$value',
        align: TextAlign.start,
        fontfamily: FontFamily.interMedium,
        fontsize: 11,
        fontweight: FontWeight.w600,
      ),
    ],
  );
}

Widget DetailReausableItems({required String title, value}) {
  return Column(
    crossAxisAlignment: CrossAxisAlignment.start,
    children: [
      reausabletext(
        '$value',
        align: TextAlign.center,
        fontfamily: FontFamily.interBold,
        fontsize: 14,
        fontweight: FontWeight.w500,
      ),
      reausabletext(
        title,
        align: TextAlign.start,
        fontfamily: FontFamily.interMedium,
        fontsize: 11,
        fontweight: FontWeight.w600,
      ),
    ],
  );
}
