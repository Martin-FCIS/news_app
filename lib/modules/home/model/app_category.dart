import 'package:news_app/core/constants/app_assets.dart';

class AppCategory {
  String categoryId;
  String categoryName;
  String categoryImage;

  AppCategory(
      {required this.categoryId,
      required this.categoryName,
      required this.categoryImage});

  static List<AppCategory> categories = [
    AppCategory(
        categoryId: "general",
        categoryName: "General",
        categoryImage: AppAssets.general),
    AppCategory(
        categoryId: "business",
        categoryName: "Business",
        categoryImage: AppAssets.business),
    AppCategory(
        categoryId: "sports",
        categoryName: "Sports",
        categoryImage: AppAssets.sports),
    AppCategory(
        categoryId: "technology",
        categoryName: "Technology",
        categoryImage: AppAssets.technology),
    AppCategory(
        categoryId: "science",
        categoryName: "Science",
        categoryImage: AppAssets.science),
    AppCategory(
        categoryId: "health",
        categoryName: "Health",
        categoryImage: AppAssets.health),
    AppCategory(
        categoryId: "entertainment",
        categoryName: "Entertainment",
        categoryImage: AppAssets.entertainment),




  ];
}
