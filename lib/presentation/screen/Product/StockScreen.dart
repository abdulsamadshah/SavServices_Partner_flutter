
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:liquid_pull_to_refresh/liquid_pull_to_refresh.dart';
import 'package:partner/core/constant/LiquidPullToRefresh_Indicatore.dart';
import 'package:partner/data/models/Product/ProductRes.dart';
import 'package:partner/logic/bloc/Product/product_cubit.dart';
import 'package:partner/presentation/common_widget/common_widget.dart';
import 'package:skeletonizer/skeletonizer.dart';

import 'Widget/product_widget.dart';

class Stockscreen extends StatefulWidget {
  const Stockscreen({super.key});

  @override
  State<Stockscreen> createState() => _LivescreenState();
}

class _LivescreenState extends State<Stockscreen> {
  final productCubit = ProductCubit();

  @override
  void initState() {
    super.initState();
    productCubit.getProduct(type: "OutofStock");
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
          padding: EdgeInsets.all(8.0.r),
          child: BlocConsumer<ProductCubit, ProductState>(
            bloc: productCubit,
            listener: (context, state) {},
            builder: (context, state) {
              switch (state.runtimeType) {
                case LoadingState:
                  return OutOfStockProduct(isLoading: true);

                case LoadingError:
                  final networkconnectionlost = state as LoadingError;
                  return LostinternetConnection(
                      retry: () {
                        productCubit.getProduct(type: "OutofStock");
                      },
                      messgae: networkconnectionlost.error.toString());

                case ProductDataLoadingSuccess:
                  final list = state as ProductDataLoadingSuccess;
                  if (list.productData!.isEmpty) {
                    return Align(
                        alignment: Alignment.center,
                        child: reausabletext("No Data Found"));
                  } else {
                    return OutOfStockProduct(
                        productItem: list.productData, isLoading: false);
                  }

                default:
                  return const SizedBox();
              }
            },
          )),
    );
  }

  Widget OutOfStockProduct({List<ProductData>? productItem, bool isLoading = false}) {
    return MyCustomPullToRefresh(
      Indicatorekey: GlobalKey<LiquidPullToRefreshState>(),
      onTapCallback: () {
        // controller.LiveProduct_loading.value = true;
      },
      child: Padding(
        padding: EdgeInsets.only(left: 10.w, right: 10.h, top: 10.h),
        child: Skeletonizer(
          enabled: isLoading,
          child: ListView.builder(
            physics: const ClampingScrollPhysics(),
            padding: EdgeInsets.only(bottom: 80.h),
            shrinkWrap: true,
            itemCount: productItem?.length ?? 0,
            itemBuilder: (context, index) {
              ProductData? LiveProduct_data = productItem?[index];
              return Product_Ui(
                context,
                LiveProduct_data!,
              );
            },
          ),
        ),
      ),
    );
  }
}
