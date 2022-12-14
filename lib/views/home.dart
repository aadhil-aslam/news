import 'package:animations/animations.dart';
import 'package:flutter/material.dart';
import 'package:flutternews/models/article_model.dart';
import 'package:flutternews/views/search_news.dart';
import 'package:flutternews/views/source_page.dart';
import 'package:ionicons/ionicons.dart';

import '../helper/news.dart';
import 'category_tabBar.dart';
import 'countries_page.dart';

class Home extends StatefulWidget {
  const Home({Key? key}) : super(key: key);

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  final _controller = TextEditingController();

  List<ArticleModel> articles = <ArticleModel>[];

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    getNews();
    setState(() {
      typing = false;
    });
  }

  getNews() async {
    News newsClass = News();
    await newsClass.getNews();
    articles = newsClass.news;
    setState(() {
      //_loading: false;
    });
  }

  bool typing = false;

  int pageIndex = 0;

  void _onItemTapped(int index) {
    setState(() {
      typing = false;
      pageIndex = index;
    });
  }

  final pages = [
    CatTabBar(),
    SourcePage(),
    CountryPage(),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.red[700],
        title: typing
            ? Container(
                width: double.infinity,
                height: 40,
                decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(5)),
                child: Center(
                  child: TextField(
                    autofocus: true,
                    controller: _controller,
                    onSubmitted: (value) {
                      // fetch all the news related to the keyword
                      if (value.isNotEmpty) {
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => SearchNews(
                                      keyword: value,
                                      sort: '',
                                    )));
                      }
                    },
                    decoration: InputDecoration(
                        prefixIcon: const Icon(Icons.search),
                        suffixIcon: IconButton(
                          icon: const Icon(Icons.clear),
                          onPressed: () {
                            _controller.clear();
                          },
                        ),
                        hintText: 'Search...',
                        border: InputBorder.none),
                  ),
                ),
              )
            : Row(
              children: [
                Text(
                    'News',
                    style: TextStyle(color: Colors.white),
                  ),
              ],
            ),
        actions: <Widget>[
          IconButton(
            icon: Icon(
                typing ?
                Icons.home :
                Icons.search),
            onPressed: () {
              setState(() {
                typing = !typing;
                _controller.clear();
                //Provider.of<NewsArticleListViewModel>(context, listen: false)
                //    .populateTopHeadlines();
              });
            },
          ),
        ],
        //centerTitle: true,
        elevation: 0.0,
      ),
      body: PageTransitionSwitcher(
          transitionBuilder: (child, primaryAnimation, secondaryAnimaion) =>
              FadeThroughTransition(
                  animation: primaryAnimation,
                  secondaryAnimation: secondaryAnimaion,
                  child: child),
          child: pages[pageIndex]),
      bottomNavigationBar: BottomNavigationBar(
        items: const <BottomNavigationBarItem>[
          BottomNavigationBarItem(
            icon: Icon(Icons.home_outlined),
            activeIcon: Icon(Icons.home),
            label: 'Home',
          ),
          BottomNavigationBarItem(
            icon: Icon(Ionicons.newspaper_outline),
            activeIcon: Icon(Ionicons.newspaper_sharp),
            label: 'Sources',
          ),
          BottomNavigationBarItem(
            icon: Icon(Ionicons.earth_outline),
            activeIcon: Icon(Ionicons.earth_sharp),
            label: 'Countries',
          ),
        ],
        currentIndex: pageIndex,
        selectedItemColor: Colors.red[700],
        onTap: _onItemTapped,
        unselectedItemColor: Colors.black54,
      ),
    );
  }
}
