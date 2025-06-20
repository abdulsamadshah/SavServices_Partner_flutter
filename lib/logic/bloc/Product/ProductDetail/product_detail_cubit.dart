import 'dart:io';

import 'package:bloc/bloc.dart';
import 'package:flutter/cupertino.dart';
import 'package:image_picker/image_picker.dart';
import 'package:meta/meta.dart';
import 'package:partner/core/constant/Utils.dart';
import 'package:partner/core/constant/loading.dart';
import 'package:partner/data/models/CateogoryListRes.dart';
import 'package:partner/data/models/Product/ProductDetailRes.dart';
import 'package:partner/data/repositories/product.repo.dart';

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

  detailInit(BuildContext context, ProductDetail detail) {
    getCategories(context);
    productName.text = detail.productName.toString();
    productDesc.text = detail.productDesc.toString();
    productPrice.text = detail.productPrice.toString();
    pickUpTime.text = detail.pickUpTime.toString();
    productQty.text = detail.productQty.toString();
    brandName.text = detail.brandName.toString();
    selectPickUpTime("08:00 AM - 09:00 AM");
    // selectPickUpTime(detail.pickUpTime);
    setUploadedImages(detail.productImage!);
    selectProductImage(detail.productImage);
    selectCategoryName(detail.categoryName);
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

  selectCategoryName(dynamic value) {
    emit(state.copyWith(selectedCategoryName: value));
  }

  selectProductImage(dynamic value) {
    emit(state.copyWith(selectedImages: value));
  }

  selectPickUpTime(dynamic value) {
    emit(state.copyWith(selectedTime: value));
  }

  // Future<void> pickImages() async {
  //   final List<XFile>? pickedFiles = await picker.pickMultiImage();
  //
  //   if (pickedFiles != null && pickedFiles.isNotEmpty) {
  //
  //     List<File> selectedImages = [];
  //     selectedImages.addAll(pickedFiles.map((e) => File(e.path)));
  //     emit(state.copyWith(selectedImages: selectedImages));
  //
  //
  //   }
  // }
  //
  // void removeImage(int index) {
  //   final updatedImages = List<File>.from(state.selectedImages)..removeAt(index);
  //   emit(state.copyWith(selectedImages: updatedImages));
  // }
  //
  //
  // void removeLocalImage(int index) {
  //   final updated = List<File>.from(state.selectedImages)..removeAt(index);
  //   emit(state.copyWith(selectedImages: updated));
  // }
  //
  // void removeUploadedImage(int index) {
  //   final updated = List<String>.from(state.uploadedImageUrls)..removeAt(index);
  //   emit(state.copyWith(uploadedImageUrls: updated));
  // }

  void pickImages() async {
    final pickedFiles = await picker.pickMultiImage();
    if (pickedFiles != null && pickedFiles.isNotEmpty) {
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
