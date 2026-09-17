import 'package:ecommerce/feature/main/data/repo/mainrepo.dart';
import 'package:ecommerce/feature/main/domain/entities/productentity.dart';
import 'package:ecommerce/feature/main/presentation/cubits/Home_Cubit/home_state.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class HomeCubit extends Cubit<HomeState> {
  final Mainrepo mainrepo;

  HomeCubit({
    required this.mainrepo,
  }) : super(HomeInitial());

  ProductEntity? _allProducts;

  Future<void> getProducts() async {
    emit(HomeLoading());

    final result = await mainrepo.getProducts();

    result.fold(
      (ifLeft) {
        emit(
          HomeFailure(
            errmessege: ifLeft.errmessege,
          ),
        );
      },
      (ifRight) {
        _allProducts = ifRight;

        emit(
          HomeSuccess(
            products: ifRight,
          ),
        );
      },
    );
  }

  void searchProducts(String query) {
    if (_allProducts == null) {
      return;
    }

    final searchQuery = query.trim().toLowerCase();

    if (searchQuery.isEmpty) {
      emit(
        HomeSuccess(
          products: _allProducts!,
        ),
      );

      return;
    }

    final filteredProducts = _allProducts!.data.where(
      (product) {
        return product.title
            .toLowerCase()
            .contains(searchQuery);
      },
    ).toList();

    final filteredProductEntity = ProductEntity(
      results: filteredProducts.length,
      data: filteredProducts,
    );

    emit(
      HomeSuccess(
        products: filteredProductEntity,
      ),
    );
  }
}