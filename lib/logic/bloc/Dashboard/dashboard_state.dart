part of 'dashboard_cubit.dart';

@immutable
class DashboardState {
  int selectedIndex;
  int productTabIndex;
  DashData? detail;
  final String? error;
  final PageController pageController;

  DashboardState({
    this.selectedIndex = 0,
    this.productTabIndex = 0,
    required this.pageController,
    this.error,
    this.detail,
  });

  DashboardState copyWith({
    int? selectedIndex,
    int? productTabIndex,
    DashData? detail,
    String? error,
    PageController? pageController,
  }) {
    return DashboardState(
      selectedIndex: selectedIndex ?? this.selectedIndex,
      productTabIndex: productTabIndex ?? this.productTabIndex,
      error: error ?? this.error,
      detail: detail ?? this.detail,
      pageController: pageController ?? this.pageController,
    );
  }
}
