import 'package:flutter/material.dart';
import 'package:flutternews/helper/countries.dart';
import 'package:flutternews/models/article_model.dart';
import 'package:flutternews/views/article_view.dart';

import '../helper/news.dart';
import '../models/country_model.dart';
import 'country_news.dart';

class CountryPage extends StatefulWidget {
  const CountryPage({Key? key}) : super(key: key);

  @override
  State<CountryPage> createState() => _CountryPageState();
}

class _CountryPageState extends State<CountryPage> {

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
                const ListTile(
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
                          itemBuilder: (context, index) {
                            return CountryGrid(
                                name: countries[index].countryName,
                                id: countries[index].id,
                              );
                          })),
                ),
              ],
            ),
          ),
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
  }
}
