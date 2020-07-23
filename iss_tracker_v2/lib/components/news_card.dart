import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:iss_tracker_v2/components/news_posts.dart';
import 'package:http/http.dart' as http;
import 'package:iss_tracker_v2/components/settings.dart';
import 'package:url_launcher/url_launcher.dart';


class NewsCard extends StatefulWidget {
  @override
  _NewsCardState createState() => _NewsCardState();
}


class _NewsCardState extends State<NewsCard> {
  final String newsUrl = 'https://spaceflightnewsapi.net/api/v1/articles';
  bool _isLoaded = false;
  NewsPosts newsPosts;

  @override
  void initState() { 
    _fetchNewsPosts().then((value) {
      setState(() {
        newsPosts = value;
        _isLoaded = true;
      });
    });
    super.initState();
  }

  Future<NewsPosts> _fetchNewsPosts() async {
    final response = await http.get(newsUrl);

    if (response.statusCode == 200) {
      return NewsPosts.fromJson(json.decode(response.body));
    } else {
      throw Exception('Failed to load news articles');
    }
  }

  Container loadingIndicator() {
    return Container(
      decoration: BoxDecoration(
        gradient: LinearGradient(
          begin: Alignment.topCenter,
          end: Alignment.bottomCenter,
          colors: Settings.isLightTheme ? [Colors.blueGrey[400], Colors.pink[200]]
            : [Colors.black87, Colors.black],
        )
      ),
      child: Center(child: CircularProgressIndicator(),),
    );
  }

  @override
  Widget build(BuildContext context) {
    return !_isLoaded ?  loadingIndicator() :
    ListView.builder(
      itemCount: newsPosts.docs.length,
      itemBuilder: (BuildContext context, int index) {
        return AspectRatio(
          aspectRatio: 5/2,
          child: GestureDetector(
            onTap: () async {
              String url = newsPosts.docs[index].url;
              if (await canLaunch(url)) {
                await launch(url);
              } else {
                throw 'Could not launch $url';
              }
            },
            child: Card(
              color: Colors.transparent,
              elevation: 2,
              child: Container(
                margin: const EdgeInsets.all(6.0),
                padding: const EdgeInsets.all(6.0),
                child: Column(
                  children: <Widget>[
                    Expanded(
                      flex: 3,
                      child: Row(
                        children: <Widget>[
                          Expanded(
                            flex: 3,
                            child: Image.network(newsPosts.docs[index].featuredImage),
                          ),
                          Expanded(
                            flex: 3,
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              mainAxisAlignment: MainAxisAlignment.start,
                              children: <Widget>[
                                Text(
                                  '${newsPosts.docs[index].title}',
                                  style: TextStyle(
                                    fontWeight: FontWeight.bold,
                                    fontFamily: 'WorkSans',
                                    color: Colors.white
                                  ),
                                  textAlign: TextAlign.start,
                                )
                              ],
                            )
                          ),
                        ]
                      ),
                    ),
                    Divider(color: Colors.grey,),
                    Row(
                      children: <Widget>[
                        Text(
                          'Site: ${newsPosts.docs[index].newsSiteLong}',
                          overflow: TextOverflow.ellipsis,
                          style: TextStyle(
                            color: Colors.white60
                          ),
                        ),
                        Spacer(),
                        Text(
                          '${newsPosts.docs[index].publishedDate.toString().substring(0, newsPosts.docs[index].publishedDate.toString().length - 8)}',
                          style: TextStyle(
                            color: Colors.white60
                          ),
                          textAlign: TextAlign.end,
                        ),
                      ],
                    )
                  ],
                ),
              )
            ),
          ),
        );
      },
    );
  }
}