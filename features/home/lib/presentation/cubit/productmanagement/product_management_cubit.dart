import 'package:dependencies/bloc/bloc.dart';

import 'product_management_state.dart';

class ProductManagementCubit extends Cubit<ProductManagementState> {
  ProductManagementCubit()
      : super(const ProductManagementState(
            selectedTab: ProductManagementTab.products));

  void onTabSelected(ProductManagementTab tab) {
    emit(state.copyWith(selectedTab: tab));
  }
}
