import 'package:cached_network_image/cached_network_image.dart';
import 'package:card_swiper/card_swiper.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:liquid_pull_to_refresh/liquid_pull_to_refresh.dart';
import 'package:partner/core/Utils/const_res.dart';
import 'package:partner/core/constant/LiquidPullToRefresh_Indicatore.dart';
import 'package:partner/core/constant/appTheme.dart';
import 'package:partner/data/models/Product/ProductDetailRes.dart';
import 'package:partner/gen/fonts.gen.dart';
import 'package:partner/logic/bloc/Product/ProductDetail/product_detail_cubit.dart';
import 'package:partner/presentation/common_widget/common_widget.dart';
import 'package:skeletonizer/skeletonizer.dart';

import 'UpdateProductScreen.dart';
import 'Widget/product_widget.dart';

class ProductDetailScreen extends StatefulWidget {
  final int productId;
  final String? type;

  const ProductDetailScreen({super.key, required this.productId, this.type});

  @override
  State<ProductDetailScreen> createState() => _ProductDetailScreenState();
}

class _ProductDetailScreenState extends State<ProductDetailScreen> {
  final productCubit = ProductDetailCubit();
  late SwiperController _pageController;
  @override
  void initState() {
    super.initState();
    productCubit.getProductDetail(id: widget.productId);
    _pageController = SwiperController();
  }

