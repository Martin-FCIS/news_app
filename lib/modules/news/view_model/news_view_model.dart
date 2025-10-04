import 'package:flutter/material.dart';
import 'package:news_app/api_manager/api_manager.dart';

import '../../../api_manager/models/articles_model.dart';

class NewsViewModel extends ChangeNotifier {
  List<Articles>articles = [];
  List<Source>sources=[];
  bool isLoading=false;

  Future<void> getNews(String source) async {
    isLoading=true;
    notifyListeners();
    articles = await ApiManager.getNews(source);
    isLoading=false;
    notifyListeners();
  }

  Future<void> getSources(String id) async {
    sources= await ApiManager.getSources(id);
    getNews(sources[0].id??"");
    notifyListeners();
  }
}