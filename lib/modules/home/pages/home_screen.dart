import 'package:flutter/material.dart';
import 'package:news_app/core/constants/app_assets.dart';
import 'package:news_app/core/theme/app_colors.dart';
import 'package:news_app/modules/home/model/app_category.dart';
import 'package:news_app/modules/home/widgets/category_card_widget.dart';
import 'package:news_app/modules/home/widgets/custom_select_theme_lang_widget.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    var theme = Theme.of(context);
    return Scaffold(
      appBar: AppBar(
        title: Text("Home"),
        actions: [Icon(Icons.search_rounded)],
      ),
      drawer: Drawer(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.zero),
        backgroundColor: AppColors.darkBg,
        child: Column(
          children: [
            DrawerHeader(
              decoration: BoxDecoration(color: AppColors.lightBg),
              child: Center(
                child: Text(
                  "News App",
                  style: TextStyle(
                      fontSize: 30,
                      fontWeight: FontWeight.bold,
                      color: AppColors.darkBg),
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                children: [
                  InkWell(
                    onTap: () {},
                    child: Container(
                      height: 60,
                      width: double.infinity,
                      child: Row(
                        children: [
                          ImageIcon(
                            AssetImage(AppAssets.homeIcon),
                            color: AppColors.lightBg,
                          ),
                          SizedBox(
                            width: 10,
                          ),
                          Text(
                            "Go To Home",
                            style: TextStyle(fontWeight: FontWeight.bold,color: AppColors.lightBg),
                          ),
                        ],
                      ),
                    ),
                  ),
                  Divider(),
                  SizedBox(
                    height: 25,
                  ),
                  CustomSelectThemeLangWidget(
                    selectedlabel: "Theme",
                    icon: ImageIcon(
                      AssetImage(AppAssets.themeIcon),
                    ),

                  ),
                  SizedBox(
                    height: 25,
                  ),
                  Divider(),
                  SizedBox(
                    height: 25,
                  ),
                  // CustomSelectThemeLangWidget(
                  //   selectedlabel: "Language",
                  //   icon: ImageIcon(
                  //     AssetImage(AppAssets.langIcon),
                  //   ),
                  // ),
                ],
              ),
            ),
          ],
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          children: [
            Text(
              "Good Morning\nHere is Some News For You",
              style: theme.textTheme.bodyLarge,
            ),
         Expanded(
           child: ListView.builder(itemBuilder: (context, index) {
             return Padding(
               padding: const EdgeInsets.only(top: 8.0),
               child: CategoryCardWidget(category: AppCategory.categories[index],isLeft: index%2==0,),
             );
           },itemCount: AppCategory.categories.length,),
         )
          ],
        ),
      ),
    );
  }
}
