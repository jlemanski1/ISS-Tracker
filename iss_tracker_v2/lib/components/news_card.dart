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
    return Container(
      
    );
  }
}


class _PostDetails extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      
    );
  }
}