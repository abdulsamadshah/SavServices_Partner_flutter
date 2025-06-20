part of 'product_detail_cubit.dart';

@immutable
class ProductDetailState {
  ProductDetail? detail;
  final String? error;
  List<Categorys> categoryList = [];
  dynamic selectedCategoryName;
  List<File> selectedImages = [];
  List<dynamic> uploadedImageUrls = [];
  String? selectedTime;

  ProductDetailState(
      {this.error,
      this.detail,
      this.categoryList = const [],
      this.selectedCategoryName,
      this.selectedImages = const [],
      this.uploadedImageUrls = const [],
      this.selectedTime});

  ProductDetailState copyWith({
    String? error,
    ProductDetail? detail,
    List<Categorys>? categoryList,
    dynamic selectedCategoryName,
    List<File>? selectedImages,
    List<dynamic>? uploadedImageUrls,
    String? selectedTime,
  }) {
    return ProductDetailState(
        error: error ?? this.error,
        detail: detail ?? this.detail,
        categoryList: categoryList ?? this.categoryList,
        selectedCategoryName: selectedCategoryName ?? this.selectedCategoryName,
        selectedImages: selectedImages ?? this.selectedImages,
        uploadedImageUrls: uploadedImageUrls ?? this.uploadedImageUrls,
        selectedTime: selectedTime ?? this.selectedTime);
  }
}

final class ProductDetailInitial extends ProductDetailState {}

class LoadingState extends ProductDetailState {}

class LoadingError extends ProductDetailState {
  LoadingError(String error) : super(error: error);
}

class ProductDetailLoadingSuccess extends ProductDetailState {
  ProductDetailLoadingSuccess({super.detail});
}
