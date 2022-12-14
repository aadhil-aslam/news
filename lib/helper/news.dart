import 'dart:convert';
import '../models/article_model.dart';
import 'package:http/http.dart' as http;

import '../models/source_model.dart';

class News {
  List<ArticleModel> news = [];

  Future<void> getNews() async {
    String url = "https://newsapi.org/v2/top-headlines?country=us&apiKey=7f40eb545a4a4038985c0e6a90311dde";

    var response = await http.get(Uri.parse(url));

    var jsonData = jsonDecode(response.body);

    if (jsonData['status'] == 'ok') {
      jsonData['articles'].forEach((element) {

        if (element['urlToImage'] != null && element['description'] != null) {

          ArticleModel articleModel = ArticleModel(
            title: element['title'],
            author: element['author'],
            description: element['description'],
            url: element['url'],
            urlToImage: element['urlToImage'],
            content: element['content'],
            publishedAt: element['publishedAt'],
          );
          news.add(articleModel);
        }
      });
    }
  }
}

class CategoryNewsClass {
  List<ArticleModel> news = [];

  Future<void> getNews(String category) async {
    String url = "https://newsapi.org/v2/top-headlines?country=us&category=$category&apiKey=7f40eb545a4a4038985c0e6a90311dde";

    var response = await http.get(Uri.parse(url));

    var jsonData = jsonDecode(response.body);

    if (jsonData['status'] == 'ok') {
      jsonData['articles'].forEach((element) {

        if (element['urlToImage'] != null && element['description'] != null) {

          ArticleModel articleModel = ArticleModel(
            title: element['title'],
            author: element['author'],
            description: element['description'],
            url: element['url'],
            urlToImage: element['urlToImage'],
            content: element['content'],
            publishedAt: element['publishedAt'],
          );

          news.add(articleModel);
        }
      });
    }
  }
}

class SearchNewsClass {
  List<ArticleModel> news = [];

  Future<void> getNews(String keyword, String? sort) async {
    String url = "https://newsapi.org/v2/everything?q=$keyword&sortBy=$sort&apiKey=7f40eb545a4a4038985c0e6a90311dde";

    var response = await http.get(Uri.parse(url));

    var jsonData = jsonDecode(response.body);

    if (jsonData['status'] == 'ok') {
      jsonData['articles'].forEach((element) {

        if (element['urlToImage'] != null && element['description'] != null) {

          ArticleModel articleModel = ArticleModel(
            title: element['title'],
            author: element['author'],
            description: element['description'],
            url: element['url'],
            urlToImage: element['urlToImage'],
            content: element['content'],
            publishedAt: element['publishedAt'],
          );

          news.add(articleModel);
        }
      });
    }
    print("");
  }
}

class SourceListClass {
  List<SourceModel> source = [];

  Future<void> getSourceList() async {
    String url = "https://newsapi.org/v2/top-headlines/sources?country=us&apiKey=7f40eb545a4a4038985c0e6a90311dde";

    var response = await http.get(Uri.parse(url));

    var jsonData = jsonDecode(response.body);

    if (jsonData['status'] == 'ok') {
      jsonData['sources'].forEach((element) {

        if (element['name'] != null) {

          SourceModel sourceModel = SourceModel(
            id: element['id'],
            name: element['name'],
            description: element['description'],
            url: element['url'],
            category: element['category'],
            country: element['country'],
            language: element['language'],
          );

          source.add(sourceModel);
        }
      });
    }
    print("");
  }
}

class SourceNewsClass {
  List<ArticleModel> news = [];

  Future<void> getNews(String source) async {
    String url = "https://newsapi.org/v2/top-headlines?sources=$source&apiKey=7f40eb545a4a4038985c0e6a90311dde";

    var response = await http.get(Uri.parse(url));

    var jsonData = jsonDecode(response.body);

    if (jsonData['status'] == 'ok') {
      jsonData['articles'].forEach((element) {

        if (element['urlToImage'] != null && element['description'] != null) {

          ArticleModel articleModel = ArticleModel(
            title: element['title'],
            author: element['author'],
            description: element['description'],
            url: element['url'],
            urlToImage: element['urlToImage'],
            content: element['content'],
            publishedAt: element['publishedAt'],
          );

          news.add(articleModel);
        }
      });
    }
  }
}

class CountryNewsClass {
  List<ArticleModel> news = [];

  Future<void> getNews(String country) async {
    String url = "https://newsapi.org/v2/top-headlines?country=$country&apiKey=7f40eb545a4a4038985c0e6a90311dde";

    var response = await http.get(Uri.parse(url));

    var jsonData = jsonDecode(response.body);

    if (jsonData['status'] == 'ok') {
      jsonData['articles'].forEach((element) {

        if (element['urlToImage'] != null && element['description'] != null) {

          ArticleModel articleModel = ArticleModel(
            title: element['title'],
            author: element['author'],
            description: element['description'],
            url: element['url'],
            urlToImage: element['urlToImage'],
            content: element['content'],
            publishedAt: element['publishedAt'],
          );

          news.add(articleModel);
        }
      });
    }
  }
}