  @override
  void dispose() {
    _pageController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: BlocConsumer<ProductDetailCubit, ProductDetailState>(
        bloc: productCubit,
        listener: (context, state) {},
        listenWhen: (previous, current) => current is LoadingState,
        buildWhen: (previous, current) => current is! LoadingState,
        builder: (context, state) {
          switch (state.runtimeType) {
            case LoadingState:
              return ProductDetailUi(isLoading: true);
            case LoadingError:
              final errorState = state as LoadingError;
              return LostinternetConnection(
                retry: () => productCubit.getProductDetail(id: widget.productId),
                messgae: errorState.error.toString(),
              );
            case ProductDetailLoadingSuccess:
              final loadedState = state as ProductDetailLoadingSuccess;
              return ProductDetailUi(detail: loadedState.detail!, isLoading: false);
            default:
              return ProductDetailUi(isLoading: true);
          }
        },
      ),
    );
  }

  Widget ProductDetailUi({ProductDetail? detail, bool isLoading = false}) {
    return MyCustomPullToRefresh(
      Indicatorekey: GlobalKey<LiquidPullToRefreshState>(),
      onTap2Callback: () {
        productCubit.getProductDetail(id: widget.productId);
      },
      child: Skeletonizer(
        enabled: isLoading,
        child: SingleChildScrollView(
          physics: const ClampingScrollPhysics(),
          child: Stack(
            children: [

              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [

                  Container(
                    height: 300.h,
                    width: double.maxFinite,
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(0.r),
                        color: const Color(0xffDCDCDC)),
                    child: Swiper(
                      controller: _pageController,
                      viewportFraction: 1,
                      loop: false,
                      duration: kDefaultAutoplayDelayMs,
                      itemBuilder: (BuildContext context, int index) {
                        return ClipRRect(
                          borderRadius: BorderRadius.circular(0.r),
                          child: CachedNetworkImage(
                            imageUrl:
                            "${ConstRes.aImageBaseUrl}${detail!.productImage?[index]}",
                            imageBuilder: (context, imageProvider) =>
                                Container(
                                  decoration: BoxDecoration(
                                    image: DecorationImage(
                                      image: imageProvider,
                                      fit: BoxFit.cover,
                                    ),
                                  ),
                                ),
                            errorWidget: (context, url, error) =>
                                Image.network(MyAppTheme.notFoundImg),
                          ),
                        );
                      },
                      itemCount: detail?.productImage?.length ?? 0,

                      pagination: SwiperPagination(
                        alignment: Alignment.bottomCenter,
                        margin: EdgeInsets.only(bottom: 20.h),
                        builder: const DotSwiperPaginationBuilder(
                            color: Colors.grey,
                            activeColor: Colors.black,
                            size: 10),
                      ),
                      index: productCubit.selectedIndex,

                      onIndexChanged: (index) {

                        setState(() {
                          productCubit.selectedIndex = index;
                          _pageController.move(index);
                        });
                      },
                    ),

                  ),


                  Padding(
                    padding: EdgeInsets.symmetric(horizontal: 15.w, vertical: 10.h),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        reausabletext(
                          widths: 320,
                          "₹ ${detail?.productPrice ?? ''}",
                          fontsize: 21,
                          fontfamily: FontFamily.interBold,
                        ),
                        reausabletext(
                          widths: double.maxFinite,
                          detail?.productName ?? '',
                          fontsize: 16,
                          fontfamily: FontFamily.interMedium,
                          fontweight: FontWeight.w500,
                        ),
                        SizedBox(height: 10.h),

                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            DetailReausableItems(
                              title: detail?.categoryName ?? '',
                              value: "Category".tr,
                            ),
                            DetailReausableItems(
                              title: detail?.brandName ?? '',
                              value: "Brand".tr,
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),

                  Divider(height: 2.h, color: const Color(0xffF1F1F1), thickness: 5),

                  Padding(
                    padding: EdgeInsets.symmetric(horizontal: 15.w, vertical: 10.h),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        reausabletext(
                          "Description".tr,
                          fontweight: FontWeight.w600,
                          fontsize: 16,
                          fontfamily: FontFamily.interBold,
                        ),
                        SizedBox(height: 5.w),
                        // HtmlWidget(detail?.productDesc ?? ''),
                        reausabletext(
                          detail?.productDesc ?? '',
                          fontweight: FontWeight.w400,
                          fontsize: 14,
                        ),
                      ],
                    ),
                  ),

                  Divider(height: 2.h, color: const Color(0xffF1F1F1), thickness: 5),

                  Padding(
                    padding: EdgeInsets.symmetric(horizontal: 10.w, vertical: 10.h),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        reausabletext(
                          "Variants".tr,
                          fontweight: FontWeight.w600,
                          fontsize: 18,
                          fontfamily: FontFamily.interBold,
                        ),

                        SizedBox(height: 15.h,),
                        Padding(
                          padding: const EdgeInsets.only(left: 8.0),
                          child: reausabletext(
                            "MBPS".tr,
                            fontweight: FontWeight.w600,
                            fontsize: 13,
                            fontfamily: FontFamily.interBold,
                          ),
                        ),
                        SizedBox(
                          height: 60.h,
                          child: ListView.separated(
                            // physics: const NeverScrollableScrollPhysics(),
                            padding: EdgeInsets.zero,
                            shrinkWrap: true,
                            scrollDirection: Axis.horizontal,

                            itemCount: detail?.mbps?.length ?? 0,

                            itemBuilder: (context, index) {
                              return Padding(
                                padding: EdgeInsets.all(7.w),
                                child: VariantsData(
                                  width: 70,
                                  data: detail?.mbps?[index].toString() ?? "",
                                  context: context,
                                ),
                              );
                            },
                            separatorBuilder: (context, index) {
                              return SizedBox(
                                width: 10.h,
                              );
                            },
                          ),
                        ),


                        SizedBox(height: 15.h,),
                        Padding(
                          padding: const EdgeInsets.only(left: 8.0),
                          child: reausabletext(
                            "Month".tr,
                            fontweight: FontWeight.w600,
                            fontsize: 13,
                            fontfamily: FontFamily.interBold,
                          ),
                        ),
                        SizedBox(
                          height: 60.h,
                          child: ListView.separated(
                            // physics: const NeverScrollableScrollPhysics(),
                            padding: EdgeInsets.zero,
                            shrinkWrap: true,
                            scrollDirection: Axis.horizontal,

                            itemCount: detail?.month?.length ?? 0,

                            itemBuilder: (context, index) {
                              return Padding(
                                padding: EdgeInsets.all(7.w),
                                child: VariantsData(
                                  width: 70,
                                  data: detail?.month?[index].toString() ?? "",
                                  context: context,
                                ),
                              );
                            },
                            separatorBuilder: (context, index) {
                              return SizedBox(
                                width: 10.h,
                              );
                            },
                          ),
                        ),



                        SizedBox(height: 15.h,),
                        Padding(
                          padding: const EdgeInsets.only(left: 8.0),
                          child: reausabletext(
                            "Price".tr,
                            fontweight: FontWeight.w600,
                            fontsize: 13,
                            fontfamily: FontFamily.interBold,
                          ),
                        ),
                        SizedBox(
                          height: 60.h,
                          child: ListView.separated(
                            // physics: const NeverScrollableScrollPhysics(),
                            padding: EdgeInsets.zero,
                            shrinkWrap: true,
                            scrollDirection: Axis.horizontal,

                            itemCount: detail?.price?.length ?? 0,

                            itemBuilder: (context, index) {
                              return Padding(
                                padding: EdgeInsets.all(7.w),
                                child: VariantsData(
                                  width: 70,
                                  data: detail?.price?[index].toString() ?? "",
                                  context: context,
                                ),
                              );
                            },
                            separatorBuilder: (context, index) {
                              return SizedBox(
                                width: 10.h,
                              );
                            },
                          ),
                        ),
                      ],
                    ),
                  ),

                  if (widget.type != "pending")
                    Padding(
                      padding: EdgeInsets.symmetric(horizontal: 10.w, vertical: 10.h),
                      child: reausablebuttons(
                        title: "Edit Product".tr,
                        ontap: () {
                        Navigator.push(context, MaterialPageRoute(builder: (context) => Updateproductscreen(detail: detail!,),));
                        },
                      ),
                    ),
                ],
              ),
              Padding(
                padding:  EdgeInsets.only(top:35.h,left: 10.w),
                child: BackpressIcon(context),
              ),
            ],
          ),
        ),
      ),
    );
  }


}
