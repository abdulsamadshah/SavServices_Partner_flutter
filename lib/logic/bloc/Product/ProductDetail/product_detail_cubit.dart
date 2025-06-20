import 'dart:developer';
import 'dart:io';

import 'package:bloc/bloc.dart';
import 'package:dio/dio.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:image_picker/image_picker.dart';
import 'package:partner/Routers/app_route_constants.dart';
import 'package:partner/core/constant/Utils.dart';
import 'package:partner/core/constant/loading.dart';
import 'package:partner/data/models/CateogoryListRes.dart';
import 'package:partner/data/models/Product/ProductDetailRes.dart';
import 'package:partner/data/repositories/product.repo.dart';
import 'package:http_parser/http_parser.dart';

part 'product_detail_state.dart';

class ProductDetailCubit extends Cubit<ProductDetailState> {
  ProductDetailCubit() : super(ProductDetailInitial());
  int selectedIndex = 0;
  final ImagePicker picker = ImagePicker();

  final productName = TextEditingController();
  final productDesc = TextEditingController();
  final productPrice = TextEditingController();
  final pickUpTime = TextEditingController();
  final productQty = TextEditingController();
  final brandName = TextEditingController();

  final List<String> pickupTimes = [
    "08:00 AM - 09:00 AM",
    "09:00 AM - 10:00 AM",
    "10:00 AM - 11:00 AM",
    "11:00 AM - 12:00 PM",
    "12:00 PM - 01:00 PM",
    "01:00 PM - 02:00 PM",
  ];

  detailInit(BuildContext context, {ProductDetail? detail}) {
    getCategories(context);
    productName.text = detail?.productName ?? "";
    productDesc.text = detail?.productDesc ?? "";
    productPrice.text = "${detail?.productPrice ?? ""}";
    pickUpTime.text = detail?.pickUpTime ?? "";
    productQty.text = "${detail?.productQty ?? ""}";
    brandName.text = detail?.brandName ?? "";
    selectPickUpTime("08:00 AM - 09:00 AM");
    // selectPickUpTime(detail.pickUpTime);
    setUploadedImages(detail!.productImage!);
    dynamic selected = {
      "id": detail.categoryId,
      "name": detail.categoryName,
    };
    log("--------SelectedCateogryDetail------$selected",);
    selectCategoryName(selected);
    selectProductImage(detail.productImage);

  }

  Future<void> getProductDetail({required int id}) async {
    try {
      emit(LoadingState());

      var result = await ProductRepo.getProductDetail(productId: id);
      if (result.status == true) {
        emit(ProductDetailLoadingSuccess(detail: result.productDetail));
      } else {
        emit(LoadingError(result.message.toString()));
      }
    } catch (e) {
      emit(LoadingError(e.toString()));
    }
  }

  Future<void> getCategories(BuildContext context) async {
    try {
      Loading().showloading(context);

      var result = await ProductRepo.getCategoryList();
      if (result.status == true) {
        emit(state.copyWith(categoryList: result.categorys!));
        Loading().dismissloading(context);
      } else {
        Loading().dismissloading(context);
        Utils.fluttertoast(result.message.toString());
      }
    } catch (e) {
      Loading().dismissloading(context);
      Utils.fluttertoast(e.toString());
    }
  }



  Future<void> addProduct(BuildContext context) async {
    try {
      Loading().showloading(context);

      List<MultipartFile> imageFiles = [];
      for (File image in state.selectedImages) {
        final fileName = image.path.split('/').last;
        imageFiles.add(await MultipartFile.fromFile(
          image.path,
          filename: fileName,
          contentType: MediaType('image', 'jpeg'),
        ));
      }

      FormData data = FormData.fromMap({
        'ProductName': productName.text,
        'CategoryId': state.selectedCategoryName['id'].toString(),
        'ProductDesc': productDesc.text,
        'Product_Price': productPrice.text,
        'PickUp_Time': state.selectedTime,
        'Product_Qty': productQty.text,
        'verified': 'true',
        'Brand_Name': brandName.text,
        "Product_Image": imageFiles,
        // 'Mbps': '[50, 100, 200]',
        // 'Month': '[3,6,12]',
        // 'Price': '[2000,4000,12000]',
      });

      var result = await ProductRepo.createProduct(data);
      if (result.status == true) {
        Loading().dismissloading(context);
         // Utils.fluttertoast(result.message.toString());
        Navigator.pop(context);
         // context.goNamed(MyAppRouteConstants.dashBoardScreen);
         // GoRouter.of(context).goNamed(MyAppRouteConstants.dashBoardScreen);
      } else {
        Loading().dismissloading(context);
        Utils.fluttertoast(result.message.toString());
      }
    } catch (e) {
      Loading().dismissloading(context);
      Utils.fluttertoast(e.toString());
    }
  }

  Future<void> updateProduct(BuildContext context,{required int productId}) async {
    try {
      Loading().showloading(context);

      List<MultipartFile> imageFiles = [];
      for (File image in state.selectedImages) {
        final fileName = image.path.split('/').last;
        imageFiles.add(await MultipartFile.fromFile(
          image.path,
          filename: fileName,
          contentType: MediaType('image', 'jpeg'),
        ));
      }

      FormData data = FormData.fromMap({
        'ProductName': productName.text,
        'CategoryId': state.selectedCategoryName['id'].toString(),
        'ProductDesc': productDesc.text,
        'Product_Price': productPrice.text,
        'PickUp_Time': state.selectedTime,
        'Product_Qty': productQty.text,
        'verified': 'true',
        'Brand_Name': brandName.text,
        // 'Mbps': '[50, 100, 200]',
        // 'Month': '[3,6,12]',
        // 'Price': '[2000,4000,12000]',
        if (imageFiles.isNotEmpty) "Product_Image": imageFiles,


      });



      var result = await ProductRepo.updateProduct(data,productId:productId );
      if (result.status == true) {
        Loading().dismissloading(context);
        Utils.fluttertoast(result.message.toString());
        Navigator.pop(context);
        // context.goNamed(MyAppRouteConstants.dashBoardScreen);
        // GoRouter.of(context).goNamed(MyAppRouteConstants.dashBoardScreen);
      } else {
        Loading().dismissloading(context);
        Utils.fluttertoast(result.message.toString());
      }
    } catch (e) {
      Loading().dismissloading(context);
      Utils.fluttertoast(e.toString());
    }
  }

  selectCategoryName(dynamic value) {
    emit(state.copyWith(selectedCategoryName: value));
  }

  selectProductImage(dynamic value) {
    emit(state.copyWith(selectedImages: value));
  }

  selectPickUpTime(dynamic value) {
    emit(state.copyWith(selectedTime: value));
  }



  void pickImages() async {
    final pickedFiles = await picker.pickMultiImage();
    if (pickedFiles.isNotEmpty) {
      final newFiles = pickedFiles.map((x) => File(x.path)).toList();
      emit(state.copyWith(
        selectedImages: [...state.selectedImages, ...newFiles],
      ));
    }
  }

  void removeLocalImage(int index) {
    final updated = List<File>.from(state.selectedImages)..removeAt(index);
    emit(state.copyWith(selectedImages: updated));
  }

  void removeUploadedImage(int index) {
    final updated = List<String>.from(state.uploadedImageUrls)..removeAt(index);
    emit(state.copyWith(uploadedImageUrls: updated));
  }

  void setUploadedImages(List<String> urls) {
    emit(state.copyWith(uploadedImageUrls: urls));
  }
}
