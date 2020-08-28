import 'dart:convert';
import 'package:clay_containers/widgets/clay_containers.dart';
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
    Settings.getLightMode();

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

  Center loadingIndicator() {
    return Center(child: CircularProgressIndicator(),);
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
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: ClayContainer(
                  depth: 50,
                  spread: Settings.isLightTheme ? 5 : 3,
                  color: Settings.isLightTheme ? Colors.white : Color(0xFF121212),
                  emboss: index % 2 == 1 ? false : true,
                  borderRadius: 10,
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
                                        color: Settings.isLightTheme ? Colors.black : Colors.white,
                                      ),
                                      overflow: TextOverflow.ellipsis,
                                      maxLines: 5,
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
                                color: Settings.isLightTheme ? Colors.black : Colors.white60,
                              ),
                            ),
                            Spacer(),
                            Text(
                              '${newsPosts.docs[index].publishedDate.toString().substring(0, newsPosts.docs[index].publishedDate.toString().length - 8)}',
                              style: TextStyle(
                                color: Settings.isLightTheme ? Colors.black : Colors.white60,
                              ),
                              textAlign: TextAlign.end,
                            ),
                          ],
                        )
                      ],
                    ),
                  ),
                ),
              )
            
          ),
        );
      },
    );
  }
}