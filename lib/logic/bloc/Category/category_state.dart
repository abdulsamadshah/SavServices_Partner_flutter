part of 'category_cubit.dart';

@immutable
 class CategoryState {
  String categoryImage;

  CategoryState({this.categoryImage = ""});

  CategoryState copyWith({
    String? categoryImage,
  }) {
    return CategoryState(
      categoryImage: categoryImage ?? this.categoryImage,);
  }
}
final class GroupInitial extends CategoryState {}
