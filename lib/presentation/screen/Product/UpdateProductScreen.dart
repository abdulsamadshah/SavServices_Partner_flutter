import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:partner/core/common_widget/appBar.dart';
import 'package:partner/core/constant/validator.dart';
import 'package:partner/data/models/Product/ProductDetailRes.dart';
import 'package:partner/logic/bloc/Product/ProductDetail/product_detail_cubit.dart';
import 'package:partner/presentation/common_widget/Input_field.dart';
import 'package:partner/presentation/common_widget/common_widget.dart';

import '../../../core/constant/DropDown.dart';
import 'Widget/PickUpTime.dart';
import 'Widget/UploadImage.dart';

class Updateproductscreen extends StatefulWidget {
  ProductDetail detail;
  Updateproductscreen({super.key, required this.detail});

  @override
  State<Updateproductscreen> createState() => _UpdateproductscreenState();
}

class _UpdateproductscreenState extends State<Updateproductscreen> {
  final controller = ProductDetailCubit();

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      controller.detailInit(context, widget.detail);
    });
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ProductDetailCubit, ProductDetailState>(
      bloc: controller,
      builder: (context, state) => Scaffold(
        appBar: mainAppBar(
          context,
          title: "Edit Product",
        ),
        body: Padding(
            padding: EdgeInsets.symmetric(horizontal: 15.0),
            child: ListView(
                // shrinkWrap: true,
                physics: ScrollPhysics(),
                scrollDirection: Axis.vertical,
                children: [
                  Container(
                    padding: EdgeInsets.symmetric(vertical: 15.h),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(7.r),
                      // color: Colors.white,
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Padding(
                          padding: EdgeInsets.all(8.r),
                          child: reausabletext("Select Category",
                              fontweight: FontWeight.bold, fontsize: 14),
                        ),
                        SizedBox(height: 2.h),
                        DropDownItems(
                          title: widget.detail.categoryName == null
                              ? "Category"
                              : widget.detail.categoryName.toString(),
                          dropdownItems: state.categoryList,
                          validator: (value) {
                            if (value == null || value == "Category*") {
                              return "Category Name can't be empty";
                            } else {
                              return null;
                            }
                          },
                          prefixIcon: reausableIcon(
                            icon: Icons.dashboard,
                          ),
                          onChanged: (value) {
                            if (value != null) {
                              final selectedItem =
                                  state.categoryList?.firstWhere(
                                (item) => item.name == value,
                              );
                              dynamic selected = {
                                "id": selectedItem!.id,
                                "name": selectedItem.name,
                              };
                              controller.selectCategoryName(selected);
                            }
                          },
                        ),
                      ],
                    ),
                  ),
                  InputField(
                    title: "Enter Product Name",
                    hintText: 'Product Name',
                    controller: controller.productName,
                    validator:
                        Validator.validate(title: "Product Name is required"),
                  ),
                  InputField(
                    title: "Enter Brand Name",
                    hintText: 'Brand Name',
                    prefixIcon: Icon(Icons.branding_watermark_outlined),
                    controller: controller.brandName,
                    validator:
                        Validator.validate(title: "Brand Name is required"),
                  ),
                  InputField(
                    title: "Enter Product Description",
                    hintText: 'Enter Product Description',
                    maxLines: 4,
                    controller: controller.productDesc,
                    validator: Validator.validate(
                        title: "Product Description is required"),
                  ),
                  InputField(
                    title: "Enter Product Price",
                    hintText: 'Enter Product Price',
                    controller: controller.productPrice,
                    prefixIcon: reausableIcon(icon: Icons.price_change),
                    validator:
                        Validator.validate(title: "Product Price is required"),
                  ),
                  InputField(
                    title: "Enter Product Qty",
                    hintText: 'Enter Product Qty',
                    controller: controller.productQty,
                    validator:
                        Validator.validate(title: "Product Qty is required"),
                  ),
                  SizedBox(height: 15.h),
                  PickupTimeDropdown(
                      timeSlots: controller.pickupTimes,
                      selectedTime: state.selectedTime,
                      onChanged: (val) => controller.selectPickUpTime(val)),
                  SizedBox(height: 15.h),
                  buildUploadImageSection(
                    localImages: state.selectedImages,
                    uploadedImageUrls: state.uploadedImageUrls,
                    onUploadPressed: () => controller.pickImages(),
                    onRemove: (index, isLocal) {
                      if (isLocal) {
                        controller.removeLocalImage(index);
                      } else {
                        controller.removeUploadedImage(index);
                      }
                    },
                  )

                ])),
        bottomNavigationBar: Padding(
          padding:  EdgeInsets.symmetric(horizontal: 10.w,vertical: 10.h),
          child: reausablebuttons(title: "Update Product"),
        ),
      ),
    );
  }
}
