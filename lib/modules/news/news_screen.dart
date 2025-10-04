import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:news_app/modules/home/model/app_category.dart';
import 'package:news_app/modules/news/view_model/news_view_model.dart';
import 'package:provider/provider.dart';

class NewsScreen extends StatelessWidget {
  NewsScreen({super.key});

  int selectedindex = 0;

  @override
  Widget build(BuildContext context) {
    AppCategory category =
        ModalRoute.of(context)!.settings.arguments as AppCategory;
    var theme = Theme.of(context);
    return ChangeNotifierProvider(
      create: (context) => NewsViewModel()..getSources(category.categoryId),
      child: Scaffold(
        appBar: AppBar(
          title: Text(category.categoryName),
        ),
        body: Consumer<NewsViewModel>(
          builder: (context, vm, child) {
            return Column(
              children: [
                DefaultTabController(
                  length: vm.sources.length,
                  child: TabBar(
                    tabAlignment: TabAlignment.start,
                    isScrollable: true,
                    dividerColor: Colors.transparent,
                    indicatorColor: theme.primaryColorLight,
                    labelColor: theme.primaryColorLight,
                    unselectedLabelColor: theme.primaryColorLight,
                    tabs: vm.sources.map(
                      (e) {
                        return Tab(
                          text: e.name ?? "",
                        );
                      },
                    ).toList(),
                    onTap: vm.onTab,
                  ),
                ),
                vm.isLoading
                    ? Expanded(
                        child: Center(child: CircularProgressIndicator()))
                    : Expanded(
                        child: RefreshIndicator(
                          onRefresh: () {
                            return vm.onRefresh();
                          },
                          child: ListView.builder(
                            itemCount: vm.articles.length,
                            itemBuilder: (context, index) {
                              return Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: Container(
                                  decoration: BoxDecoration(
                                      color: theme.primaryColor,
                                      borderRadius: BorderRadius.circular(16),
                                      border: Border.all(
                                          color: theme.primaryColorLight)),
                                  child: Padding(
                                    padding: const EdgeInsets.all(8.0),
                                    child: Column(
                                      children: [
                                        SizedBox(
                                          height: 200,
                                          child: ClipRRect(
                                              borderRadius:
                                                  BorderRadius.circular(10),
                                              child: Image.network(
                                                vm.articles[index].urlToImage ??
                                                    "",
                                                fit: BoxFit.cover,
                                                width: double.infinity,
                                                loadingBuilder: (context, child,
                                                    loadingProgress) {
                                                  if (loadingProgress == null) {
                                                    return child;
                                                  } else {
                                                    return Center(
                                                        child:
                                                            CircularProgressIndicator());
                                                  }
                                                },
                                                errorBuilder:
                                                    (context, error, stackTrace) {
                                                  return Column(
                                                    mainAxisAlignment:
                                                        MainAxisAlignment.center,
                                                    children: [
                                                      Icon(
                                                        Icons.error,
                                                        color: theme
                                                            .primaryColorLight,
                                                      ),
                                                      Text(
                                                        "Failed to load Image",
                                                        style: theme
                                                            .textTheme.bodyLarge,
                                                      )
                                                    ],
                                                  );
                                                },
                                              )),
                                        ),
                                        Text(vm.articles[index].title ?? "",
                                            style: theme.textTheme.bodyMedium!
                                                .copyWith(
                                                    fontWeight: FontWeight.bold)),
                                        SizedBox(
                                          height: 8,
                                        ),
                                        Row(
                                          children: [
                                            if (vm.articles[index].author !=
                                                    null &&
                                                vm.articles[index].author != "")
                                              Container(
                                                  width: 200,
                                                  child: Text(
                                                    "By : ${vm.articles[index].author}",
                                                    style: TextStyle(
                                                        color: Colors.grey,
                                                        fontSize: 12),
                                                  )),
                                            Spacer(),
                                            Text(
                                              "${DateFormat("H:m  d/MM/y ").format(DateTime.parse(vm.articles[index].publishedAt ?? ""))}",
                                              style: TextStyle(
                                                  color: Colors.grey,
                                                  fontSize: 12),
                                            ),
                                          ],
                                        ),
                                      ],
                                    ),
                                  ),
                                ),
                              );
                            },
                          ),
                        ),
                      ),
              ],
            );
          },
        ),
      ),
    );
  }
}
