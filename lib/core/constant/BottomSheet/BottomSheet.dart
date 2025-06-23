import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:partner/core/constant/BottomSheet/UploadFile.dart';
import 'package:partner/core/constant/utility.dart';
import 'package:partner/logic/bloc/Category/category_cubit.dart';
import 'package:partner/logic/bloc/Product/product_cubit.dart';

import '../../../presentation/common_widget/Input_field.dart';
import '../../../presentation/common_widget/common_widget.dart';
import '../Utils.dart';
import 'dart:io';

class BottomSheets {
  void showCreateCategoryBottomSheet({
    required BuildContext context,
  }) {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(20.r)),
      ),
      backgroundColor: Colors.white,
      builder: (context) {
        return BlocBuilder<CategoryCubit, CategoryState>(
          builder: (context, state) => Padding(
            padding: EdgeInsets.only(
              bottom: MediaQuery.of(context).viewInsets.bottom,
              top: 20.h,
              left: 20.w,
              right: 20.w,
            ),
            child: SingleChildScrollView(
              child: Form(
                key: context.read<CategoryCubit>().categoryKey,
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Container(
                      width: 50.w,
                      height: 5.h,
                      decoration: BoxDecoration(
                        color: Colors.grey[300],
                        borderRadius: BorderRadius.circular(10.r),
                      ),
                    ),
                    SizedBox(height: 15.h),
                    reausabletext(
                      "Create Category",
                      fontsize: 20,
                      fontweight: FontWeight.bold,
                    ),
                    SizedBox(height: 20.h),
                    InputField(
                      title: "Category Name",
                      maxLength: 50,
                      hintText: "Enter Category Name",
                      controller: context.read<CategoryCubit>().categoryName,
                      validator: (value) => value == null || value.isEmpty
                          ? "Category Name can't be empty"
                          : null,
                    ),
                    SizedBox(height: 12.h),
                    Center(
                      child: GestureDetector(
                        onTap: () {
                          ModalImage bottomNavbar = ModalImage(
                            isImageCroppable: true,
                            onImageSelect: (path) async {
                              if (Utility.isNotNullEmptyOrFalse(path)) {
                                context.read<CategoryCubit>().addCategoryImage(path);
                                // controller.selectedImage.value = path;
                                Navigator.pop(context);
                              }
                            },
                          );
                          bottomNavbar.mainBottomSheet(context);
                        },
                        child: state.categoryImage == ""
                            ? Container(
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.all(Radius.circular(10.r)),),

                          child: reausabletext("Upload Image"),

                        ) : CircleAvatar(
                          radius: 60.r,
                          backgroundImage: Image.file(
                            File(state.categoryImage),
                            fit: BoxFit.cover,
                          ).image,
                          backgroundColor: Colors.black,
                        ),
                      ),
                    ),

                    SizedBox(height: 25.h),
                    reausablebuttons(
                      title: "Create Category",
                      ontap: () async {
                        if (context.read<CategoryCubit>().categoryKey.currentState!
                            .validate()) {
                          if(state.categoryImage.isEmpty){
                            Utils.fluttertoast("Category image can't be empty");
                            return;
                          }
                          context.read<CategoryCubit>().createGroup(context);
                        }
                      },
                      borderradiues: 50.r,
                    ),
                    SizedBox(height: 15.h),
                  ],
                ),
              ),
            ),
          ),
        );
      },
    );
  }
}
