import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';
import 'package:partner/data/models/Product/ProductDetailRes.dart';
import 'package:partner/data/repositories/product.repo.dart';

part 'product_detail_state.dart';

class ProductDetailCubit extends Cubit<ProductDetailState> {
  ProductDetailCubit() : super(ProductDetailInitial());
  int selectedIndex=0;

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


}
