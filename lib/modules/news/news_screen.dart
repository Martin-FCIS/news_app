import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';
import 'package:news_app/modules/home/model/app_category.dart';
import 'package:news_app/modules/news/cubit/news_cubit.dart';
import 'package:news_app/modules/news/cubit/news_state.dart';
class NewsScreen extends StatelessWidget {
  const NewsScreen({super.key});
  @override
  Widget build(BuildContext context) {
    AppCategory category =
        ModalRoute.of(context)!.settings.arguments as AppCategory;
    var theme = Theme.of(context);
    return BlocProvider<NewsCubit>(
      create: (context) => NewsCubit()..getSources(category.categoryId),
      child: Scaffold(
        appBar: AppBar(
          title: Text(category.categoryName),
        ),
        body: Column(
          children: [
            BlocBuilder<NewsCubit, NewsState>(
              builder: (context, state) {
                var cubit=context.watch<NewsCubit>();
                if (state is GetSourcesSuccessState) {
                  return DefaultTabController(
                    length: state.sources.length,
                    child: TabBar(
                      tabAlignment: TabAlignment.start,
                      isScrollable: true,
                      dividerColor: Colors.transparent,
                      indicatorColor: theme.primaryColorLight,
                      labelColor: theme.primaryColorLight,
                      unselectedLabelColor: theme.primaryColorLight,
                      tabs: state.sources.map(
                        (e) {
                          return Tab(
                            text: e.name ?? "",
                          );
                        },
                      ).toList(),
                      onTap: (value) {
                        cubit.getNews(state.sources[value].id??"");
                      },
                    ),
                  );
                } else if (state is GetSourcesErrorState) {
                  return Center(
                    child: Text(state.error),
                  );
                } else {
                  return Center(
                    child: CircularProgressIndicator(),
                  );
                }
              },
              buildWhen: (previous, current) {
                return current is GetSourcesSuccessState ||
                    current is GetSourcesErrorState ||
                    current is GetSourcesLoadingState;
              },
            ),
            Expanded(
              child: BlocConsumer<NewsCubit, NewsState>(
                listener: (context, state) {},
                builder: (context, state) {
                  if (state is GetNewsSuccessState) {
                    return ListView.builder(
                      itemCount: state.articles.length,
                      itemBuilder: (context, index) {
                        return Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Container(
                            decoration: BoxDecoration(
                                color: theme.primaryColor,
                                borderRadius: BorderRadius.circular(16),
                                border:
                                    Border.all(color: theme.primaryColorLight)),
                            child: Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Column(
                                children: [
                                  SizedBox(
                                    height: 200,
                                    child: ClipRRect(
                                        borderRadius: BorderRadius.circular(10),
                                        child: Image.network(
                                          state.articles[index].urlToImage ??
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
                                                  color:
                                                      theme.primaryColorLight,
                                                ),
                                                Text(
                                                  "Failed to load Image",
                                                  style:
                                                      theme.textTheme.bodyLarge,
                                                )
                                              ],
                                            );
                                          },
                                        )),
                                  ),
                                  Text(state.articles[index].title ?? "",
                                      style: theme.textTheme.bodyMedium!
                                          .copyWith(
                                              fontWeight: FontWeight.bold)),
                                  SizedBox(
                                    height: 8,
                                  ),
                                  Row(
                                    children: [
                                      if (state.articles[index].author !=
                                              null &&
                                          state.articles[index].author != "")
                                        Container(
                                            width: 200,
                                            child: Text(
                                              "By : ${state.articles[index].author}",
                                              style: TextStyle(
                                                  color: Colors.grey,
                                                  fontSize: 12),
                                            )),
                                      Spacer(),
                                      Text(
                                        "${DateFormat("H:m  d/MM/y ").format(DateTime.parse(state.articles[index].publishedAt ?? ""))}",
                                        style: TextStyle(
                                            color: Colors.grey, fontSize: 12),
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
                  } else if (state is GetNewsErrorState) {
                    return Center(
                      child: Text(state.error),
                    );
                  } else {
                    return Center(
                      child: CircularProgressIndicator(),
                    );
                  }
                },
                buildWhen: (previous, current) {
                  return current is GetNewsErrorState||current is GetNewsSuccessState||current is GetNewsLoadingState;
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
