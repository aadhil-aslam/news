import 'package:flutter/material.dart';
import '../helper/news.dart';
import '../models/article_model.dart';
import 'newlist.dart';

const List<String> list = <String>['relevancy', 'publishedAt', 'popularity'];

class SearchNews extends StatefulWidget {
  final String keyword;
  String? sort;
  SearchNews({required this.keyword, this.sort});

  @override
  State<SearchNews> createState() => _SearchNewsState();
}

class _SearchNewsState extends State<SearchNews> {
  List<ArticleModel> articles = [];
  bool _loading = true;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    getSearchNews();
  }

  getSearchNews() async {
    SearchNewsClass newsClass = SearchNewsClass();
    await newsClass.getNews(widget.keyword, widget.sort);
    articles = newsClass.news;
    setState(() {
      _loading = false;
    });
  }

  String dropdownValue = list.first;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[200],
      appBar: AppBar(
        backgroundColor: Colors.red[700],
        title: Row(
          children: <Widget>[
            Flexible(
              child: Text(
                ("${widget.keyword.toLowerCase()}"),
                style: TextStyle(color: Colors.white),
              ),
            )
          ],
        ),
        leading: IconButton(
          icon: Icon(Icons.arrow_back),
          onPressed: () =>
              Navigator.of(context).popUntil((route) => route.isFirst),
        ),
        centerTitle: false,
        elevation: 0.0,
      ),
      body: _loading
          ? Center(
              child: Container(
                child: CircularProgressIndicator(),
              ),
            )
          : articles.isNotEmpty
              ? SingleChildScrollView(
                  child: Container(
                    child: Column(
                      children: <Widget>[
                        Padding(
                          padding: const EdgeInsets.fromLTRB(0, 16, 0, 0),
                          child: ListTile(
                            trailing: Row(
                              mainAxisSize: MainAxisSize.min,
                              children: [
                                Padding(
                                  padding: const EdgeInsets.all(8.0),
                                  child: ElevatedButton(
                                    style: ElevatedButton.styleFrom(
                                        backgroundColor: Colors.white,
                                        elevation: 0.0,
                                        side: BorderSide(
                                            color: Colors.black54,
                                            width: 1.0,
                                            style: BorderStyle.solid)),
                                    onPressed: () {},
                                    child: DropdownButtonHideUnderline(
                                      child: DropdownButton<String>(
                                        value: dropdownValue,
                                        //icon: const Icon(Icons.sort),
                                        elevation: 16,
                                        style: const TextStyle(
                                            color: Colors.deepPurple),
                                        onChanged: (String? value) {
                                          setState(() {
                                            dropdownValue = value!;
                                            widget.sort = dropdownValue;
                                            getSearchNews();
                                          });
                                        },
                                        items: list
                                            .map<DropdownMenuItem<String>>(
                                                (String value) {
                                          return DropdownMenuItem<String>(
                                            value: value,
                                            child: Text(value),
                                          );
                                        }).toList(),
                                      ),
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                        Container(
                          padding: EdgeInsets.symmetric(horizontal: 12),
                          margin: const EdgeInsets.only(top: 12),
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
                )
              : Center(child: Text("No results found")),
    );
  }
}
