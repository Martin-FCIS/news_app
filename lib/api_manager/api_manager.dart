import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:news_app/api_manager/models/articles_model.dart';

class ApiManager{

  static const _baseUrl="https://newsapi.org/v2/";
  static const _apiKey="ee28a83264884410960e917a23d786a9";
  // without using json to dart
// static  Future<List<ArticleModel>> getNews()async {
//   List<ArticleModel>articles=[];
//   Uri url= Uri.parse("https://newsapi.org/v2/top-headlines?country=us&apiKey=ee28a83264884410960e917a23d786a9");
//   http.Response response=await http.get(url);
// var json=jsonDecode(response.body);
// for(var e in json["articles"]){
//   articles.add(ArticleModel.fromJson(e));
// }
// return articles;
// }

//using json to dart
 static  Future<List<Articles>> getNews(String source)async {
   Uri url= Uri.parse("${_baseUrl}top-headlines?sources=$source&apiKey=$_apiKey");
   http.Response response=await http.get(url);
 var json=jsonDecode(response.body);
var data=ArticleResponse.fromJson(json);
 return data.articles??[];
 }
 static  Future<List<Source>> getSources(String id)async {
     List<Source>sources=[];
   Uri url= Uri.parse("$_baseUrl/sources?category=$id&apiKey=$_apiKey");
   http.Response response=await http.get(url);
     //print(response.body);
     var json=jsonDecode(response.body);
for(var e in json["sources"]){
  sources.add(Source.fromJson(e));
}
  return sources;
 }
}