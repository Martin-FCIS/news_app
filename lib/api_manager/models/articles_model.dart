// // "author": "Matt Novak",
// // "title": "Bitcoin Flash Crash Roils Crypto Market",
// // "description": "Did a single whale disrupt the crypto ocean?",
// // "url": "https://gizmodo.com/bitcoin-price-flash-crash-ether-thiel-2000647613",
// // "urlToImage": "https://gizmodo.com/app/uploads/2024/08/A-bitcoin-token.jpg",
// // "publishedAt": "2025-08-25T17:50:49Z",
// // "content": "Crypto prices dipped Monday following a so-called flash crash of Bitcoin on Sunday. And while Ethereum dipped as well, the second most popular cryptocurrency is still up significantly on the month.\r\n… [+3991 chars]"
//
// class ArticleModel {
//   String? author;
//   String? title;
//   String? description;
//   String? url;
//   String? urlToImage;
//   String? publishedAt;
//   String? content;
//
//   ArticleModel(
//       {required this.author,
//       required this.title,
//       required this.description,
//       required this.url,
//       required this.urlToImage,
//       required this.publishedAt,
//       required this.content});
//
//   factory ArticleModel.fromJson(dynamic json) {
//     return ArticleModel(
//         author: json["author"],
//         title: json["title"],
//         description: json["description"],
//         url: json["url"],
//         urlToImage: json["urlToImage"],
//         publishedAt: json["publishedAt"],
//         content: json["content"]);
//   }
// }
class ArticleResponse {
  String? status;
  int? totalResults;
  List<Articles>? articles;

  ArticleResponse({this.status, this.totalResults, this.articles});

  ArticleResponse.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    totalResults = json['totalResults'];
    if (json['articles'] != null) {
      articles = <Articles>[];
      json['articles'].forEach((v) {
        articles!.add(new Articles.fromJson(v));
      });
    }
  }

  // Map<String, dynamic> toJson() {
  //   final Map<String, dynamic> data = new Map<String, dynamic>();
  //   data['status'] = this.status;
  //   data['totalResults'] = this.totalResults;
  //   if (this.articles != null) {
  //     data['articles'] = this.articles!.map((v) => v.toJson()).toList();
  //   }
  //   return data;
  // }
}

class Articles {
  Source? source;
  String? author;
  String? title;
  String? description;
  String? url;
  String? urlToImage;
  String? publishedAt;
  String? content;

  Articles(
      {this.source,
        this.author,
        this.title,
        this.description,
        this.url,
        this.urlToImage,
        this.publishedAt,
        this.content});

  Articles.fromJson(Map<String, dynamic> json) {
    source =
    json['source'] != null ? new Source.fromJson(json['source']) : null;
    author = json['author'];
    title = json['title'];
    description = json['description'];
    url = json['url'];
    urlToImage = json['urlToImage'];
    publishedAt = json['publishedAt'];
    content = json['content'];
  }

  // Map<String, dynamic> toJson() {
  //   final Map<String, dynamic> data = new Map<String, dynamic>();
  //   if (this.source != null) {
  //     data['source'] = this.source!.toJson();
  //   }
  //   data['author'] = this.author;
  //   data['title'] = this.title;
  //   data['description'] = this.description;
  //   data['url'] = this.url;
  //   data['urlToImage'] = this.urlToImage;
  //   data['publishedAt'] = this.publishedAt;
  //   data['content'] = this.content;
  //   return data;
  // }
}

class Source {
  String? id;
  String? name;

  Source({this.id, this.name});

  Source.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
  }

  // Map<String, dynamic> toJson() {
  //   final Map<String, dynamic> data = new Map<String, dynamic>();
  //   data['id'] = this.id;
  //   data['name'] = this.name;
  //   return data;
  // }
}