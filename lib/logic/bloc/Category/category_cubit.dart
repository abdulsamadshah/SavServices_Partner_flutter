import 'package:bloc/bloc.dart';
import 'package:dio/dio.dart';
import 'package:flutter/cupertino.dart';
import 'package:meta/meta.dart';
import 'package:partner/core/constant/Dialog/Common_dialog.dart';
import 'package:partner/core/constant/Utils.dart';
import 'package:partner/core/constant/utility.dart';
import 'package:partner/data/repositories/product.repo.dart';
import 'package:http_parser/http_parser.dart';
import '../../../core/constant/loading.dart';

part 'category_state.dart';

class CategoryCubit extends Cubit<CategoryState> {
  CategoryCubit() : super(GroupInitial());

  final categoryName = TextEditingController();
  final GlobalKey<FormState> categoryKey = GlobalKey<FormState>();

  addCategoryImage(String image) {
    emit(state.copyWith(categoryImage: image));
  }


  Future<void> createGroup(BuildContext context) async {
    try {
      Loading().showloading(context);


      print("categoryImge--------${ state.categoryImage.toString()}");
      var data = FormData.fromMap({
         'name': categoryName.text,
        "Image": Utility.isNotNullEmptyOrFalse(state.categoryImage)
            ? await MultipartFile.fromFile(
           state.categoryImage.toString(),
            filename:state.categoryImage.toString(),
            contentType: MediaType(
              'image',
              'jpeg',
            ))
            : "",
      });
      var result = await ProductRepo.createGroup(data);
      if (result.status == true) {
        Loading().dismissloading(context);
        Utils.fluttertoast(result.message.toString());
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
