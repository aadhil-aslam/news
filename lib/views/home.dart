import 'package:animations/animations.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutternews/models/article_model.dart';
import 'package:flutternews/views/article_view.dart';
import 'package:flutternews/views/catogery_news.dart';
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

  //bool _loading = true;

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
                // Padding(
                //   padding: const EdgeInsets.only(right: 8.0),
                //   child: Container(
                //       width: 20, child: Image.asset('assets/img/logo.png')),
                // ),
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
          // IconButton(
          //   icon: Icon(
          //       // typing ?
          //       Icons.home
          //       // : Icons.search
          //       ),
          //   onPressed: () {
          //     setState(() {
          //       typing = false;
          //       _controller.clear();
          //       //typing = !typing;
          //       // Provider.of<NewsArticleListViewModel>(context, listen: false)
          //       //     .populateTopHeadlines();
          //     });
          //   },
          // )
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
            // icon: Icon(Icons.grid_view_outlined),
            // activeIcon: Icon(Icons.grid_view_sharp),
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

class CategoryTile extends StatelessWidget {
  final imageUrl, categoryName;
  CategoryTile({this.imageUrl, this.categoryName});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        Navigator.push(
            context,
            MaterialPageRoute(
                builder: (context) => CategoryNews(
                      category: categoryName.toLowerCase(),
                    )));
      },
      child: Container(
        margin: EdgeInsets.only(right: 16),
        child: Stack(
          children: <Widget>[
            ClipRRect(
              borderRadius: BorderRadius.circular(6),
              child: CachedNetworkImage(
                imageUrl: imageUrl,
                width: 120,
                height: 60,
                fit: BoxFit.cover,
              ),
            ),
            Container(
              alignment: Alignment.center,
              width: 120,
              height: 60,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(6),
                color: Colors.black26,
              ),
              child: Text(categoryName,
                  style: TextStyle(
                      color: Colors.white,
                      fontSize: 14,
                      fontWeight: FontWeight.w500)),
            )
          ],
        ),
      ),
    );
  }
}

class BlogTile extends StatelessWidget {
  final String imageUrl, title, desc, url;
  BlogTile(
      {required this.imageUrl,
      required this.title,
      required this.desc,
      required this.url});

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
      child: Container(
        margin: EdgeInsets.only(bottom: 16),
        child: Column(
          children: <Widget>[
            ClipRRect(
                borderRadius: BorderRadius.circular(6),
                child: Image.network(imageUrl)),
            SizedBox(
              height: 8,
            ),
            Text(
              title,
              style: TextStyle(
                  fontSize: 17,
                  color: Colors.black87,
                  fontWeight: FontWeight.w500),
            ),
            SizedBox(
              height: 8,
            ),
            Text(
              desc,
              style: TextStyle(color: Colors.black54),
            )
          ],
        ),
      ),
    );
  }
}
