import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:partner/core/common_widget/appBar.dart';
import 'package:partner/logic/bloc/Product/ProductDetail/product_detail_cubit.dart';

class ProductVariantScreen extends StatefulWidget {
  final ProductDetailCubit controller;

  const ProductVariantScreen({Key? key, required this.controller})
      : super(key: key);

  @override
  State<ProductVariantScreen> createState() => _ProductVariantScreenState();
}

class _ProductVariantScreenState extends State<ProductVariantScreen> {
  bool get isValid =>
      widget.controller.state.mbpsList.length ==
          widget.controller.state.monthList.length &&
      widget.controller.state.mbpsList.length ==
          widget.controller.state.priceList.length;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    // widget.controller.addMbps( widget.controller.state.mbpsList.toString());
    // widget.controller.addMonth( widget.controller.state.mbpsList.toString());
    // widget.controller.addPrice( widget.controller.state.priceList.toString());
  }

  void showConfirmationDialog() {
    Get.defaultDialog(
      title: "Submit Variants",
      middleText: "Are you sure you want to submit these variants?",
      textConfirm: "Yes",
      textCancel: "No",
      confirmTextColor: Colors.white,
      onConfirm: () {
        Get.back(); // close dialog
        Navigator.pop(context);
        Get.snackbar("Success", "Variants submitted successfully!",
            backgroundColor: Colors.green, colorText: Colors.white);
      },
      buttonColor: Colors.green,
      radius: 10.r,
    );
  }

  Widget buildInputCard({
    required String label,
    required IconData icon,
    required TextEditingController controller,
    required VoidCallback onAdd,
  }) {
    return Card(
      margin: EdgeInsets.only(bottom: 14.h),
      elevation: 2,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12.r)),
      child: Padding(
        padding: EdgeInsets.symmetric(vertical: 12.h, horizontal: 14.w),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(label,
                style: TextStyle(fontSize: 15.sp, fontWeight: FontWeight.w600)),
            SizedBox(height: 10.h),
            Row(
              children: [
                Expanded(
                  child: TextFormField(
                    controller: controller,
                    keyboardType: TextInputType.number,
                    decoration: InputDecoration(
                      prefixIcon: Icon(icon),
                      hintText: "Enter $label",
                      border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(10.r)),
                      contentPadding: EdgeInsets.symmetric(horizontal: 12.w),
                    ),
                  ),
                ),
                SizedBox(width: 10.w),
                ElevatedButton(
                  onPressed: () {
                    if (controller.text.isNotEmpty) onAdd();
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.blueAccent,
                    padding:
                        EdgeInsets.symmetric(horizontal: 18.w, vertical: 16.h),
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10.r)),
                  ),
                  child: Text("Add", style: TextStyle(fontSize: 13.sp)),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Widget buildChipList(
      String title, List<String> items, void Function(int) onRemove) {
    if (items.isEmpty) return SizedBox.shrink();
    return Padding(
      padding: EdgeInsets.only(bottom: 10.h),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text("$title List",
              style: TextStyle(fontWeight: FontWeight.w500, fontSize: 13.sp)),
          SizedBox(height: 6.h),
          Wrap(
            spacing: 6.w,
            runSpacing: 6.h,
            children: items.asMap().entries.map((entry) {
              return Chip(
                label: Text(entry.value),
                backgroundColor: Colors.grey.shade200,
                deleteIcon: Icon(Icons.close, size: 16.sp),
                onDeleted: () => onRemove(entry.key),
              );
            }).toList(),
          ),
        ],
      ),
    );
  }

  Widget buildPreview(ProductDetailState state) {
    if (state.mbpsList.isEmpty) return SizedBox.shrink();

    return Card(
      margin: EdgeInsets.only(top: 20.h),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12.r)),
      child: Padding(
        padding: EdgeInsets.all(14.w),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text("Preview Variants",
                style: TextStyle(fontSize: 15.sp, fontWeight: FontWeight.bold)),
            SizedBox(height: 10.h),
            if (!isValid)
              Padding(
                padding: EdgeInsets.only(bottom: 10.h),
                child: Text("⚠️ Lists are not balanced!",
                    style: TextStyle(color: Colors.red, fontSize: 12.sp)),
              ),
            ListView.separated(
              physics: NeverScrollableScrollPhysics(),
              shrinkWrap: true,
              itemCount: state.mbpsList.length,
              separatorBuilder: (_, __) => Divider(),
              itemBuilder: (_, i) {
                if (i >= state.monthList.length ||
                    i >= state.priceList.length) {
                  return SizedBox.shrink();
                }
                return ListTile(
                  contentPadding: EdgeInsets.zero,
                  title: Text(
                      "${state.mbpsList[i]} Mbps - ${state.monthList[i]} Month"),
                  subtitle: Text("₹${state.priceList[i]}",
                      style: TextStyle(fontWeight: FontWeight.w500)),
                );
              },
            )
          ],
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ProductDetailCubit, ProductDetailState>(
      bloc: widget.controller,
      builder: (context, state) => ScreenUtilInit(
        designSize: const Size(375, 812),
        builder: (_, __) => Scaffold(
          appBar: mainAppBar(context, title: "Variant"),
          body: SingleChildScrollView(
            padding: EdgeInsets.all(16.w),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                buildInputCard(
                  label: "Mbps",
                  icon: Icons.speed,
                  controller: widget.controller.mbpsController,
                  onAdd: () {
                    widget.controller
                        .addMbps(widget.controller.mbpsController.text);
                    widget.controller.mbpsController.clear();
                  },
                ),
                buildChipList(
                    "Mbps", state.mbpsList, widget.controller.removeMbps),
                buildInputCard(
                  label: "Month",
                  icon: Icons.calendar_month,
                  controller: widget.controller.monthController,
                  onAdd: () {
                    widget.controller
                        .addMonth(widget.controller.monthController.text);
                    widget.controller.monthController.clear();
                  },
                ),
                buildChipList(
                    "Month", state.monthList, widget.controller.removeMonth),
                buildInputCard(
                  label: "Price",
                  icon: Icons.currency_rupee,
                  controller: widget.controller.priceController,
                  onAdd: () {
                    widget.controller
                        .addPrice(widget.controller.priceController.text);
                    widget.controller.priceController.clear();
                  },
                ),
                buildChipList(
                    "Price", state.priceList, widget.controller.removePrice),
                buildPreview(state),
                SizedBox(height: 30.h),
                Row(
                  children: [
                    Expanded(
                      child: OutlinedButton(
                        onPressed: () {
                          widget.controller.mbpsController.clear();
                          widget.controller.monthController.clear();
                          widget.controller.priceController.clear();
                          widget.controller.clearAll();
                        },
                        style: OutlinedButton.styleFrom(
                          padding: EdgeInsets.symmetric(vertical: 16.h),
                          shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(12.r)),
                          side: BorderSide(color: Colors.redAccent),
                        ),
                        child: Text("Reset",
                            style: TextStyle(color: Colors.redAccent)),
                      ),
                    ),
                    SizedBox(width: 12.w),
                    Expanded(
                      child: ElevatedButton.icon(
                        onPressed: () {
                          if (!isValid) {
                            Get.snackbar("Validation Error",
                                "All parameter lists must be balanced.",
                                backgroundColor: Colors.redAccent,
                                colorText: Colors.white);
                            return;
                          }
                          Navigator.pop(context);
                        },
                        icon: Icon(Icons.check_circle_outline),
                        label:
                            Text("Submit", style: TextStyle(fontSize: 15.sp)),
                        style: ElevatedButton.styleFrom(
                          backgroundColor: Colors.green.shade600,
                          padding: EdgeInsets.symmetric(vertical: 16.h),
                          shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(12.r)),
                        ),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
