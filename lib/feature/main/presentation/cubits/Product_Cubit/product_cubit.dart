import 'package:ecommerce/feature/main/data/repo/mainrepo.dart';
import 'package:ecommerce/feature/main/domain/entities/categoryentity.dart';
import 'package:ecommerce/feature/main/domain/entities/productentity.dart';
import 'package:ecommerce/feature/main/presentation/cubits/Product_Cubit/product_state.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class ProductCubit extends Cubit<ProductState> {
  final Mainrepo mainrepo;

  ProductCubit({
    required this.mainrepo,
  }) : super(ProductInitial());

  ProductEntity? _allProducts;
  CategoryEntity? _categories;

  String? _selectedCategoryId;
  String _searchQuery = '';

  Future<void> getProductData() async {
    emit(ProductLoading());

    final categoriesResult = await mainrepo.getCategory();

    if (categoriesResult.isLeft()) {
      categoriesResult.fold(
        (failure) {
          emit(
            ProductFailure(
              errmessege: failure.errmessege,
            ),
          );
        },
        (_) {},
      );

      return;
    }

    final productsResult = await mainrepo.getProducts();

    categoriesResult.fold(
      (_) {},
      (categories) {
        productsResult.fold(
          (failure) {
            emit(
              ProductFailure(
                errmessege: failure.errmessege,
              ),
            );
          },
          (products) {
            _categories = categories;
            _allProducts = products;

            emit(
              ProductSuccess(
                categories: categories,
                products: products,
              ),
            );
          },
        );
      },
    );
  }

  // =========================
  // Search Products
  // =========================
  void searchProducts(String query) {
    _searchQuery = query.trim();

    _applyFilters();
  }

  // =========================
  // Filter By Category
  // =========================
  void filterByCategory(String categoryId) {
    if (_selectedCategoryId == categoryId) {
      _selectedCategoryId = null;
    } else {
      _selectedCategoryId = categoryId;
    }

    _applyFilters();
  }

  // =========================
  // Show All Products
  // =========================
  void showAllProducts() {
    _selectedCategoryId = null;
    _searchQuery = '';

    if (_allProducts == null || _categories == null) {
      return;
    }

    emit(
      ProductSuccess(
        categories: _categories!,
        products: _allProducts!,
      ),
    );
  }

  // =========================
  // Apply Search + Category
  // =========================
  void _applyFilters() {
    if (_allProducts == null || _categories == null) {
      return;
    }

    List<ProductDataEntity> filteredProducts =
        List<ProductDataEntity>.from(
      _allProducts!.data,
    );

    // Category Filter
    if (_selectedCategoryId != null) {
      filteredProducts = filteredProducts.where(
        (product) {
          return product.categoryId ==
              _selectedCategoryId;
        },
      ).toList();
    }

    // Search Filter
    if (_searchQuery.isNotEmpty) {
      final query = _searchQuery.toLowerCase();

      filteredProducts = filteredProducts.where(
        (product) {
          final title = product.title.toLowerCase();

          return title.contains(query);
        },
      ).toList();
    }

    final filteredProductsEntity = ProductEntity(
      results: filteredProducts.length,
      data: filteredProducts,
    );

    emit(
      ProductSuccess(
        categories: _categories!,
        products: filteredProductsEntity,
      ),
    );
  }
}