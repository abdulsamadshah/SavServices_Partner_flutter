import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:partner/core/Utils/color_res.dart';
import 'package:partner/logic/bloc/Dashboard/dashboard_cubit.dart';
import 'package:partner/presentation/common_widget/common_widget.dart';
import 'package:partner/presentation/screen/Product/LiveScreen.dart';
import 'package:partner/presentation/screen/Product/PendingScreen.dart';
import 'package:partner/presentation/screen/Product/StockScreen.dart';

import 'UpdateProductScreen.dart';
import 'Widget/product_widget.dart';

class ProductMain extends StatefulWidget {
  int index;
  ProductMain({super.key, this.index = 0});

  @override
  State<ProductMain> createState() => _ProductscreenState();
}

class _ProductscreenState extends State<ProductMain>
    with SingleTickerProviderStateMixin {
  final dashboardCubit = DashboardCubit();
  late TabController tabController;
  @override
  void initState() {
    super.initState();

    dashboardCubit.productTabIndex(int.parse(widget.index.toString()));

    tabController = TabController(
      length: 3,
      vsync: this,
      initialIndex: dashboardCubit.state.productTabIndex,
    );
    tabController.addListener(() {
      dashboardCubit.productTabIndex(tabController.index);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButton: AddProductBtnWidget(ontap: () {
        Navigator.push(context, MaterialPageRoute(builder: (context) => Updateproductscreen(),));
      }),
      body: Column(
        children: [
          commonTabBar(
            context,
            tabController: tabController,
            isScrollable: false,
            ontap: (value) {
              dashboardCubit.productTabIndex(value);
            },
            tabs: [
              productTab(
                  title: "Live",
                  selectedtabs: 0,
                  dashboardCubit: dashboardCubit,
              total_item: 0,
              ),
              productTab(
                  title: "Pending",
                  selectedtabs: 1,
                  dashboardCubit: dashboardCubit,
                total_item: 0,
              ),
              productTab(
                  title: "Stock",
                  selectedtabs: 2,
                  total_item: 0,
                  dashboardCubit: dashboardCubit),
            ],
          ),
          Expanded(
            child: TabBarView(
              physics: const NeverScrollableScrollPhysics(),
              controller: tabController,
              children:  [
                Livescreen(),
                 Pendingscreen(),
                Stockscreen()

              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget productTab(
      {String? title,
      int? selectedtabs,
      int borderradiues = 25,
      int height = 32,
        required int total_item,

      required DashboardCubit dashboardCubit}) {
    return BlocBuilder<DashboardCubit, DashboardState>(
        bloc: dashboardCubit,
        builder: (context, state) => Container(

          decoration: state.productTabIndex==selectedtabs
              ? BoxDecoration(
            borderRadius: BorderRadius.circular(borderradiues.sp),
            color:  Colors.white,
          )
              : const BoxDecoration(),

              child: Tab(
                height: height.h,
                child: Center(
                  child: reausabletext(
                    "$title ${total_item == 0 ? "" :  state.productTabIndex==selectedtabs ? "($total_item)" : ""}",
                    fontsize: 16,
                    color:  state.productTabIndex==selectedtabs
                        ?  ColorRes.appColor
                        : ColorRes.white

                  ),
                ),
              ),
            ));
  }
}
