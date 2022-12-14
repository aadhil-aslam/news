import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import 'package:timeago/timeago.dart' as timeago;
import '../helper/news.dart';
import '../models/article_model.dart';
import 'article_view.dart';

class CatTabBar extends StatefulWidget {
  const CatTabBar({Key? key}) : super(key: key);

  @override
  State<CatTabBar> createState() => _CatTabBarState();
}

class _CatTabBarState extends State<CatTabBar>
{
  late TabController _controller;
  bool _loading = true;
  String categortIndex = "general";

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    getCategoryNews();
    print("initState");
  }

  getCategoryNews() async {
    CategoryNewsClass newsClass = CategoryNewsClass();
    await newsClass.getNews(categortIndex);
    articles = newsClass.news;
    print("ok");
    setState(() {
      _loading = false;
    });
  }

  List<ArticleModel> articles = <ArticleModel>[];

  List<String> category = [
    "General",
    "Entertainment",
    "Business",
    "Health",
    "Science",
    "Sports",
    "Technology"
  ];

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      //initialIndex: 0,
      length: category.length,
      child: Scaffold(
        backgroundColor: Colors.grey[200],
        appBar: PreferredSize(
          preferredSize: Size.fromHeight(55.0),
          child: AppBar(
              backgroundColor: Colors.white,
              bottom: TabBar(
                onTap: (index) {
                  setState(() {
                    categortIndex = category[index].toLowerCase();
                  });
                  getCategoryNews();
                },
                labelColor: Colors.black,
                unselectedLabelColor: Colors.black87,
                labelPadding: EdgeInsets.symmetric(vertical: 0, horizontal: 3),
                indicatorColor: Colors.red[700],
                indicatorWeight: 4,
                isScrollable: true,
                tabs: List<Widget>.generate(
                  category.length,
                  (int index) {
                    return Padding(
                      padding: const EdgeInsets.only(left: 15.0, right: 9),
                      child: Tab(text: category[index]),
                    );
                  },
                ),
              )),
        ),
        body: _loading
            ? Center(
                child: Container(
                  child: CircularProgressIndicator(),
                ),
              )
            : SingleChildScrollView(
                child: Column(
                  children: [
                    SizedBox(
                      height: 10,
                    ),
                    Container(
                      padding: EdgeInsets.symmetric(horizontal: 8),
                      child: Column(
                        children: <Widget>[
                          ///Blogs
                          Container(
                            margin: const EdgeInsets.only(top: 2),
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
                  ],
                ),
              ),
      ),
    );
  }
}

class NewsList extends StatelessWidget {
  final String imageUrl, title, desc, url, date, author, content;
  NewsList(
      {required this.imageUrl,
      required this.title,
      required this.desc,
      required this.url,
      required this.date,
      required this.content,
      required this.author});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        Navigator.push(
            context,
            MaterialPageRoute(
                builder: (context) => ArticleView(
                      blogUrl: url,
                    )));
      },
      child: Padding(
        padding: const EdgeInsets.all(4.0),
        child: Container(
          height: 130,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(10),
            color: Colors.white,
            boxShadow: [
              BoxShadow(
                color: Colors.grey.withOpacity(0.5),
                spreadRadius: 0,
                blurRadius: 1,
                offset: Offset(0, 0), // changes position of shadow
              ),
            ],
          ),
          child: Padding(
            padding: const EdgeInsets.all(10.0),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Expanded(
                      flex: 2,
                      child: Padding(
                        padding: const EdgeInsets.only(right: 5.0),
                        child: ClipRRect(
                          borderRadius: BorderRadius.circular(6),
                          child: Image.network(
                            imageUrl ?? '',
                            width: 130,
                            height: 130,
                            fit: BoxFit.cover,
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
                Expanded(
                  flex: 3,
                  child: Padding(
                    padding: const EdgeInsets.fromLTRB(10.0, 0.0, 20.0, 0.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: <Widget>[
                        Text(
                          title,
                          style: const TextStyle(
                              fontSize: 13, fontWeight: FontWeight.w500),maxLines:3,
                        ),
                        const Padding(padding: EdgeInsets.only(top: 8.0)),
                        // Text(desc, style: TextStyle(fontSize: 12), maxLines: 2),
                        // const Padding(padding: EdgeInsets.symmetric(vertical: 2.0)),
                        Text(desc, style: TextStyle(fontSize: 11), maxLines: 2),
                        Divider(color: Colors.black26),
                        Text(timeUntil(DateTime.parse(date)),
                            style: TextStyle(fontSize: 11)),
                      ],
                    ),
                  ),
                ),
                // const Icon(
                //   Icons.more_vert,
                //   size: 16.0,
                // ),
              ],
            ),
          ),
        ),
      ),
    );
  }
  String timeUntil(DateTime date) {
    return timeago.format(date, allowFromNow: true, locale: 'en');
  }
}
