part of 'product_detail_cubit.dart';

// @immutable
// sealed class ProductDetailState {}
//
// final class ProductDetailInitial extends ProductDetailState {}
@immutable
class ProductDetailState {
  ProductDetail? detail;
  final String? error;

  ProductDetailState({
    this.error,
    this.detail,
  });

  ProductDetailState copyWith({
    String? error,
    ProductDetail? detail,
  }) {
    return ProductDetailState(
      error: error ?? this.error,
      detail: detail ?? this.detail,
    );
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
