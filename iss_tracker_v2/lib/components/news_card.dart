import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:iss_tracker_v2/components/news_posts.dart';
import 'package:http/http.dart' as http;
import 'package:iss_tracker_v2/components/wiki_page.dart';



class NewsCard extends StatefulWidget {
  @override
  _NewsCardState createState() => _NewsCardState();
}


class _NewsCardState extends State<NewsCard> {
  final String newsUrl = 'https://spaceflightnewsapi.net/api/v1/articles';
  NewsPosts newsPosts;

  @override
  void initState() { 
    _fetchNewsPosts().then((value) {
      setState(() {
        newsPosts = value;
      });
    });
    print('News Posts: $newsPosts');
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

  @override
  Widget build(BuildContext context) {
    return AspectRatio(
      aspectRatio: 5/2,
      child: Card(
        elevation: 2,
        child: Container(
          margin: const EdgeInsets.all(4.0),
          padding: const EdgeInsets.all(4.0),
          child: Column(
            children: <Widget>[
              Text('Teeest'),
              _Post(),
              Divider(color: Colors.grey,),
              _PostDetails(),
            ],
          ),
        )
      ),
    );
  }
}


class _Post extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Expanded(
      flex: 3,
      child: Row(
        children: <Widget>[
          _PostImage(),
          _PostTitleAndSummary(),
        ],
      ),
    );
  }
}


class _PostImage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Expanded(
      flex: 2,
      child: Image.asset(''),
    );
  }
}

class _PostTitleAndSummary extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final String title = 'Title';
    final String summary = 'Summary...';
    
    return Expanded(
      flex: 3,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.start,
        children: <Widget>[
          Text(title),
          SizedBox(height: 2.0),
          Text(summary),
        ],
      )
    );
  }
}


class _PostDetails extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Row(
      children: <Widget>[
        _Author(),
        _DatePosted(),
      ],
    );
  }
}


class _Author extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Expanded(
      flex: 1,
      child: Text('Author'),
    );
  }
}


class _DatePosted extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Expanded(
      flex: 1,
      child: Text('Date Posted'),
    );
  }
}