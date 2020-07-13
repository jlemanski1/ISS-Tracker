/*
    Fetches wiki page for a given search term to extract an image url for each Astronaut
    shown on the Astronauts page, on their respective tiles.
*/

import 'dart:io';
import 'package:http/http.dart' as http;
import 'package:meta/meta.dart';
import 'dart:convert';


class WikiPhoto {

  // Returns the WikiPage for the given url
  static Future<WikiPage> fetchWikiPage(url) async {
    final response = await http.get(url);

    if (response.statusCode == 200) {
      // Server returns OK response, parse data
      return WikiPage.fromJson(json.decode(response.body));
    } else {
      throw HttpException(
        'Unexpected status code ${response.statusCode}: ${response.reasonPhrase}',
        uri: Uri.parse(url)
      );
    }
  }


  // Returns the article image of a given wikipedia url
  static Future<String> fetchWikiPhoto(url) async {
    final response = await http.get(url);

    if (response.statusCode == 200) {
      //Server returns OK response, parse data
      WikiPage _page = await fetchWikiPage(url);
      String _imgUrl = _page.query.pages[0].thumbnail.source;

      return _imgUrl;
    } else {
      throw HttpException(
        'Unexpected status code ${response.statusCode}: ${response.reasonPhrase}',
        uri: Uri.parse(url)
      );
    }
  }


}

class WikiPage {
  
    WikiPage({
        @required this.batchcomplete,
        @required this.query,
    });

    final bool batchcomplete;
    final Query query;

    factory WikiPage.fromRawJson(String str) => WikiPage.fromJson(json.decode(str));

    String toRawJson() => json.encode(toJson());

    factory WikiPage.fromJson(Map<String, dynamic> json) => WikiPage(
        batchcomplete: json["batchcomplete"],
        query: Query.fromJson(json["query"]),
    );

    Map<String, dynamic> toJson() => {
        "batchcomplete": batchcomplete,
        "query": query.toJson(),
    };
}

class Query {
    Query({
        @required this.redirects,
        @required this.pages,
    });

    final List<Redirect> redirects;
    final List<Page> pages;

    factory Query.fromRawJson(String str) => Query.fromJson(json.decode(str));

    String toRawJson() => json.encode(toJson());

    factory Query.fromJson(Map<String, dynamic> json) => Query(
        redirects: List<Redirect>.from(json["redirects"].map((x) => Redirect.fromJson(x))),
        pages: List<Page>.from(json["pages"].map((x) => Page.fromJson(x))),
    );

    Map<String, dynamic> toJson() => {
        "redirects": List<dynamic>.from(redirects.map((x) => x.toJson())),
        "pages": List<dynamic>.from(pages.map((x) => x.toJson())),
    };
}

class Page {
    Page({
        @required this.pageid,
        @required this.ns,
        @required this.title,
        @required this.index,
        @required this.thumbnail,
        @required this.terms,
    });

    final int pageid;
    final int ns;
    final String title;
    final int index;
    final Thumbnail thumbnail;
    final Terms terms;

    factory Page.fromRawJson(String str) => Page.fromJson(json.decode(str));

    String toRawJson() => json.encode(toJson());

    factory Page.fromJson(Map<String, dynamic> json) => Page(
        pageid: json["pageid"],
        ns: json["ns"],
        title: json["title"],
        index: json["index"],
        thumbnail: Thumbnail.fromJson(json["thumbnail"]),
        terms: Terms.fromJson(json["terms"]),
    );

    Map<String, dynamic> toJson() => {
        "pageid": pageid,
        "ns": ns,
        "title": title,
        "index": index,
        "thumbnail": thumbnail.toJson(),
        "terms": terms.toJson(),
    };
}

class Terms {
    Terms({
        @required this.description,
    });

    final List<String> description;

    factory Terms.fromRawJson(String str) => Terms.fromJson(json.decode(str));

    String toRawJson() => json.encode(toJson());

    factory Terms.fromJson(Map<String, dynamic> json) => Terms(
        description: List<String>.from(json["description"].map((x) => x)),
    );

    Map<String, dynamic> toJson() => {
        "description": List<dynamic>.from(description.map((x) => x)),
    };
}

class Thumbnail {
    Thumbnail({
        @required this.source,
        @required this.width,
        @required this.height,
    });

    final String source;
    final int width;
    final int height;

    factory Thumbnail.fromRawJson(String str) => Thumbnail.fromJson(json.decode(str));

    String toRawJson() => json.encode(toJson());

    factory Thumbnail.fromJson(Map<String, dynamic> json) => Thumbnail(
        source: json["source"],
        width: json["width"],
        height: json["height"],
    );

    Map<String, dynamic> toJson() => {
        "source": source,
        "width": width,
        "height": height,
    };
}

class Redirect {
    Redirect({
        @required this.index,
        @required this.from,
        @required this.to,
    });

    final int index;
    final String from;
    final String to;

    factory Redirect.fromRawJson(String str) => Redirect.fromJson(json.decode(str));

    String toRawJson() => json.encode(toJson());

    factory Redirect.fromJson(Map<String, dynamic> json) => Redirect(
        index: json["index"],
        from: json["from"],
        to: json["to"],
    );

    Map<String, dynamic> toJson() => {
        "index": index,
        "from": from,
        "to": to,
    };
}
