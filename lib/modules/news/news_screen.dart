import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:news_app/api_manager/api_manager.dart';
import 'package:news_app/api_manager/models/articles_model.dart';
import 'package:news_app/modules/home/model/app_category.dart';

class NewsScreen extends StatefulWidget {
  const NewsScreen({super.key});

  @override
  State<NewsScreen> createState() => _NewsScreenState();
}

class _NewsScreenState extends State<NewsScreen> {
  int selectedindex = 0;

  @override
  Widget build(BuildContext context) {
    AppCategory category =
        ModalRoute.of(context)!.settings.arguments as AppCategory;
    var theme = Theme.of(context);
    return Scaffold(
      appBar: AppBar(
        title: Text(category.categoryName),
      ),
      body: FutureBuilder(
        future: ApiManager.getSources(category.categoryId),
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            List<Source> sources = snapshot.data ?? [];
            return Column(
              children: [
                DefaultTabController(
                  length: sources.length,
                  child: TabBar(
                    tabAlignment: TabAlignment.start,
                    isScrollable: true,
                    dividerColor: Colors.transparent,
                    indicatorColor: theme.primaryColorLight,
                    labelColor: theme.primaryColorLight,
                    unselectedLabelColor: theme.primaryColorLight,
                    tabs: sources.map(
                      (e) {
                        return Tab(
                          text: e.name ?? "",
                        );
                      },
                    ).toList(),
                    onTap: (value) {
                      selectedindex = value;
                      setState(() {});
                    },
                  ),
                ),
                Expanded(
                  child: FutureBuilder(
                    future: ApiManager.getNews(sources[selectedindex].id ?? ""),
                    builder: (context, snapshot) {
                      if (snapshot.connectionState == ConnectionState.waiting) {
                        return Center(child: CircularProgressIndicator());
                      } else if (snapshot.hasData) {
                        List<Articles> articles = snapshot.data ?? [];
                        return ListView.builder(
                          itemCount: articles.length,
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
                                              articles[index].urlToImage ?? "",
                                              fit: BoxFit.cover,
                                              width: double.infinity,
                                              loadingBuilder: (context, child, loadingProgress) {
                                                if(loadingProgress==null){
                                                  return child;
                                                }
                                                else{
                                                  return Center(child: CircularProgressIndicator());
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
                                      Text(articles[index].title ?? "",
                                          style: theme.textTheme.bodyMedium!
                                              .copyWith(
                                                  fontWeight: FontWeight.bold)),
                                      SizedBox(
                                        height: 8,
                                      ),
                                      Row(
                                        children: [
                                          if (articles[index].author != null &&
                                              articles[index].author != "")
                                            Container(
                                                width: 200,
                                                child: Text(
                                                  "By : ${articles[index].author}",
                                                  style: TextStyle(
                                                      color: Colors.grey,
                                                      fontSize: 12),
                                                )),
                                          Spacer(),
                                          Text(
                                            "${DateFormat("H:m  d/MM/y ").format(DateTime.parse(articles[index].publishedAt ?? ""))}" ??
                                                "",
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
                        );
                      } else if (snapshot.hasError) {
                        return Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Text(snapshot.error.toString(),
                              style: TextStyle(color: Colors.white)),
                        );
                      } else {
                        return Center(child: CircularProgressIndicator());
                      }
                    },
                  ),
                ),
              ],
            );
          } else if (snapshot.hasError) {
            return Padding(
              padding: const EdgeInsets.all(8.0),
              child: Text(snapshot.error.toString(),
                  style: TextStyle(color: Colors.white)),
            );
          } else {
            return Center(child: CircularProgressIndicator());
          }
        },
      ),
    );
  }
}
