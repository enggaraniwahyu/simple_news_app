import 'dart:convert';

import 'package:http/http.dart';
import 'package:simple_news_app/models/article_model.dart';

class ApiHeadline {
  final endPointUrl =
      "https://newsapi.org/v2/top-headlines?country=us&pageSize=5&apiKey=2ad1bd2a81b347e6bc3711654a1491b1";

  Future<List<Article>> getArticle() async {
    Response res = await get(Uri.parse(endPointUrl));

    if (res.statusCode == 200) {
      Map<String, dynamic> json = jsonDecode(res.body);

      List<dynamic> body = json['articles'];

      List<Article> articles =
          body.map((dynamic item) => Article.fromJson(item)).toList();

      return articles;
    } else {
      throw ("Gagal Mendapatkan Articles");
    }
  }
}

class ApiRecomendation {
  final endPointUrl =
      "https://newsapi.org/v2/everything?q=covid&pageSize=8&apiKey=2ad1bd2a81b347e6bc3711654a1491b1";

  Future<List<Article>> getArticle() async {
    Response res = await get(Uri.parse(endPointUrl));

    if (res.statusCode == 200) {
      Map<String, dynamic> json = jsonDecode(res.body);

      List<dynamic> body = json['articles'];

      List<Article> articles =
          body.map((dynamic item) => Article.fromJson(item)).toList();

      return articles;
    } else {
      throw ("Gagal Mendapatkan Articles");
    }
  }
}

class ApiCategory {
  final String category;

  ApiCategory(this.category);

  Future<List<Article>> getArticle() async {
    final endPointUrl =
        "https://newsapi.org/v2/top-headlines?country=us&category=$category&pageSize=3&apiKey=2ad1bd2a81b347e6bc3711654a1491b1";

    Response res = await get(Uri.parse(endPointUrl));

    if (res.statusCode == 200) {
      Map<String, dynamic> json = jsonDecode(res.body);

      List<dynamic> body = json['articles'];

      List<Article> articles =
          body.map((dynamic item) => Article.fromJson(item)).toList();

      return articles;
    } else {
      throw ("Gagal Mendapatkan Articles");
    }
  }
}
