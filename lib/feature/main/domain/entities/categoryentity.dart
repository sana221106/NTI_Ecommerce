class CategoryEntity {
  final int results;
  final List<CategoryDataEntity> data;

  CategoryEntity({required this.results, required this.data});
}

class CategoryDataEntity {
  final String name;
  final String image;
  final String id;
  final String slug;

  CategoryDataEntity({
    required this.name,
    required this.image,
    required this.id,
    required this.slug,
  });
}
