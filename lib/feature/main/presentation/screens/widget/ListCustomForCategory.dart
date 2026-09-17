import 'package:ecommerce/feature/main/domain/entities/categoryentity.dart';
import 'package:ecommerce/feature/main/presentation/cubits/Product_Cubit/product_cubit.dart';
import 'package:ecommerce/feature/main/presentation/screens/widget/customItemForCategpry.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
class ListCustomForCategory extends StatelessWidget {
  final CategoryEntity categories;

  const ListCustomForCategory({
    super.key,
    required this.categories,
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 120,
      child: ListView.builder(
        scrollDirection: Axis.horizontal,
        itemCount: categories.data.length,
        itemBuilder: (context, index) {
          final category = categories.data[index];

          return GestureDetector(
            onTap: () {
              context
                  .read<ProductCubit>()
                  .filterByCategory(category.id);
            },
            child: Customitemforcategpry(
              categoryentity: category,
            ),
          );
        },
      ),
    );
  }

}