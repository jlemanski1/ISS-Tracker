import 'package:flutter/material.dart';


class NewsCard extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return AspectRatio(
      aspectRatio: 5/2,
      child: Card(
        child: Column(
          children: <Widget>[
            _Post(),
            _PostDetails(),
          ],
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