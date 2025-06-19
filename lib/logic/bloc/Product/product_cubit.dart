import 'package:bloc/bloc.dart';
import 'package:flutter/cupertino.dart';
import 'package:meta/meta.dart';
import 'package:partner/core/constant/Dialog/Common_dialog.dart';
import 'package:partner/core/constant/loading.dart';
import 'package:partner/data/models/Product/ProductRes.dart';
import 'package:partner/data/models/Product/ProductDetailRes.dart';
import 'package:partner/data/repositories/product.repo.dart';

part 'product_state.dart';

class ProductCubit extends Cubit<ProductState> {
  ProductCubit() : super(ProductDataInitial());

  Future<void> getProduct({required type}) async {
    try {
      emit(LoadingState());
      var endPoint;
      if (type == "live") {
        endPoint = "Active_Product";
      } else if (type == "pending") {
        endPoint = "Pending_Product";
      } else {
        endPoint = "OutofStock";
      }

      var result = await ProductRepo.getProductData(endPoint);
      if (result.status == true) {
        emit(ProductDataLoadingSuccess(productData: result.productData));
      } else {
        emit(LoadingError(result.message.toString()));
      }
    } catch (e) {
      emit(LoadingError(e.toString()));
    }
  }

  Future<void> productStatus(BuildContext context,
      {required int productid}) async {
    try {
      Loading().showloading(context);

      var result = await ProductRepo.Product_Status(productId: productid);
      if (result.status == true) {
        Loading().dismissloading(context);
        getProduct(type: "live");
      } else {
        Loading().dismissloading(context);
        CommonDialog.errorMessage(result.message.toString());
      }
    } catch (e) {
      Loading().dismissloading(context);
      CommonDialog.errorMessage(e.toString());
    }
  }


}
