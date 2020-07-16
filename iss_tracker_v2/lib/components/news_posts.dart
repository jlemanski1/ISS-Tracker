import 'package:meta/meta.dart';
import 'dart:convert';


class NewsPosts {
    NewsPosts({
        @required this.docs,
        @required this.totalDocs,
        @required this.limit,
        @required this.totalPages,
        @required this.page,
        @required this.pagingCounter,
        @required this.hasPrevPage,
        @required this.hasNextPage,
        @required this.prevPage,
        @required this.nextPage,
    });

    final List<Doc> docs;
    final int totalDocs;
    final int limit;
    final int totalPages;
    final int page;
    final int pagingCounter;
    final bool hasPrevPage;
    final bool hasNextPage;
    final dynamic prevPage;
    final int nextPage;

    factory NewsPosts.fromRawJson(String str) => NewsPosts.fromJson(json.decode(str));

    String toRawJson() => json.encode(toJson());

    factory NewsPosts.fromJson(Map<String, dynamic> json) => NewsPosts(
        docs: List<Doc>.from(json["docs"].map((x) => Doc.fromJson(x))),
        totalDocs: json["totalDocs"],
        limit: json["limit"],
        totalPages: json["totalPages"],
        page: json["page"],
        pagingCounter: json["pagingCounter"],
        hasPrevPage: json["hasPrevPage"],
        hasNextPage: json["hasNextPage"],
        prevPage: json["prevPage"],
        nextPage: json["nextPage"],
    );

    Map<String, dynamic> toJson() => {
        "docs": List<dynamic>.from(docs.map((x) => x.toJson())),
        "totalDocs": totalDocs,
        "limit": limit,
        "totalPages": totalPages,
        "page": page,
        "pagingCounter": pagingCounter,
        "hasPrevPage": hasPrevPage,
        "hasNextPage": hasNextPage,
        "prevPage": prevPage,
        "nextPage": nextPage,
    };
}

class Doc {
    Doc({
        @required this.datePublished,
        @required this.dateAdded,
        @required this.tags,
        @required this.categories,
        @required this.featured,
        @required this.launches,
        @required this.events,
        @required this.ll,
        @required this.id,
        @required this.newsSite,
        @required this.newsSiteLong,
        @required this.title,
        @required this.url,
        @required this.docId,
        @required this.featuredImage,
        @required this.publishedDate,
        @required this.importedDate,
    });

    final int datePublished;
    final int dateAdded;
    final List<String> tags;
    final List<String> categories;
    final bool featured;
    final List<dynamic> launches;
    final List<dynamic> events;
    final List<dynamic> ll;
    final String id;
    final String newsSite;
    final String newsSiteLong;
    final String title;
    final String url;
    final dynamic docId;
    final String featuredImage;
    final DateTime publishedDate;
    final DateTime importedDate;

    factory Doc.fromRawJson(String str) => Doc.fromJson(json.decode(str));

    String toRawJson() => json.encode(toJson());

    factory Doc.fromJson(Map<String, dynamic> json) => Doc(
        datePublished: json["date_published"],
        dateAdded: json["date_added"],
        tags: List<String>.from(json["tags"].map((x) => x)),
        categories: List<String>.from(json["categories"].map((x) => x)),
        featured: json["featured"],
        launches: List<dynamic>.from(json["launches"].map((x) => x)),
        events: List<dynamic>.from(json["events"].map((x) => x)),
        ll: List<dynamic>.from(json["ll"].map((x) => x)),
        id: json["_id"],
        newsSite: json["news_site"],
        newsSiteLong: json["news_site_long"],
        title: json["title"],
        url: json["url"],
        docId: json["id"],
        featuredImage: json["featured_image"],
        publishedDate: DateTime.parse(json["published_date"]),
        importedDate: DateTime.parse(json["imported_date"]),
    );

    Map<String, dynamic> toJson() => {
        "date_published": datePublished,
        "date_added": dateAdded,
        "tags": List<dynamic>.from(tags.map((x) => x)),
        "categories": List<dynamic>.from(categories.map((x) => x)),
        "featured": featured,
        "launches": List<dynamic>.from(launches.map((x) => x)),
        "events": List<dynamic>.from(events.map((x) => x)),
        "ll": List<dynamic>.from(ll.map((x) => x)),
        "_id": id,
        "news_site": newsSite,
        "news_site_long": newsSiteLong,
        "title": title,
        "url": url,
        "id": docId,
        "featured_image": featuredImage,
        "published_date": publishedDate.toIso8601String(),
        "imported_date": importedDate.toIso8601String(),
    };
}