import 'package:flutter/material.dart';
import 'package:ionicons/ionicons.dart';

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

  bool listView = false;

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
                    // Padding(
                    //   padding: const EdgeInsets.fromLTRB(0, 16, 0, 0),
                    //   child: ListTile(
                    //     // leading: IconButton(
                    //     //   icon: Icon(
                    //     //     listView ? Ionicons.list_outline : Ionicons.albums_outline,
                    //     //     size: 40,
                    //     //   ),
                    //     //   onPressed: () {
                    //     //     setState(() {
                    //     //       listView = !listView;
                    //     //     });
                    //     //   },
                    //     // ),
                    //     trailing: Padding(
                    //       padding: const EdgeInsets.only(bottom: 8.0),
                    //       child: IconButton(
                    //         icon: Icon(
                    //           listView
                    //               ? Ionicons.list_outline
                    //               : Ionicons.albums_outline,
                    //           size: 30,
                    //         ),
                    //         onPressed: () {
                    //           setState(() {
                    //             listView = !listView;
                    //           });
                    //         },
                    //       ),
                    //     ),
                    //   ),
                    // ),
                    listView
                        ?

                        ///Blogs
                        Container(
                          padding: EdgeInsets.symmetric(horizontal: 16),
                            margin: const EdgeInsets.only(top: 16),
                            child: ListView.builder(
                                itemCount: articles.length,
                                shrinkWrap: true,
                                physics: ClampingScrollPhysics(),
                                itemBuilder: (context, index) {
                                  return BlogTile(
                                    imageUrl: articles[index].urlToImage ?? '',
                                    title: articles[index].title ?? '',
                                    desc: articles[index].description ?? '',
                                    url: articles[index].url ?? '',
                                  );
                                }),
                          )
                        : Container(
                            padding: EdgeInsets.symmetric(horizontal: 16),
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
//   final String imageUrl, title, desc, url, date, author, content;
//   BlogTileList(
//       {required this.imageUrl,
//         required this.title,
//         required this.desc,
//         required this.url,
//         required this.date,
//         required this.content,
//         required this.author});
//
//   @override
//   Widget build(BuildContext context) {
//     return GestureDetector(
//       onTap: () {
//         Navigator.push(
//             context,
//             MaterialPageRoute(
//                 builder: (context) => ArticleView(
//                       blogUrl: url,
//                     )));
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
