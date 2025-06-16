import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';
import 'package:partner/data/models/Product/ProductRes.dart';
import 'package:partner/data/models/Product/ProductDetailRes.dart';
import 'package:partner/data/repositories/product.repo.dart';

part 'product_state.dart';

class ProductCubit extends Cubit<ProductState> {
  ProductCubit() : super(ProductDataInitial());




  Future<void> getProduct(
      {required type}) async {
    try {
      emit(LoadingState());
      var endPoint;
      if(type=="live"){
        endPoint="Active_Product";
      }else if(type=="pending"){
        endPoint="Pending_Product";
      }else{
        endPoint="OutofStock";
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




  // Future<void> getCandidateDetailData(
  //     {required String jdid,
  //       candidateid,
  //       required CandiDateCubit remarkList}) async {
  //   try {
  //     emit(LoadingState());
  //     var data = {
  //       'companyid':
  //       Global.storageServices.get(SecureSharedPreference.companyId),
  //       'userid': Global.storageServices.getProfileData().loingId.toString(),
  //       'access_rights':
  //       Global.storageServices.getProfileData().accessRights.toString(),
  //       'jdid': jdid,
  //       'candidateid': candidateid
  //     };
  //     var result = await CandiDate_Repo.getCandiDateDetail(param: data);
  //     if (result.status == true) {
  //       emit(CandiDateDetailLoadingSuccess(detail: result.data?[0]));
  //       remarkList.SelectedRemarks({
  //         'id': result.data?[0].remarkstid.toString(),
  //         'remarks': result.data?[0].remarkst.toString()
  //       });
  //       remarkList.comments.text = result.data![0].remarks!.toString();
  //     } else {
  //       emit(LoadingError(result.response.toString()));
  //     }
  //   } catch (e) {
  //     emit(LoadingError(e.toString()));
  //   }
  // }
}
