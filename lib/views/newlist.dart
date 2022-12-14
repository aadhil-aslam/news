import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:timeago/timeago.dart' as timeago;
import 'article_view.dart';

class BlogTileList extends StatelessWidget {
  final String imageUrl, title, desc, url, date, author, content;
  BlogTileList(
      {required this.imageUrl,
      required this.title,
      required this.desc,
      required this.url,
      required this.date,
      required this.content,
      required this.author});

  @override
  Widget build(BuildContext context) {
    //getCategories();
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
        padding: const EdgeInsets.symmetric(vertical: 4.0),
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
                              fontSize: 13, fontWeight: FontWeight.w500),
                          maxLines: 3,
                        ),
                        const Padding(padding: EdgeInsets.only(top: 8.0)),
                        // Text(desc, style: TextStyle(fontSize: 12), maxLines: 2),
                        // const Padding(padding: EdgeInsets.symmetric(vertical: 2.0)),
                        Text(desc, style: TextStyle(fontSize: 11), maxLines: 2),
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                              //mainAxisAlignment: MainAxisAlignment.end,
                              children: <Widget>[
                                Divider(color: Colors.black26),
                                Text(timeUntil(DateTime.parse(date)),
                                    style: TextStyle(fontSize: 11)),
                              ]),
                        )
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
