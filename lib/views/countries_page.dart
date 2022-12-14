import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutternews/helper/countries.dart';
import 'package:flutternews/models/article_model.dart';
import 'package:flutternews/views/article_view.dart';
import 'package:flutternews/views/catogery_news.dart';
import 'package:flutternews/views/search_news.dart';
import 'package:flutternews/views/source_news.dart';

import '../helper/news.dart';
import '../models/country_model.dart';
import '../models/source_model.dart';
import 'country_news.dart';

class CountryPage extends StatefulWidget {
  const CountryPage({Key? key}) : super(key: key);

  @override
  State<CountryPage> createState() => _CountryPageState();
}

class _CountryPageState extends State<CountryPage> {

  final _controller = TextEditingController();

  List<CountryModel> countries = <CountryModel>[];
  List<ArticleModel> articles = <ArticleModel>[];

  bool _loading = true;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    countries = getCountries();
    getNews();
  }

  getNews() async {
    News newsClass = News();
    await newsClass.getNews();
    articles = newsClass.news;
    setState(() {
      _loading = false;
    });
  }

  bool typing = false;

  int pageIndex = 0;

  void _onItemTapped(int index) {
    setState(() {
      pageIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Colors.grey[100],
        body: SafeArea(
          child: _loading
              ? Center(
            child: CircularProgressIndicator(),
          )
              : SingleChildScrollView(
            child: Column(
              children: [

                SizedBox(height: 15),
                ListTile(
                  title: Text(
                    "Countries",
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 25,
                    ),
                  ),
                ),
                SingleChildScrollView(
                  child: Container(
                      padding: EdgeInsets.all(5.0),
                      child: GridView.builder(
                          scrollDirection: Axis.vertical,
                          shrinkWrap: true,
                          itemCount: countries.length,
                          physics: ClampingScrollPhysics(),
                          gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(crossAxisCount: 3, childAspectRatio: 0.86),

                          // gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                          //     crossAxisCount: 2, mainAxisExtent: 130),
                          itemBuilder: (context, index) {
                            return

                              // SingleChildScrollView(
                              //         child: Container(
                              //           padding: EdgeInsets.symmetric(horizontal: 16),
                              //           child: Column(
                              //             children: <Widget>[
                              //               ///Categories
                              //               Container(
                              //                   padding: EdgeInsets.symmetric(vertical: 16),
                              //                   height: 100,
                              //                   child: ListView.builder(
                              //                       itemCount: categories.length,
                              //                       shrinkWrap: true,
                              //                       scrollDirection: Axis.horizontal,
                              //                       itemBuilder: (context, index) {
                              //                         return
                              CountryGrid(
                                name: countries[index].countryName,
                                id: countries[index].id,
                              );
                          })),
                ),
              ],
            ),
          ),
          //
          //         ///Blogs
          //         // Container(
          //         //   margin: const EdgeInsets.only(top: 16),
          //         //   child: ListView.builder(
          //         //       itemCount: articles.length,
          //         //       shrinkWrap: true,
          //         //       physics: ClampingScrollPhysics(),
          //         //       itemBuilder: (context, index) {
          //         //         return BlogTile(
          //         //           imageUrl: articles[index].urlToImage ?? '',
          //         //           title: articles[index].title ?? '',
          //         //           desc: articles[index].description ?? '',
          //         //           url: articles[index].url ?? '',
          //         //         );
          //         //       }),
          //         // )
          //       ],
          //     ),
          //   ),
          // )),
        ));
  }
}

class CountryGrid extends StatelessWidget {
  final name, id;
  CountryGrid({this.name, this.id});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(left: 5.0, right: 5.0, top: 10.0),
      child: GestureDetector(
        onTap: () {
          Navigator.push(
              context,
              MaterialPageRoute(
                  builder: (context) => CountryNews(
                    country: id, name: name,
                  )));
        },
        child: Container(
          width: 100.0,
          decoration: const BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.all(Radius.circular(5.0)),
            // boxShadow: [
            //   BoxShadow(
            //     color: Colors.grey,
            //     blurRadius:
            //     5.0,
            //     spreadRadius:
            //     1.0,
            //     offset: Offset(
            //       1.0,
            //       1.0,
            //     ),
            //   )
            // ],
          ),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              Hero(
                tag: id,
                child: Container(
                  height: 60.0,
                  width: 100.0,
                  decoration: BoxDecoration(
                      image: DecorationImage(
                          image: AssetImage("assets/flags/$id.svg.png"),
                          //fit: BoxFit.cover
                      )
                  ),

                ),
              ),
              Container(
                padding: EdgeInsets.only(left:10.0, right: 10.0, top: 15.0, bottom: 15.0),
                child: Text(name,
                  textAlign: TextAlign.center,
                  maxLines: 2,
                  style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 12.0
                  ),),
              ),
            ],
          ),
        ),
      ),
    );

    // return GestureDetector(
    //   onTap: () {
    //     Navigator.push(
    //         context,
    //         MaterialPageRoute(
    //             builder: (context) => CategoryNews(
    //               category: categoryName.toLowerCase(),
    //             )));
    //   },
    //   child: Container(
    //     margin: EdgeInsets.only(right: 16),
    //     child: Stack(
    //       children: <Widget>[
    //         ClipRRect(
    //           borderRadius: BorderRadius.circular(6),
    //           child: CachedNetworkImage(
    //             imageUrl: imageUrl,
    //             width: 120,
    //             height: 60,
    //             fit: BoxFit.cover,
    //           ),
    //         ),
    //         Container(
    //           alignment: Alignment.center,
    //           width: 120,
    //           height: 60,
    //           decoration: BoxDecoration(
    //             borderRadius: BorderRadius.circular(6),
    //             color: Colors.black26,
    //           ),
    //           child: Text(categoryName,
    //               style: TextStyle(
    //                   color: Colors.white,
    //                   fontSize: 14,
    //                   fontWeight: FontWeight.w500)),
    //         )
    //       ],
    //     ),
    //   ),
    // );
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
