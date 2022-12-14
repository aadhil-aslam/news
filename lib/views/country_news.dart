import 'package:flutter/material.dart';

import '../helper/news.dart';
import '../models/article_model.dart';
import 'article_view.dart';
import 'newlist.dart';

class CountryNews extends StatefulWidget {
  final String country, name;
  CountryNews({required this.country, required this.name});

  @override
  State<CountryNews> createState() => _CountryNewsState();
}

class _CountryNewsState extends State<CountryNews> {

  List<ArticleModel> articles = [];
  bool _loading = true;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    getCountryNews();
  }

  getCountryNews() async {
    CountryNewsClass newsClass = CountryNewsClass();
    await newsClass.getNews(widget.country);
    articles = newsClass.news;
    setState(() {
      _loading = false;
    });
  }

  bool listView = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[200],
      appBar: AppBar(
        backgroundColor: Colors.red[700],
        title: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Text(
              ("${widget.name}"),
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
          padding: EdgeInsets.symmetric(horizontal: 16),
          child: Column(
            children: <Widget>[
              ///Blogs
              Container(
                margin: const EdgeInsets.only(top: 16),
                child: ListView.builder(
                    itemCount: articles.length,
                    shrinkWrap: true,
                    physics: ClampingScrollPhysics(),
                    itemBuilder: (context, index) {
                      return BlogTileList(
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

// class BlogTileList extends StatelessWidget {
//   final String imageUrl, title, desc, url;
//   BlogTileList(
//       {required this.imageUrl,
//         required this.title,
//         required this.desc,
//         required this.url});
//
//   @override
//   Widget build(BuildContext context) {
//     return GestureDetector(
//       onTap: () {
//         Navigator.push(
//             context,
//             MaterialPageRoute(
//                 builder: (context) => ArticleView(
//                   blogUrl: url,
//                 )));
//       },
//       child: Padding(
//         padding: const EdgeInsets.symmetric(vertical: 6.0),
//         child: Row(
//           crossAxisAlignment: CrossAxisAlignment.start,
//           children: <Widget>[
//             Expanded(
//               flex: 2,
//               child: ClipRRect(
//                 child: Container(
//                   padding: EdgeInsets.only(right: 10),
//                   child: Image.network(
//                     imageUrl ?? '',
//                     width: 100,
//                     height: 90,
//                     fit: BoxFit.cover,
//                   ),
//                 ),
//               ),
//             ),
//             Expanded(
//               flex: 3,
//               child: Padding(
//                 padding: const EdgeInsets.fromLTRB(5.0, 0.0, 5.0, 0.0),
//                 child: Column(
//                   crossAxisAlignment: CrossAxisAlignment.start,
//                   children: <Widget>[
//                     Text(title,
//                         style: const TextStyle(
//                             fontSize: 14, fontWeight: FontWeight.w500),
//                         maxLines: 3),
//                     const Padding(padding: EdgeInsets.symmetric(vertical: 2.0)),
//                     Text(desc, style: TextStyle(fontSize: 12), maxLines: 2),
//                   ],
//                 ),
//               ),
//             ),
//             // const Icon(
//             //   Icons.more_vert,
//             //   size: 16.0,
//             // ),
//           ],
//         ),
//       ),
//     );
//   }
// }