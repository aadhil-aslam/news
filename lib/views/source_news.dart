import 'package:flutter/material.dart';
import '../helper/news.dart';
import '../models/article_model.dart';
import '../models/source_model.dart';
import 'article_view.dart';
import 'newlist.dart';

class SourceNews extends StatefulWidget {
  final String source;
  SourceNews({required this.source});

  @override
  State<SourceNews> createState() => _SourceNewsState();
}

class _SourceNewsState extends State<SourceNews> {
  List<SourceModel> sources = <SourceModel>[];
  List<ArticleModel> articles = [];
  bool _loading = true;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    getSourceNews();
  }

  getSourceNews() async {
    SourceNewsClass newsClass = SourceNewsClass();
    await newsClass.getNews(widget.source);
    articles = newsClass.news;
    setState(() {
      _loading = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[200],
      appBar: AppBar(
        backgroundColor: Colors.red[700],
        leading: IconButton(
          icon: Icon(Icons.arrow_back),
          onPressed: () =>
              Navigator.of(context).popUntil((route) => route.isFirst),
        ),
        title: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Text(
              ("${widget.source.toUpperCase()}"),
              style: TextStyle(color: Colors.white),
            )
          ],
        ),
        actions: <Widget>[
          Opacity(
            opacity: 0,
            child: Container(
                padding: EdgeInsets.symmetric(horizontal: 16),
                child: Icon(Icons.add)),
          )
        ],
        centerTitle: true,
        elevation: 0.0,
      ),
      body: _loading
          ? Center(
              child: Container(
                child: CircularProgressIndicator(),
              ),
            )
          : SingleChildScrollView(
              child: Container(
                child: Column(
                  children: <Widget>[
                    Container(
                      padding: EdgeInsets.symmetric(horizontal: 16),
                      margin: const EdgeInsets.only(top: 16),
                      child: ListView.builder(
                          itemCount: articles.length,
                          shrinkWrap: true,
                          physics: ClampingScrollPhysics(),
                          itemBuilder: (context, index) {
                            return NewsList(
                              imageUrl: articles[index].urlToImage ?? '',
                              content: articles[index].content ?? '',
                              title: articles[index].title ?? '',
                              desc: articles[index].description ?? '',
                              url: articles[index].url ?? '',
                              date: articles[index].publishedAt,
                              author: articles[index].author ?? '',
                            );
                          }),
                    )
                  ],
                ),
              ),
            ),
    );
  }
}
