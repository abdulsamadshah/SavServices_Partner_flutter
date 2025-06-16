part of 'product_cubit.dart';

@immutable
class ProductState {
  final List<ProductData>? productData;
  ProductDetail? detail;
  final String? error;

  ProductState({
    this.productData,
    this.error,
    this.detail,
  });

  ProductState copyWith({
    List<ProductData>? productData,
    String? error,
    ProductDetail? detail,
  }) {
    return ProductState(
      productData: productData ?? this.productData,
      error: error ?? this.error,
      detail: detail ?? this.detail,
    );
  }
}

final class ProductDataInitial extends ProductState {}

class LoadingState extends ProductState {}

class ProductDataLoadingSuccess extends ProductState {
  ProductDataLoadingSuccess({super.productData});
}

class LoadingError extends ProductState {
  LoadingError(String error) : super(error: error);
}

class ProductDetailLoadingSuccess extends ProductState {
  ProductDetailLoadingSuccess({super.detail});
}
